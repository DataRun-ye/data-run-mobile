# Draft: Bounded Reference Field

> **Status: FINAL DRAFT FOR ACCEPTANCE.**
>
> This is an implementation blueprint, not an active production contract.
> Repository evidence was rechecked against the current mobile `develop`
> baseline following the v6 production release and the current local server
> source on 2026-07-25. Do not expose a production form using `Reference`
> until every delivery and activation gate below passes.

## Purpose

Stabilize the existing `Reference` form field as one deliberately narrow,
domain-neutral capability inside the current form and repeat flow.

The initial workflow is rapid entry:

1. shared answers stay outside a repeat and are entered once;
2. one referenced item is selected or created inside each repeat row;
3. the row is saved using the existing `Save and add another` flow;
4. the field stores only the referenced item's UID.

The implementation must not use a campaign concept such as household or
person as a code, table, route, or service name. A form's localized label gives
the field its current business meaning.

## Locked Product Contract

The bounded field:

- reads an offline catalog scoped by organization unit;
- reaches that catalog only through assignments available to the current user;
- displays one server-authoritative name;
- stores one 11-character UID in `formData`;
- supports deliberate offline creation using only a validated name;
- works as an ordinary field and inside top-level or nested repeats;
- preserves the selected or generated UID through edit, restart, and retry;
- prevents the same `Reference` element from selecting one UID more than once
  in one submission;
- carries no targeting, completion, coverage, workflow, or analytical state.

The mobile catalog row is exactly:

```text
uid
orgUnitUid
displayName
```

The mobile must not add:

- `source`;
- `pendingCreate`;
- `available`;
- `lastSeenSyncRun`;
- a synchronization-state enum;
- a domain type;
- a submission-level subject column;
- a generic reference-source registry.

`orgUnitUid` is catalog ownership. Assignment and activity provide access and
first-registration context; they do not become catalog identity.

## Evidence: Current Production Shape

### Supported foundations

| Current capability | Evidence | Consequence |
| --- | --- | --- |
| `ValueType.Reference` exists on mobile and server | `lib/database/shared/value_type.dart`; `lib/core/form/builder/form_element_control_builder.dart`; server `datatemplateelement/enumeration/ValueType.java` | No new form field type or template-schema property is needed. |
| Active builders use `FieldInstance<String>` and `FormControl<String>` | `lib/core/form/builder/form_element_builder.dart`; `lib/core/form/builder/form_element_control_builder.dart` | A Reference value can remain a UID string in whole-form JSON. |
| Form entry carries assignment, template, version, and submission IDs | `lib/features/form_submission/application/element/form_metadata.dart`; `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` | The field can resolve assignment scope without a new submission column. |
| Assignments already contain activity, team, and org-unit UIDs | `lib/database/tables/assignments.table.dart`; `lib/database/dao/assignments_dao.dart` | The local assignment can resolve the catalog org unit. |
| Available forms come from `assignment_forms` | `lib/data/form_template_list_service.dart`; `lib/database/dao/form_template_versions_dao.dart` | Filtering the assignment-form response is an effective old-client gate. |
| Drafts pin a concrete form-version UID | `lib/database/tables/data_submissions.table.dart`; `lib/database/tables/form_template_versions.table.dart` | Upload extraction can use the exact template that created the draft. |
| Submission values are one JSON object | `lib/database/tables/data_submissions.table.dart` | Reference stays in `formData`; no normalized reference-value table is needed. |
| Repeat rapid entry already exists | `lib/features/form_submission/presentation/section/repeat_table.widget.dart` | No queue, entry-session, or subject workflow should be introduced. |
| Submission upload is centralized | `lib/features/data_instance/application/submission_upload_service.dart`; `lib/database/extensions/data_submission.extension.dart` | One upload decorator can own transient reference definitions. |
| Production migration fixtures exist | `test/dev/app_database_migration_test.dart`; `test/fixtures/database/schema_v3.sql` | The additive mobile migration can be proven from production schema 3 and current schema 6. |

### Missing or incomplete behavior

These are implementation requirements, not assumptions that current code
already satisfies:

1. The reachable Reference widget is **INCOMPLETE**. It watches an empty
   metadata provider, hardcodes old campaign fields, and displays names as
   values:
   `lib/features/form_submission/presentation/field/reference_search/q_reference_drop_down_search_field.widget.dart`.
2. `ValueType.Reference` currently uses `TextValidator`, not the server's
   exact UID rule. The server requires 11 alphanumeric characters with an
   alphabetic first character.
3. No active local catalog, database search, or paginated Reference
   synchronization exists.
4. `BaseDataSource` downloads one unpaged collection and maps it in memory.
   It is not the owner for a paginated catalog.
5. Assignment-form synchronization currently skips the extra request when the
   assignment list is empty, and a successful empty `assignments/forms`
   response does not clear stale `assignment_forms`; replacement only occurs
   when the flattened extra list is non-empty.
6. Mobile upload currently serializes `DataInstance` directly and does not
   load its pinned form version.
7. `FormDataUtil.getRawByPath` does not correctly traverse arbitrary nested
   repeat lists. It must not be reused as proof of Reference extraction.
8. The server DTO has no request-only Reference definitions, and its existing
   flattening utility is not a template-aware Reference extractor.
9. Server submission preprocessing occurs before
   `DefaultDataSubmissionService.upsertAll` opens its transaction. Catalog
   creation added there would not automatically be atomic with submission
   persistence.
10. Server `CompositeSubmissionValidator` is an unordered injected list.
    Reference resolution must not be added as another validator that assumes
    another validator has already run.
11. No old-client capability gate exists today.
12. A submission pins only its assignment UID, while the current server
    assignment service can update that assignment's activity and org unit.
    Moving a Reference-enabled assignment after drafts exist would make their
    catalog scope ambiguous.

No captured production form under `test/fixtures/live_forms/` currently uses
`Reference`. The metadata-submission, Party, and `resourceMetadataSchema`
surfaces do not provide this capability and must not be revived.

The exact server revision deployed in production is not recorded in this
mobile repository. Before the first server slice, record the deployed commit
and applied Liquibase state. If its active assignment or submission endpoints
differ from the source audited here, reconcile this blueprint before changing
code; do not silently adapt during implementation.

## Field Contract

### Form configuration

The existing form shape is sufficient:

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

Version 1 has one source: the org-unit catalog defined here. It has no
`resourceType`, schema selector, provider dispatch, or domain-specific mode.

### Runtime scope

The field reads `FormMetadata.assignmentId`, resolves the local assignment,
and obtains its `orgUnitUid`. Missing assignment or org-unit context is an
unsupported configuration error. The field must not query a global list or
infer scope from another submission.

For Reference-enabled work, activity and org unit are immutable properties of
an issued assignment UID. Moving the work to another activity or org unit
requires a new assignment UID. The server foundation must reject such scope
mutation once an assignment exposes a Reference form; this avoids adding
duplicated scope columns to every submission.

### Stored value

The control and `formData` store only:

```json
"configuredReferenceField": "a1234567890"
```

A repeat row still has its separate `_id`; Reference never reads, writes, or
mentions repeat identity.

### Selection and local creation

Selecting an existing item:

1. resolves a row under the current org unit;
2. writes only its UID to the control;
3. does not insert a duplicate catalog row;
4. restores the same visible and selected item when reopened.

Creating a missing item:

1. is an explicit secondary action after showing matching search results;
2. validates and normalizes the entered display name;
3. generates one client UID using `CodeGenerator.generateUid()`;
4. inserts `uid`, `orgUnitUid`, and `displayName`;
5. selects that UID;
6. persists it when the repeat row or form is saved.

The name is whitespace-collapsed and trimmed before insertion. New names use
the active `ArEnFullNameValidator` behavior: supported Arabic/Latin name
characters and at least four valid name parts. Imported names are not
revalidated, because earlier campaigns may contain three-part names.

The server must implement the same new-name behavior from shared contract
fixtures; no equivalent server validator exists today.

### UID validation

Reference gets a focused validator matching the server contract:

```text
^[a-zA-Z][a-zA-Z0-9]{10}$
```

Do not broaden this slice by changing validation for every other UID-valued
field. The current general mobile `UidValidator` accepts a numeric first
character and may have compatibility consumers.

### Duplicate selection

Within one submission, one `Reference` element path cannot contain the same UID
twice:

- options used by another occurrence are visible but disabled;
- an occurrence being edited may retain its own current UID;
- clearing or deleting an occurrence releases its UID;
- a form validator enforces the rule independently of picker state;
- dormant repeat rows and nested repeat rows are included without hydrating
  every row;
- historical duplicates remain visible and invalid, never auto-cleared;
- another Reference element or another submission may use the same UID.

The duplicate set is derived from current form values. It adds no persisted
state.

### Missing display row

If saved `formData` contains a UID absent from the local catalog:

- preserve the UID;
- show a neutral localized fallback containing a shortened UID;
- do not fabricate a name or silently clear the value;
- do not offer the missing item as a new selectable option.

At upload, the server alone decides whether the UID is a known acceptable
identity or an unknown identity missing a definition.

## Mobile Persistence

Mobile schema 7 adds one per-user table:

```text
reference_entries
  uid            primary key
  orgUnitUid
  displayName

index: orgUnitUid + displayName
```

There is no foreign key from a submission to this cache. Catalog changes must
never cascade into `formData`.

The migration must prove:

- production schema 3 upgrades to 7;
- current schema 6 upgrades to 7;
- submissions, whole `formData`, assignment forms, templates, and sync
  summaries remain unchanged;
- obsolete physical tables intentionally preserved for compatibility, notably
  `metadata_submissions`, remain untouched;
- generated Drift schema code is updated intentionally.

No normalized-name column is added initially. Database-backed search is
characterized with at least 1,500 rows under one org unit before another
persisted projection is considered.

## Catalog Synchronization

### Endpoint and authority

Use one authenticated paginated endpoint under an assignment context:

```text
GET /assignments/{assignmentUid}/referenceEntries
```

The server:

- proves that the assignment belongs to the current user's accessible work;
- proves that the current user may add submissions to a Reference-capable form
  on that assignment;
- derives activity and org unit from that assignment;
- returns a standard `PagedResponse` of UID/name/org-unit rows;
- uses a stable UID ordering for page boundaries;
- never accepts an org-unit UID from the client as authority;
- returns no submission, targeting, coverage, or workflow state.

Illustrative response:

```json
{
  "paged": true,
  "page": 0,
  "totalPages": 2,
  "totalElements": 150,
  "size": 100,
  "referenceEntries": [
    {
      "uid": "a1234567890",
      "name": "Display Name",
      "orgUnitUid": "o1234567890"
    }
  ]
}
```

The catalog is shared by org unit. When multiple eligible assignments resolve
to the same org unit, the mobile fetches that scope once using one valid
assignment context.

### Mobile sync owner

Add one custom `ReferenceEntryDatasource` implementing
`AbstractDatasource`. Register it after `AssignmentDatasource`.

It must not extend `BaseDataSource`. It:

1. discovers assignment forms with `canAddSubmissions=true` whose latest local
   template contains `Reference`;
2. groups them by local org unit;
3. requests every page through one authorized assignment per group;
4. upserts each page in a bounded transaction;
5. records one retryable sync-resource outcome;
6. restarts from the first page on retry, relying on UID-idempotent upsert.

Each successful page is retained if a later page fails. Existing rows are not
deleted merely because one fetch omitted them. A known UID's server name
refreshes the local display name. A local row unknown to the server remains
available for a later submission upload.

An incoming UID already cached under another org unit is a typed
synchronization conflict. The mobile preserves its existing row and fails that
resource sync; it never moves identity between org units through upsert.

Paging follows the server's existing `page`, `size`, and `totalPages`
convention. Do not add a second cursor protocol or depend on an unbounded
`paged=false` response.

This rule deliberately avoids an `available` column, run markers, staging
tables, and interpreting a network failure as deletion.

Assignment access controls whether the form workflow is reachable. Removing
assignment access does not erase catalog identity or saved form values.

### Search

Search is database-backed by `orgUnitUid` and display name, debounced, and
limited or paginated. The widget must not materialize the complete catalog on
each rebuild or keystroke.

## Submission Upload

### Request shape

Each existing submission request may add one optional transport-only property:

```json
{
  "...existingSubmissionFields": "...",
  "referenceDefinitions": [
    {
      "uid": "a1234567890",
      "name": "Display Name"
    }
  ]
}
```

`referenceDefinitions`:

- remains optional for old and non-Reference clients;
- is never stored in mobile `DataInstances`, server `DataSubmission`, or
  `formData`;
- is rebuilt on every retry;
- includes every locally resolvable UID actually referenced by that one
  submission, regardless of whether the row originated locally or remotely.

No pending flag or separate ensure/outbox workflow is needed. A server-known
UID makes a repeated definition harmless; a server-unknown UID uses the
definition for idempotent creation.

### Mobile upload owner

Introduce one focused `ReferenceUploadPayloadBuilder`, used only by
`SubmissionUploadService`. For each upload candidate it:

1. loads the submission's pinned `form_template_versions` row;
2. identifies the template's `Reference` element paths;
3. extracts actual UID values from ordinary, repeat, and arbitrary
   nested-repeat JSON;
4. resolves available names from `reference_entries`;
5. attaches deduplicated definitions to that submission's existing upload map.

Introduce one template-aware `ReferenceValueExtractor` shared by upload
preparation and duplicate derivation where their inputs overlap. Do not reuse
`FormDataUtil.getRawByPath` or the server flattening utility; neither proves
arbitrary nested-repeat traversal.

Contract fixtures must cover:

- an ordinary Reference field;
- a Reference in a repeat;
- a Reference in a nested repeat;
- multiple parent repeat rows;
- null, missing, malformed, and duplicate values;
- another String field at a similar path that must not be extracted.

A missing local name simply omits that definition. The server may accept a
known UID; an unknown UID without a valid supplied name fails clearly.

### Server request handling

Add `referenceDefinitions` to `DataSubmissionV1Dto` as a request-only
collection and explicitly ignore it in `DataSubmissionV1Mapper`. Keep each
DTO associated with its mapped submission during preprocessing.

Reference resolution is an explicit phase after the current access and
composite validators finish. Do not register it inside the unordered
`List<SubmissionValidator>`.

For each submission, `ReferenceSubmissionResolver`:

1. uses the now validated assignment-derived activity and org unit;
2. loads the pinned form version;
3. extracts actual Reference UIDs with the same contract fixtures as mobile;
4. rejects supplied definitions not used by that submission;
5. accepts a known UID only in the derived org unit;
6. never overwrites a known UID's name or first-registration lineage;
7. creates an unknown UID only with a valid matching definition;
8. rejects an unknown UID without a name;
9. rejects a UID owned by another org unit.

### Transaction and bulk behavior

Current submission preprocessing runs outside the transaction opened by
`DefaultDataSubmissionService.upsertAll`. The implementation must move the
transaction boundary outward.

The smallest owner is the public V1 `upsertAll` coordinator:

```text
transaction starts
  map DTOs while retaining definitions
  validate access
  run existing assignment/form-version enrichment
  resolve/create references
  persist the complete submission bulk through DataSubmissionService
transaction commits
```

An exception at any stage rolls back new catalog rows, submissions, and outbox
rows participating in that transaction. A rollback integration test is
mandatory.

Version 1 preserves the active all-or-fail request behavior:

- the mobile sends the selected submissions in one bulk request;
- one validation or persistence exception fails the request;
- the mobile marks every attempted submission `syncFailed`;
- retry rebuilds definitions and reuses the same submission and Reference UIDs.

The current mobile response parser also supports a server summary containing
some accepted and some rejected submission UIDs. Preserve that compatibility
path. Reference resolution itself does not introduce such partial server
processing: a thrown Reference error still fails and rolls back the complete
request.

## Server Catalog And Lineage

The canonical server entity contains:

```text
uid
displayName
orgUnit
firstRegisteredActivityUid   nullable, immutable
```

It extends the existing identifiable/audited base, which supplies the internal
26-character ID and `createdBy`, `createdDate`, `lastModifiedBy`, and
`lastModifiedDate`. No `source` column is added.

Creation rules:

- existing UID: preserve canonical name, org unit, and first-registration
  audit;
- new UID: use the client-generated UID, server-derived org unit, validated
  assignment activity, and authenticated audit identity;
- retry: find the same UID and do not rewrite lineage;
- later activity: reuse identity without changing first activity.

Historical import:

- preserves or generates a canonical 11-character UID;
- records the identifiable previous activity as first registration;
- uses a deterministic migration/system audit identity;
- leaves first activity null when historical origin is not provable;
- never attributes import lineage to the first device that downloads it.

The upload response needs no per-reference `created` or `existing` result.
Persisted server lineage is sufficient for version 1.

## Automatic Old-Client Gate

This capability already requires server changes, so the old-client gate is
included in the server foundation rather than relying on a manual device list.
It is intentionally not a generic capability framework.

The exact bounded protocol is:

```text
old client: GET /assignments/forms?paged=false
new client: GET /assignments/forms?paged=false&referenceVersion=1
```

The server treats a missing value as version 0:

- version 0 excludes assignment forms whose latest version contains a
  `Reference` element;
- version 1 includes them when ordinary access rules allow;
- non-Reference assignment forms are unchanged.

The filter applies only to `assignments/forms`. Old clients may cache template
JSON, but `FormTemplateListService` cannot offer a form without its
`assignment_forms` row.

Two supporting requirements close current blind spots:

1. After a successful assignment fetch, the mobile also fetches assignment
   forms when the assignment list is empty. A successful assignment-form
   response atomically replaces local `assignment_forms` even when its
   flattened list is empty. A failed assignment or assignment-form response
   preserves the previous rows for offline use.
2. The initial Reference campaign uses a new form-template UID. It must not
   turn the latest version of a form with old-client drafts into a Reference
   form, because filtering that template could also remove edit access to its
   older pinned drafts.

Tests must prove old requests cannot see Reference forms, version 1 requests
can, ordinary forms remain visible, successful-empty replacement clears local
rows including when the assignment list is empty, and fetch failure preserves
local rows.

## Delivery Sequence

The numbered items below are milestones, not instructions to combine all their
bullets into one PR. Every distinct cleanup, prerequisite, or behavior change
must be handled as a bounded unit:

1. discover and prove its active path, existing behavior, and production risk;
2. define the smallest plan, ownership boundary, checks, and acceptance state;
3. make and verify only that change;
4. close it before starting the next unit.

Do not hide preparatory cleanup inside feature implementation or expand a unit
because adjacent debt was discovered. Required debt becomes an earlier bounded
unit; unrelated debt stays deferred. If discovery contradicts this draft,
revise and review the affected contract before changing code.

Do not start campaign activation with only part of this sequence deployed.

### 1. Shared contract characterization

- add a neutral form fixture with ordinary, repeat, and nested-repeat Reference
  paths;
- add shared JSON extraction cases consumable by mobile and server tests;
- lock UID and new-name normalization/validation cases;
- characterize duplicate selection and missing-name behavior;
- characterize database search with at least 1,500 rows.

No runtime behavior changes in this slice.

### 2. Server catalog, read API, and compatibility gate

- record the deployed server revision and Liquibase state, and verify the
  audited endpoint call paths still match;
- add the neutral audited catalog and Liquibase migration;
- add access-scoped paginated reads;
- add `referenceVersion=1` filtering to `assignments/forms`;
- reject activity/org-unit mutation for Reference-enabled assignment UIDs;
- use batched latest-template lookup rather than one query per form;
- test existing non-Reference responses, old-client filtering, and assignment
  scope-mutation rejection;
- deploy without assigning a Reference form.

### 3. Server upload resolution

- add the request-only DTO definitions;
- implement template-aware extraction and explicit resolution;
- move the V1 bulk transaction boundary outward;
- test known, new, retry, wrong-org-unit, stale-name, malformed UID,
  unknown-without-name, unused-definition, import-lineage, old payload, and
  complete rollback cases;
- deploy while the feature remains unassigned.

### 4. Mobile schema and catalog sync

- add schema 7 `reference_entries`;
- prove schema 3 and 6 upgrades;
- add the focused repository and custom paginated datasource;
- register it after assignment synchronization;
- correct successful-empty `assignment_forms` replacement;
- test paging failure, retry from page one, name refresh, local-row retention,
  cross-org UID conflict, zero assignments, access loss, and bounded search.

### 5. Mobile field and upload integration

- replace the hardcoded incomplete Reference widget/provider;
- add the focused UID validator;
- add database search, selected-value restoration, and explicit local creation;
- add duplicate exclusion and validation;
- add the shared extractor and upload payload builder;
- advertise `referenceVersion=1` on the one assignment-form request;
- remove superseded metadata-reference source files only after references prove
  they are unused;
- keep the physical legacy `metadata_submissions` table unchanged;
- run focused form, upload, and migration tests.

### 6. Device and campaign activation

- install the complete mobile build through the production signing path;
- import prior catalog identities with truthful lineage;
- create a new form-template UID using Reference inside the existing repeat
  flow;
- keep shared answers outside the repeat;
- verify old-client and new-client assignment-form responses;
- smoke initial sync, offline search, local creation, save-and-add-another,
  nested repeat, edit/reopen, draft/restart, finalization, failed-upload retry,
  known identity, new identity, and server lineage;
- assign the form only after every gate passes.

## Acceptance Gates

- Existing non-Reference forms and payloads are unchanged.
- Old clients cannot receive an assignment form requiring Reference.
- The first Reference workflow uses a new template UID.
- Shared outer answers are entered once.
- Existing repeat `Save and add another` remains the rapid-entry flow.
- The field stores only a UID, never a name or object.
- The mobile catalog stores only UID, org unit, and display name.
- No domain name appears in implementation ownership.
- No source, pending, availability, run-marker, or workflow state is added.
- New names follow the agreed four-part contract; imported names remain usable.
- Local creation generates one UID and preserves it through restart and retry.
- A saved field reopens with the same visible and selected item.
- The same Reference element cannot select one UID twice in one submission.
- Nested-repeat extraction passes the shared contract fixtures on both sides.
- Search never loads the whole catalog on each widget rebuild.
- Interrupted catalog sync does not erase prior or locally created rows.
- Successful empty assignment-form sync removes stale access rows.
- Missing display data never clears a saved UID.
- Definitions are transient and reconstructed from the pinned template.
- Existing submission requests without definitions remain accepted.
- Server identity, canonical name, and lineage are not overwritten by retry.
- Server derives org unit and activity from validated assignment context.
- Reference-enabled assignment scope cannot change under an existing UID.
- Catalog creation and complete bulk submission persistence are atomic.
- One invalid bulk item rolls back the complete request.
- Mobile retry keeps the same submission, repeat, and Reference UIDs.

## Deferred Boundaries

The following are not partial version-1 features:

- domain-specific subject or household modeling;
- one submission per referenced item;
- submission-level subject identity;
- targeting, coverage, acceptance, flagging, or processing pipelines;
- workflow queues or carry-forward sessions;
- canonical-name edits from the data-entry field;
- activity-specific display aliases;
- automatic same-name merging;
- historical submission conversion;
- generic reference providers;
- unrelated large-repeat optimization.

Individual catalog deactivation is a separate bounded capability. If it is
required for the campaign, complete it before activation using sparse state:

```text
server reference_entry_deactivations
  referenceUid
  audit fields

mobile reference_entry_exclusions
  referenceUid
```

A successful scoped sync replaces the small exclusion set atomically; a failed
sync preserves it. Search excludes those UIDs from new selection while saved
values still resolve and remain visible. Reactivation removes the exclusion.
Do not infer deactivation from an omitted catalog page.

## Known Version-1 Limits

1. Two offline users can create different UIDs for the same real-world item.
   Names are not identity and are never auto-merged.
2. A local row never referenced by a submission remains local; this is the
   intentional cost of avoiding durable pending state.
3. A saved unknown UID with no local name can be accepted only if the server
   already knows it; otherwise upload fails without fabricating a name.
4. Historical identity with unprovable origin has null first-activity lineage.
5. Lineage is not available offline because it is not part of the three-column
   mobile projection.
6. Version 1 bulk upload is all-or-fail, matching the active server and mobile
   failure path.
