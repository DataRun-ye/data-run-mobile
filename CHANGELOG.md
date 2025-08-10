## v5.3.0+17

## Soft delete flow and user permissions applications

- instances deleted is a status, for soft delete only for teams with delete permissions, for other
  users, instances are only deleted from local device.
- teams with delete permission on a template, need to sync instances marked for softDelete.
- only synced instances can be soft deleted, instance not yet synced are deleted from local device
  completely.

## Enahnced table display values:

through implementing:

1. **Data Extraction Utility:**
   traverse into nested maps/lists and extract and cache value.
2. **Aggregation Utility:**
   Takes the raw output (single value or list) and apply built-in aggregations (count,
   sum, avg, min, max, first, last, concat) accross different levels - metadata configurable through
   the template.
3. Enhanced Path Syntax: Wildcards & Indexes
   Extend elements' path syntax to support bracket-notation *in the query*.
    * **Exact index:** `visits[2].tags`
    * **Wildcard:** `visits[*].tags`
    * ~~**Slices:** `visits[0..2].tags`~~ (next)

## Enahncement for rule validation

1. **Runtime Rule and Path Validation:**
   Seperate ui from rule validation engine, Rule validation engine can scan and work on saved data
   out side the form screen, Walks the same flat `FormTemplate` and verify that each segment's rule
   in a given path is valid without the heavy load of any form or screen state controls.

---

## Custom Aggregation Plugins

Allow domain-specific transforms without touching core code:

```dartS
FormDataAggregator.register('median', (List<num> items) =>{});
FormDataAggregator.register('joinUppercase', (List items) => {});
```

Usage remains:

```dartS
final result = FormDataAggregator.aggregate(rawValue, 'median');
```

## Next Steps / Questions

1. **Change Detection:** How do we invalidate cached path results when a source field updates?
2. **Memoization Strategy:** LRU cache per form/path? TTL?

## 11/15/2024

- I plan to enhance the current structure of form elements (@FormElementInstance and its subclasses:
  @FieldInstance, @SectionInstance, @RepeatInstance ...etc) and the @FormInstance that manage the
  whole form structure. and
- with the implementation of table view for @RepeatInstance and @RepeatItemInstance which represent
  the rows (@RepeatInstanceDataTable, @EditPanel) the form Element structure decoupled with the
  reactive formControls becoming proplematic espicially after starting to think of:
- lazy load of the pagination table, creating a new row or editing one.
- Start Separate form Element Lifecycle from Model State
- So the logic layer continue processing changes without depending on UI state.
- the UI layer decide what it does without affecting the dependency evaluations that need to occur.
  issues:
- FormControls of the reactive_forms are tightly coupled with their form elements model
  counterparts. all form elements reference the root FormGroup so Whenever I need to create a
  certain form element dynamically, I need to create its reactive formControl before creating the
  model.

- created a folder called @formModule, copied the @FormElementInstance and its sub-classes to it and
  give them a new name `FormElementModel, FieldElementMode, SectionElementModel...etc`

if you check the files in @form_module, the code still a mess, i am still making up my mind about
different ideas to reperesent the form such as flatten the form values and seperate them from the
tree structure, **sections** can function as "breadcrumbs" or logical groupings during search for an
element dependency in the tree, while the more complex data structures arise from **fields** and *
*repeat sections**. if I have a nested elements with different deeps and I am thinking to import the
data as a table the sheets will represent the leaf fields, and a repeat will be another table that
relate to the parent table the rest will end up either as a breadcrumb on the column name, or for
some logical grouping in the ui

## 09/25/2024

- can collect attributes inside the form data, such as:
    - uuid.
    - device info, that collect a device
      property `model`, `androidId`, `version.release`, `manufacturer`, `username`
    - logged in username, userInfo (lastName, firstName).
    - activity, orgUnit, team.

## 06/16/2024

//<editor-fold desc="Data Methods">
//</editor-fold>

- Start with static forms but with dynamic generation for fields from json.
- Add ValueRenderingType for choices fields display
- Add FieldRule for fields to hide/show field based on the value of another field
- Avoid asynchronicity using scopes Check
  the [Async Initialization](https://docs-v2.riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis).

## 04/10/2023

- Replace [LayoutProvider] with [ItemWidget]
- Add [sectionRenderingType] and [fieldRendering] to [FieldUiModel]