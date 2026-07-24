# Draft: Bounded Reference Field

> **Status: DRAFT FOR REVIEW.**
>
> This document records a proposed bounded capability. It is not an implemented
> contract or an active production path. Do not implement it until the remaining
> review points are resolved and repository evidence is rechecked.

## Purpose

Stabilize the existing `Reference` form field as a deliberately narrow,
domain-neutral field that works within the current form and repeat flow.

The initial use needs rapid entry:

1. shared answers remain outside a repeat and are entered once;
2. one referenced item is selected or created inside each repeat row;
3. the user saves the row and immediately adds the next one;
4. each saved repeat stores only the referenced item's UID.

The field and catalog must not be named after a current campaign concept such
as a household or person. Those meanings come from localized form labels and
may change without changing the implementation.

## Locked Direction

The reference field:

- reads an offline catalog synchronized for org units available through the
  user's current assignments;
- displays a server-authoritative name;
- stores only an 11-character UID in `formData`;
- supports deliberate offline creation using only a name;
- works in ordinary fields, repeats, and nested repeats;
- preserves the generated UID through repeat edits and upload retries;
- carries no targeting, completion, coverage, workflow, or analytical state.

The minimal reference identity is:

```text
uid
displayName
orgUnitUid
```

`orgUnitUid` owns catalog scope. An assignment supplies authorized access and
the current activity context; it is not catalog identity.

The mobile must not add:

- `source`;
- `pendingCreate`;
- `available`;
- `lastSeenSyncRun`;
- a synchronization-state enum;
- a domain type such as household or person;
- a submission-level subject column;
- a generic resource/provider registry.

## Repository Evidence

### Existing form shape

`ValueType.Reference` exists in the mobile and server form models:

- `lib/database/shared/value_type.dart`;
- `lib/core/form/builder/form_element_control_builder.dart`;
- `lib/core/form/builder/form_element_builder.dart`;
- server `datatemplateelement/enumeration/ValueType.java`.

The active mobile builders already represent it as:

```text
FieldInstance<String>
FormControl<String>
```

That supports the intended UID-only form value without changing whole-JSON
submission persistence.

### Existing implementation classification

The widget at
`lib/features/form_submission/presentation/field/reference_search/q_reference_drop_down_search_field.widget.dart`
is **INCOMPLETE**, with high confidence. It:

- watches `systemMetadataSubmissionsProvider`;
- depends on `MetadataSubmissionUpdate`;
- hardcodes old campaign field names;
- uses an empty provider;
- does not establish stable UID-backed selection behavior.

No captured production form under `test/fixtures/live_forms/` currently uses a
`Reference` field. The only identified use is in the legacy ITN fixture, and
the captured saved data does not establish a working reference value.

The ordinary form factory, control, validation, repeat edit, and whole-JSON
save paths are active. Replacing the incomplete reference implementation must
not change those paths for other field types.

`resourceMetadataSchema`, metadata submissions, Party, and similarly named
surfaces are abandoned or incomplete paths. They are not compatibility
constraints for this work and must not be revived.

### Existing rapid entry

The legacy ITN shape confirms the intended interaction: shared work answers
are outside the repeat and item-specific answers are inside it.

The active repeat editor in
`lib/features/form_submission/presentation/section/repeat_table.widget.dart`
already supports `RepeatRowEditResult.savedAndAddAnother`. The bounded
reference field must use this existing flow rather than introduce a separate
queue, entry session, or subject workflow.

## Field Contract

### Form configuration

The existing field type is sufficient:

```json
{
  "type": "Reference",
  "name": "configuredReferenceField",
  "label": {
    "ar": "Campaign-specific label",
    "en": "Campaign-specific label"
  },
  "mandatory": true
}
```

Version 1 has exactly one reference source: the bounded org-unit catalog
described here. It has no `resourceType`, schema selector, provider dispatch,
or domain-specific mode.

### Runtime context

The active form metadata supplies the assignment. The mobile resolves that
assignment's org unit and queries the local catalog by `orgUnitUid`.

If assignment or org-unit context is missing, the field reports unsupported
configuration. It must not query a global list, guess scope, or read another
submission to infer context.

### Stored form value

The control and `formData` store only:

```json
"configuredReferenceField": "11-char-uid"
```

Inside a repeat:

```json
{
  "_id": "repeat-row-id",
  "configuredReferenceField": "referenced-item-uid"
}
```

The repeat `_id` identifies the repeat row. The reference value identifies the
catalog item. Creating, reopening, or editing a row must never replace one with
the other.

### Existing selection

Selecting an existing item:

1. resolves a catalog row under the current org unit;
2. writes only its UID to the control;
3. does not insert another catalog row;
4. visibly restores the same selection when the repeat is reopened.

### Local creation

Creating a missing item:

1. is an explicit secondary action in the reference field;
2. requires a non-empty display name;
3. generates one 11-character UID on the client;
4. inserts `uid`, `displayName`, and `orgUnitUid` into the local catalog;
5. selects that UID in the field;
6. persists the UID when the repeat row is saved.

The UID is generated once and remains unchanged through edit, restart, retry,
and eventual server acceptance.

The local catalog does not record whether a row came from the server or was
created on the device. Upload sends definitions for referenced values
regardless of origin, and the server resolves existence idempotently.

### Validation

- An optional reference accepts null.
- A mandatory reference rejects null or an empty value.
- A populated reference must satisfy the same 11-character UID contract used
  by the client and server.
- Local creation requires a non-empty name.
- Hidden-field clearing and mandatory reactivation follow the established form
  engine behavior.
- A saved repeat reopens with the selected display value, and opening the
  picker shows that value selected.

The field does not reject the same UID appearing in multiple repeat rows.
Duplicate use is a campaign or analytical rule, not an identity rule.

### Missing local display row

If saved `formData` contains a reference UID absent from the local cache:

- preserve the UID;
- do not silently clear or replace it;
- show a neutral fallback containing a shortened UID;
- do not offer the missing row as a new selectable option.

During upload, the server may still accept the UID if it already exists there.
If both the server and local catalog lack it, upload fails with an explicit
reference-resolution error because a new server record cannot be created
without its name.

## Mobile Persistence

Add one per-user offline read projection:

```text
reference_entries
  uid
  orgUnitUid
  displayName

primary key: uid
search index: orgUnitUid + displayName
```

UID is globally unique. The same item is reused across assignments and
campaigns without duplicating rows by assignment.

The table has no foreign key to submissions. Removing or refreshing catalog
rows must never cascade into `formData`.

No normalized-name column is added initially. Search behavior should be
measured with a representative production-sized list before another persisted
projection is justified.

This is the only proposed mobile persistence migration.

## Catalog Synchronization

### Read endpoint

Provide an authenticated, paginated endpoint queried through an assignment or
equivalent authorized activity context. The server:

- validates the current user's assignment access;
- derives the activity and org unit;
- returns the catalog for that org unit;
- never accepts client-supplied org-unit authority;
- returns only UID and display name to the mobile;
- returns no targeting, submission, coverage, or workflow state.

Illustrative response:

```json
{
  "items": [
    {
      "uid": "11-char-uid",
      "name": "Display name"
    }
  ],
  "nextCursor": null
}
```

### Upsert-only client projection

Version 1 catalog synchronization is intentionally upsert-only:

1. fetch one page;
2. upsert its UID/name rows under the server-derived org unit in a bounded
   transaction;
3. continue until the cursor is exhausted;
4. retain successfully received pages if a later page fails;
5. retry from the appropriate cursor or restart idempotently.

Existing local rows are not removed merely because a fetch did not return
them. This avoids `available`, run markers, staging tables, replacement
transactions, and accidental loss after interrupted synchronization.

The corresponding version 1 server catalog is therefore append/upsert
oriented:

- a name correction for a known UID may update the local display projection;
- individual server deletion, revocation, and historical absence are not
  modeled by this capability;
- assignment access determines whether the user can enter the workflow;
- removing an assignment can make its workflow unreachable without deleting
  catalog identity or existing form values.

If future product requirements need individual catalog revocation, that is a
new explicit contract. It must not be approximated through failed-fetch
absence.

### Local queries

The field queries:

```text
orgUnitUid + display-name search
```

Results are limited or paginated. The widget must not materialize the complete
catalog on each rebuild or keystroke.

## Submission Upload Boundary

### No separate ensure workflow

There is no separate reference-create/ensure endpoint and no durable mobile
outbox for catalog rows.

Each submission upload may carry an optional transport-only collection:

```json
{
  "...existingSubmissionFields": "...",
  "referenceDefinitions": [
    {
      "uid": "11-char-uid",
      "name": "Display name"
    }
  ]
}
```

`referenceDefinitions`:

- is optional, so existing clients and non-reference submissions remain
  compatible;
- is not stored in mobile `DataInstances`;
- is not stored in the server submission entity or `formData`;
- is reconstructed on every retry from the pinned form version, `formData`,
  and local catalog;
- contains definitions for all resolvable referenced UIDs, without classifying
  them as local or imported.

This is a request-contract addition, not a persisted submission-envelope
change.

### Mobile preparation

For every submission selected for upload, the mobile:

1. loads its pinned form version;
2. identifies `Reference` element paths;
3. extracts UID values, including values inside nested repeats;
4. resolves available display names from `reference_entries`;
5. attaches deduplicated UID/name definitions to that submission request;
6. sends the request through the existing upload boundary.

A known server UID may upload even if its local display row is missing. An
unknown UID without a supplied name is rejected clearly by the server.

### Server resolution

For each submitted reference UID, the server:

1. validates the submission assignment and derives its activity and org unit;
2. uses the pinned template version and `formData` to identify actual
   `Reference` values;
3. treats `referenceDefinitions` only as names for those actual values;
4. ignores or rejects definitions not used by the submission;
5. finds each UID in the canonical catalog;
6. accepts a known UID in the authorized org unit without overwriting its name
   or registration lineage;
7. creates an unknown UID only when a non-empty definition is supplied;
8. rejects a UID already owned by another org unit;
9. saves reference creation and submission acceptance atomically.

The first implementation retains the current bulk failure semantics rather
than inventing partial mobile success handling in this feature. A failed
request leaves local submissions finalized and retryable with the same UIDs.

## Minimal Server Persistence And Lineage

The canonical server record needs:

```text
uid
displayName
orgUnitUid
firstRegisteredActivityUid
```

The server's existing JPA identifiable base already supplies:

```text
createdBy
createdDate
lastModifiedBy
lastModifiedDate
```

No `source` column is needed.

### First-registration contract

When the server resolves a submitted UID:

- if the UID already exists, return or internally record `existing` and
  preserve all first-registration and creation audit fields;
- if the UID does not exist, create it under the server-derived org unit,
  set immutable `firstRegisteredActivityUid` from the validated assignment,
  and let existing auditing set `createdBy` and `createdDate`;
- retries find the same UID and must not rewrite first-registration lineage;
- later use in another activity does not change the first activity.

This provides light lineage:

- creation versus prior existence is known at server upsert time;
- `firstRegisteredActivityUid` identifies the first recorded activity;
- `createdBy` identifies the authenticated creator or importer;
- `createdDate` identifies when the server first accepted it.

The mobile does not persist or display lineage in version 1. If offline
lineage display later becomes a real requirement, it needs a separately
approved read projection rather than silently expanding this cache.

### Imports and older campaigns

An import from an identifiable earlier campaign must:

- preserve or generate the canonical 11-character UID;
- set that campaign as `firstRegisteredActivityUid`;
- use a deterministic migration/system audit identity;
- never attribute imported records to the first activity that merely
  synchronizes them to a mobile device.

If historical origin cannot be established, the first activity remains null
rather than recording false lineage. New client-created records always receive
the current validated activity.

## Production Compatibility

Current production clients contain an incomplete `Reference` path and could
show an empty selector. A form requiring the corrected field must not be made
available to clients that lack the implementation.

Before campaign activation, use one explicit gate:

1. Prefer client capability or minimum supported app-build filtering when
   returning assignment forms.
2. Otherwise prove that every assigned field device has upgraded before
   enabling the form.

Existing form and submission payloads without references or definitions remain
valid. Existing production database rows are preserved by an additive mobile
migration.

## Bounded Delivery Plan

### 1. Contract characterization

- add a focused form fixture containing a required `Reference` inside a repeat;
- characterize existing incomplete widget/provider behavior before removal;
- align the mobile and server 11-character UID validation contract;
- characterize reference extraction through ordinary, repeat, and nested-repeat
  paths;
- confirm the production list-size expectation and search behavior.

### 2. Server foundation, disabled

- add the neutral canonical catalog and immutable first-registration activity;
- reuse existing JPA audit ownership;
- add the access-scoped paginated read endpoint;
- accept optional per-submission `referenceDefinitions`;
- resolve actual template reference values and definitions atomically with
  submission save;
- test known, new, retry, wrong-org-unit, stale-name, unknown-without-name,
  unused-definition, import-lineage, and existing-client payload cases;
- keep the capability disabled until the mobile is ready.

### 3. Mobile schema and catalog boundary

- add `reference_entries`;
- test production schema upgrades while preserving submissions and
  configuration;
- add one catalog repository owning paginated pull, upsert-only persistence,
  and bounded search;
- test interrupted pagination, idempotent retry, name correction, and local-row
  preservation;
- do not register a second generic metadata or reference state owner.

### 4. Field replacement and upload integration

- replace the hardcoded metadata-submission reference widget and provider;
- query by the active assignment's org unit;
- display names while storing UIDs;
- add deliberate name-only local creation;
- preserve selection through save, reopen, edit, nested repeat, and restart;
- extract reference values from pinned templates;
- attach transient definitions through the existing upload service;
- remove superseded metadata-reference imports and files once no active
  references remain;
- smoke offline rapid entry on the Redmi baseline.

### 5. Campaign activation

- import existing catalog items with truthful prior-activity lineage;
- publish the campaign form using the bounded `Reference` field inside the
  existing repeat;
- keep shared work fields outside the repeat;
- enable the old-client gate;
- smoke first sync, offline search, local creation, save-and-add-another,
  nested repeat where applicable, draft/restart, finalization, failed upload
  retry, existing selection, and server lineage;
- enable field access only after all gates pass.

## Acceptance Gates

- Existing non-reference forms behave unchanged.
- Shared outer fields are entered once.
- Continuous repeat `save and add another` remains available.
- The field stores only a UID, never a name or object.
- The mobile catalog stores only UID, org unit, and display name.
- No domain name appears in implementation ownership.
- No source, pending, availability, run-marker, or workflow state is added.
- Selecting an existing item inserts no duplicate local row.
- Local creation generates one UID and preserves it through retry and edit.
- A saved repeat reopens with the same visible and selected item.
- Repeat UID and reference UID remain independent.
- Nested-repeat extraction is covered.
- Catalog synchronization is bounded, idempotent, and upsert-only.
- Interrupted synchronization does not erase the usable local catalog.
- Search does not load the complete catalog on each widget rebuild.
- Missing display data never clears a saved UID.
- Submission requests without references remain unchanged.
- Reference definitions are transient and reconstructed on retry.
- Server reference creation and submission save are atomic.
- Known server identity and lineage are never overwritten by client names.
- New server identity records the validated activity and authenticated creator.
- Imported identity is never falsely attributed to the current campaign.
- The server derives all authority and org-unit scope from validated context.
- Old clients cannot receive a form requiring the corrected field.

## Explicitly Out Of Scope

- household-, person-, or campaign-specific implementation names;
- one submission per referenced item;
- submission-level subject identity;
- targeting, completion, coverage, acceptance, or flagging state;
- workflow queues and carry-forward sessions;
- catalog deletion or per-item revocation;
- editing canonical names through the mobile;
- automatic same-name deduplication or merging;
- generic reference-source registries;
- metadata-submission, Party, or `resourceMetadataSchema` resurrection;
- automatic conversion of historical submissions;
- future event or processing-pipeline modeling;
- solving unrelated whole-form or large-repeat performance risks.

## Known Limitations And Blind Spots

1. Two offline users may create different UIDs for the same real-world item.
   Display name is not identity, so version 1 must not merge them
   automatically.
2. A locally created catalog row that is never referenced remains local. It is
   sent to the server only when a submission actually uses it.
3. Without availability state, version 1 cannot represent individual catalog
   revocation. The server list is deliberately append/upsert oriented.
4. A saved unknown UID with no local name cannot create a server record and
   must fail explicitly rather than fabricate a name.
5. Existing historical records with unknown origin cannot truthfully answer
   which activity first registered them; null is the required answer.
6. The current bulk upload behavior does not provide clean per-submission
   partial success. This slice preserves that behavior instead of hiding a
   broader upload-policy change inside reference work.
7. If the product later requires lineage to be visible offline, the current
   three-column mobile cache is insufficient by design.

## Review Points Before Implementation

1. Confirm the maximum expected catalog size per org unit.
2. Confirm whether version 1 server catalogs are truly append/upsert-only.
3. Select the old-client capability or minimum-build gate.
4. Confirm the neutral fallback text for a saved UID missing from the cache.
5. Confirm whether server upload responses need to expose `created` versus
   `existing`, or whether persisted server lineage and reporting are enough.
