# Large Repeat Performance And Data-Loss Risk

Validated: 2026-07-24

Scope: current evidence for forms with roughly 200-300 repeat rows after the `v6.0.0+50` repeat, validation, and save work. This is not a proposal to change the whole-JSON persistence contract.

## Current Conclusion

The original report affected an estimated 40% of field devices, so a fast development device cannot disprove it. The released work removed several multiplicative costs and unsafe edit/save paths, but it did not make the entire form graph lazy.

Closed in v6:

- active form and row-exit paths await persistence before navigation/finalization;
- field subscriptions cancel on disposal;
- repeat metadata is generated/preserved before local save and upload;
- the canonical form template tree is built once;
- parsed rule expressions and outside-to-repeat fan-out work were reduced;
- dormant repeat rows retain one map control instead of a full field-control subtree;
- repeat row edit is transactional for save/discard/back, including nested rows;
- repeat deletion is explicit, supports multi-selection, and preserves surviving identity/index normalization;
- completion validation reuses one temporary dormant control per traversal;
- hidden/show, required, multi-select, nested dependency, and dirty-form behavior have focused tests and device smoke coverage.

Still active:

- every repeat field still has an eager element instance and dependency/rule state;
- dependency resolution and initial evaluation still traverse the element graph;
- an outside dependency still fans out linearly to affected repeat rows;
- a save still reduces and writes the entire submission JSON;
- the paginated table retains all repeat element rows even though it renders a page;
- `FormInstance.saveFormData()` has no form-level serialization guard against two independent callers;
- Android process death during an SQLite write is not characterized;
- synced server-record edit/identity behavior is a separate incomplete product contract.

## Current Runtime Shape

`FormElementControlBuilder.createRepeatFormArray()` creates one `FormControl<Map<...>>` per stored row. It does **not** eagerly create every row's field controls.

`FormElementBuilder.buildRepeatSection()` still creates a `RepeatItemInstance` and field element instances for every row. A row's full `FormGroup` exists only while its editor is open. Completion validation reads dormant element values through a reusable temporary control rather than materializing all row editors.

Therefore:

- retained control/stream memory scales near row count plus currently edited fields;
- element/dependency memory and initial rule work still scale near rows multiplied by fields;
- save reduction still visits the complete element graph.

## Measured Evidence

The deterministic harness uses 50, 150, and 300 rows. Current 300-row output on the development machine:

```text
elementCount=3910
fieldCount=3605
controlCount=310
dependencyResolveMs=123
ruleEvaluateMs=309
validationMs=368
reduceMs=102
jsonEncodeMs=2
jsonBytes=97327
totalMs=1052
```

The live outside-to-repeat fixture measured about 9 ms at 50 rows, 14 ms at 150 rows, and 37 ms at 300 rows in the latest run. Earlier post-fix 300-row runs were about 20-34 ms. This confirms linear growth remains even after removing repeated parse/debug work.

The retained-control change previously reduced the 300-row probe from approximately:

```text
retained Dart heap: 20.9 MB -> 2.6 MB
field controls:      3605 -> 305
broadcast streams:   15640 -> 1240
```

These numbers establish improvement on the harness, not a universal field-device threshold. Real device CPU, memory, Android version, form shape, option count, dependency fan-out, and JSON size still matter.

## Ranked Residual Hypotheses

| Rank | Hypothesis | Evidence | Current classification | Confirmation needed |
|---|---|---|---|---|
| 1 | Eager element/dependency graph causes open/evaluate pauses on low-end devices | All repeat fields become element instances; bootstrap resolves and evaluates the complete graph; harness evaluation is the largest measured phase | `ACTIVE-CORE` residual, high confidence | Profile a reported device/form and compare element/rule/dependency counts |
| 2 | Outside-to-repeat expressions cause visible input stalls | Fan-out remains linear and the 300-row fixture takes about 20-37 ms per toggle on the development machine | `ACTIVE-CORE` residual, high confidence | Trace the exact field action on an affected device; identify duplicate or unnecessary dependents |
| 3 | Whole-form reduction and SQLite JSON write pause or fail under large submissions | Every row save/form save reduces the graph and updates one JSON column; 300-row reduction is about 102 ms before a real device DB write | `ACTIVE-CORE` residual, high confidence | Record reduce, encode, DB update, JSON bytes, and total save on an affected device |
| 4 | Overlapping save calls or process interruption can still lose the last checkpoint | UI row save has a local guard and call sites await, but `FormInstance.saveFormData()` has no shared in-flight owner; process death is untested | `UNKNOWN` production cause, medium confidence | Force double actions and process termination around a delayed DAO write |
| 5 | Paginated table refresh/cell traversal causes row-screen jank | datasource retains all row instances; visible cells traverse row fields | `ACTIVE-SUPPORT` residual, medium confidence | Count `getRow()`/cell work during selection, delete, and edit on a 300-row form |
| 6 | Server-backed edits overwrite repeat identity | Local create/save/reopen/upload is idempotent; server round-trip edit is not validated | `REACHABLE-INCOMPLETE`, medium confidence | Enable only in a controlled test and compare existing/new top-level and nested IDs |

## Safety Invariants Already Established

Keep these behaviors unless a replacement contract explicitly supersedes them:

- navigation and completion wait for local persistence;
- a changed row saves once or discards back to its opening snapshot;
- a new discarded row removes that exact provisional row;
- nested discard restores the full nested snapshot;
- new IDs are created once and existing IDs are preserved;
- hidden values survive temporary toggles but are omitted only by the save projection;
- dormant required/type/rule validation participates in completion validity;
- row edits make the main form dirty so back shows the completion/draft sheet;
- deletion is confirmed once for one or many selected rows.

These are product/data behaviors, not a requirement to preserve the current classes or graph structure.

## Files To Understand Before More Performance Work

- `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart`
- `lib/core/form/builder/form_element_control_builder.dart`
- `lib/core/form/builder/form_element_builder.dart`
- `lib/features/form_submission/application/element/form_instance.dart`
- `lib/features/form_submission/application/element/form_element.dart`
- `lib/features/form_submission/application/element/element_dependency.extension.dart`
- `lib/features/form_submission/application/element/section_instance.dart`
- `lib/features/form_submission/application/element/repeat_section.dart`
- `lib/features/form_submission/application/element/repeat_item_instance.dart`
- `lib/features/form_submission/application/element/field_instance.dart`
- `lib/features/form_submission/application/repeat_row_edit_session.dart`
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart`
- `lib/features/form_submission/presentation/section/repeat_table_rows_source.dart`
- `lib/features/form_submission/presentation/section/edit_row_screen.dart`
- `lib/database/dao/data_submissions_dao.dart`
- `lib/database/converters/null_aware_map.converter.dart`
- `test/dev/repeat_metrics_harness_test.dart`
- `test/dev/repeat_control_lifecycle_test.dart`
- `test/dev/repeat_dependency_resolution_test.dart`

## Next Evidence-Driven Slice

Do not add generic instrumentation or another speculative lazy graph.

1. Monitor v6 adoption, GlitchTip, and user reports for device model, Android version, form/version, row count, action, and whether work survived reopen.
2. When a symptom appears, reproduce that exact form shape with the existing harness or the reported device.
3. Use existing phase metrics first. Add only the missing measurement that separates element construction, dependency/evaluation, table refresh, reduction, or DB write.
4. Choose one reversible fix against the dominant measured phase.
5. Protect nested repeats, outside/inside dependencies, visibility/validation, transactional edit, and identity with existing characterization tests.

If no v6 field symptom appears, the next repeat change should be a deliberately prioritized product/performance improvement, not an assumed emergency fix.
