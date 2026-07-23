# Config Fetching And Offline Cache Map

Generated: 2026-07-10
Reconciled: 2026-07-24 against production `v6.0.0+50`

Scope: server-to-local fetching for configuration, metadata, assignments, forms, options, org units, teams, and related rows needed for offline work. This complements `01-production-code-path-map.md` and `02-form-flow.md`; it does not remap form rendering or submission save internals except where those depend on synced config.

Status legend:

- ACTIVE-CORE: removing the path without replacement breaks login/config sync, offline assignment/form access, or form loading.
- ACTIVE-SUPPORT: reached and useful to sync/UI, but not itself a core offline capability.
- ACTIVE-SEPARATE: core reachable path outside the bulk config sync loop.
- REGISTERED-UNUSED: fetched/written because it is registered, but no active consumer was found.
- SCHEMA-ONLY: table exists without a proven active reader; dropping it still requires a migration.
- INACTIVE: present but not referenced by active runtime flow found in this scan.
- INCOMPLETE: looks like unfinished feature work.
- LEGACY-RISK: old or duplicate-looking code that could be mistaken for the active path.
- UNKNOWN: cannot prove either way from static references.

## Executive Map

Active sync path:

1. Login or startup routes the user to `SyncResourcesView`.
2. `SyncResourcesController.triggerSync()` calls `SyncManager.syncAll()`.
3. `SyncManager` collects all registered `AbstractDatasource` instances from the active user scope.
4. Each registered datasource fetches one server resource through `BaseDataSource.syncWithRemote()`.
5. The base datasource maps JSON into Drift row objects, upserts rows in a transaction, optionally writes child tables, optionally disables stale rows, and writes a `sync_summaries` row.
6. Offline screens later read only local Drift tables through DAOs/managers.

Primary active config store:

- A per-user Drift database opened as `datarun_<username>.db`.
- Form definitions are cached as `form_templates` plus `form_template_versions`.
- Form elements live inside JSON/text columns on `form_template_versions.fields`, `sections`, and `options`.
- Assignment access lives in `assignments` plus `assignment_forms`.
- Org, project, activity, team, option, and permission metadata live in their own local tables. Form field definitions live in cached template-version JSON; the unused `data_elements` sync/table path was removed in schema 6.

## Active Trigger And Session Setup

| Area | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Login-triggered initial sync | ACTIVE-CORE | `lib/features/login/application/login_controller.dart` | Successful `AuthManager.login(...)` is followed by `replaceWithSyncResourcesView()`. | High | Fresh login always enters metadata/config sync before home. |
| Startup-triggered sync | ACTIVE-CORE | `lib/features/startup/application/startup_coordinator.dart` | `run()` calls `_syncScheduler.shouldSync()` after auth initialization and routes to `SyncResourcesView` when due. | High | Existing users refresh config when online and due. |
| Manual refresh | ACTIVE-CORE | `lib/features/home/presentation/drawer/app_drawer_sync_item.dart` | The drawer sync action routes online users to `SyncResourcesView`. | High | Users can explicitly refresh offline config. |
| Sync due decision | ACTIVE-CORE | `lib/core/sync/sync_scheduler.dart` | `shouldSync()` skips offline refresh and schedules initial/elapsed-interval refreshes. | High | Offline startup does not force config fetch; existing local DB remains the source. |
| Sync screen autostart | ACTIVE-CORE | `lib/features/sync/presentation/sync_resources_view.dart` | The routed `ConsumerStatefulWidget` triggers `SyncResourcesController.triggerSync()` after its first frame. | High | The sync route automatically starts the server fetch. |
| Sync completion flags | ACTIVE-CORE | `lib/features/sync/application/sync_resources.controller.dart` | The controller subscribes to `SyncManager.progressStream`; only a fully successful global result updates `SYNC_DONE` and `LAST_SYNC_TIME` and schedules navigation home. Failed or partial runs remain visible and can retry only failed/unattempted resources. Leaving the screen cancels the remaining queue after the active request. | High | Failed refreshes no longer advance metadata or force successful navigation, while already persisted resources are retained. |
| User profile fetch | ACTIVE-SEPARATE | `lib/core/auth/auth_api.dart` | Login posts to `/api/v1/authenticate`; profile fetch reads `/api/v1/myDetails` and converts authorities before `UserSession.fromJson`. | High | User/session config is fetched before bulk sync and saved outside the bulk datasource list. |
| User session activation | ACTIVE-CORE | `lib/core/auth/auth_manager.dart` | Login stores the profile and complete token pair, writes the active-user marker as the commit point, then opens/registers the user-scoped `AppDatabase` and calls `registerUserConfigurationDatasources`. Partial persistence or scope activation is rolled back. | High | Bulk sync only works after the committed session, per-user DB, and configuration datasources are registered. `AppDatabase` is the single database owner. |
| Per-user database file | ACTIVE-CORE | `lib/database/db_factory/platform_app.dart` | Opens `UserFileManager(userId).getUserFile('datarun_$userId.db')` and uses a background Drift connection. | High | Offline metadata is scoped by username. |

## Active Bulk Sync Registration

The runtime datasource list is explicitly registered in `lib/di/init_active_session_scope.dart`. Registration proves that a source executes; it does not prove its stored rows are required by a production feature.

Registered as `AbstractDatasource` and therefore collected by `SyncManager`:

1. `ProjectDatasource`
2. `ActivityDatasource`
3. `OuLevelDatasource`
4. `OrgUnitDatasource`
5. `OptionSetDatasource`
6. `DataFormTemplateDatasource`
7. `TeamDatasource`
8. `UserFormAccessesDatasource`
9. `AssignmentDatasource`

The former concrete `UserDatasource` registration had no resolver/caller and was removed. Login still fetches the user profile through `AuthApi.getUserProfile()` before this list is registered.

Why this matters: changing registration order or list membership changes what the app fetches during config sync. Some tables have foreign keys, so order is not just cosmetic.

Current strict correction: `OuLevelDatasource` and `UserFormAccessesDatasource` execute because they are registered, but no production read of their local tables is proven. Do not count them as core merely to preserve a nine-item list.

## Generic Fetch-Parse-Persist Algorithm

Active implementation: `lib/datasource/base_datasource.dart`.

| Step | Evidence | Behavior |
| --- | --- | --- |
| Fetch | `BaseDataSource.getOnlineRaw` | GETs `resourcePath`, defaulting to `<resourceName>?paged=false`, and expects `response.data[resourceName]` to be a list. A connection failure is persisted as failed and stops the remaining queue until retry. |
| Extract child rows | `BaseDataSource.extractExtraEntities` | Datasources can return `CompanionInsert` rows for options, form versions, managed teams, and assignment forms. |
| Map JSON | `BaseDataSource.mapRemoteItem` / `fromApiJson` | Each item becomes a Drift row. The default mapper injects external identity and common local fields before datasource-specific conversion. |
| Upsert main rows | `BaseDataSource.syncWithRemote` | Mapped rows are written with `insertAllOnConflictUpdate(table, mapped)`. |
| Refresh child table | `BaseDataSource.syncWithRemote` | If extras exist, the implementation deletes all rows from the child table, then upserts every extra row. This is a full child-table refresh, not a per-parent merge. |
| Disable stale rows | datasource `disableStale` override | When live IDs exist and fetch succeeded, datasource-specific disabling may run. The base implementation is no-op. |
| Sync summary | `BaseDataSource.syncWithRemote` | Writes counts/errors to `sync_summaries` before emitting the resource terminal event. |

Fetch, extraction, mapping, and database errors now retain their terminal `FAILED` or `PARTIAL_ERROR` outcome. Global completion counts only terminal resource events; it cannot complete while the final resource is still fetching or persisting. `test/dev/config_sync_outcome_test.dart` and `test/dev/session_revocation_sync_test.dart` cover false-success prevention, completion timing, connection-stop behavior, cancellation, retry isolation, and per-run counter reset.

## Entity Fetch And Storage Map

| Entity/resource | Classification | Server endpoint/path | Parser/normalizer | Local storage | Stale behavior | Offline consumer evidence | Confidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| User session/profile | ACTIVE-SEPARATE | `POST /api/v1/authenticate`, `GET /api/v1/myDetails` | `AuthApi.getUserProfile` flattens authorities before `UserSession.fromJson`; `AuthStorage` stores active user/session/tokens. | SharedPreferences/session storage/token storage; per-user DB then opens. | Not a bulk datasource refresh. | `AuthManager.login` requires profile before session activation. | High |
| Projects | ACTIVE-CORE | `projects?paged=false` | `ProjectDatasource.fromApiJson` uses default mapping. | `projects` table: `name`, `code`, `disabled`. | No datasource `disableStale` override found. | Activities reference projects. | High |
| Activities | ACTIVE-CORE | `activities?paged=false` | `ActivityDatasource.fromApiJson` collapses nested `project.uid`/`project.id` to `project`. | `activities` table references `projects`; includes disabled/start/end/description. | Overrides `disableStale` to set `disabled = true`. | Assignment list prefetches activity refs. | High |
| OU levels | REGISTERED-UNUSED / SCHEMA-ONLY | `ouLevels?paged=false` | `OuLevelDatasource.fromApiJson` uses default mapping. | `ou_levels` table: name/code/level/offlineLevels. | No datasource `disableStale` override found. | Static scan finds only datasource registration/write, schema declaration, and localization labels; no production table reader. | High |
| Org units | ACTIVE-CORE | `orgUnits?paged=false` | `OrgUnitDatasource.fromApiJson` collapses nested `parent.uid`/`parent.id` to `parent`. | `org_units` table: name/code/path/level/parent. | No datasource `disableStale` override found. | Assignment list/detail prefetch org unit refs. | High |
| Option sets | ACTIVE-CORE | `optionSets?paged=false` | `OptionSetDatasource` maps option sets and extracts nested `options` into `DataOption` rows with `optionSet`, `order`, label/translations, and delete flags. | `data_option_sets`; child `data_options`. | No option-set stale override found. Child `data_options` is fully deleted/reinserted when extras exist. | `OptionSetService.getOptions` reads local `dataOptions` and `dataOptionSets` for select fields. | High |
| Data elements | OBSOLETE-REMOVED | No active fetch after removal of `DataElementDatasource`. | Form field metadata is parsed directly from cached `form_template_versions` JSON. | The former `data_elements` table is removed by schema migration 6. | N/A | No production read consumer was found outside generated Drift code; registration previously caused write-only synchronization. | High |
| Form templates | ACTIVE-CORE | `formTemplates?paged=false` | `DataFormTemplateDatasource.mapRemoteItem` marks disabled; `fromApiJson` treats `disabled` or `deleted` as disabled. | `form_templates`: id/version/name/label/disabled. | Overrides `disableStale` to set `disabled = true`. | Form lists and assignment access query `formTemplates`. | High |
| Form template versions/elements | ACTIVE-CORE | Extra fetch: `formTemplateVersions?paged=false` from `DataFormTemplateDatasource._getFormVersions`. | Each item becomes `FormTemplateVersion` with `id = uid` and `template = templateUid`. Drift converters parse/store `fields`, `sections`, and `options` JSON. | `form_template_versions`: template FK, versionNumber, `fields`, `sections`, `options`. | Child table is fully deleted/reinserted when form template extras exist. Separate `FormTemplateVersionDatasource` is not active. | `FormTemplateListService.getTemplateByVersionOrLatest` and `FormTemplateVersionsDao.selectFormTemplatesWithRefs` read this table to open forms. | High |
| Teams | ACTIVE-CORE | `teams?paged=false` | `TeamDatasource.fromApiJson` collapses nested activity UID and marks disabled if team or activity is disabled. | `teams`; child `managed_teams`. | Overrides `disableStale` to set `disabled = true`. Child `managed_teams` is fully deleted/reinserted when extras exist. | Assignment list/detail prefetch team refs; team fields can read managed teams. | High |
| Form permissions | REGISTERED-UNUSED / INCOMPLETE POLICY | `formPermissions` | `UserFormAccessesDatasource` maps rows directly; `extractId` returns empty string because primary key is team+form. | `user_form_permissions`: team, form, valid dates, permissions list. | No datasource stale override found. | Active authorization reads are proven through `assignment_forms`; no reader of this table was found. | High |
| Assignments | ACTIVE-CORE | `assignments?paged=false` | `AssignmentDatasource.mapRemoteItem` collapses nested activity/orgUnit/team UIDs, defaults status to `PLANNED`, sets `syncState: synced`, and maps disabled. | `assignments`: activity/team/orgUnit FKs, dates, status, syncState, disabled. | Overrides `disableStale` to set `disabled = true`. | Assignment screens read assignments with org/team/activity/form refs. | High |
| Assignment forms/access | ACTIVE-CORE | Extra fetch: `assignments/forms?paged=false` | `_AssignmentWithAccess.fromJson` expands `accessibleForms` into `AssignmentForm` rows. | `assignment_forms`: assignment+form PK, canAdd/canView/canEdit/canDelete flags. | Child table is fully deleted/reinserted when assignment extras exist. | `FormTemplateListService.userAvailableForms` and assignment permission checks read this table. | High |
| Data submissions | ACTIVE LOCAL/PUSH; INACTIVE PULL | No active fetch endpoint. `SubmissionUploadService` posts to `dataSubmission/bulk`; `DataInstancesDao` prepares eligible rows and applies results. | No active remote parser. The service builds the upload payload from DAO-prepared local `DataInstance` rows. | `data_instances`: formTemplate/templateVersion/assignment refs, whole `formData`, sync flags. | The unregistered `DataInstanceDatasource` pull implementation was removed. | Offline submission list/edit paths read `data_instances`; active synchronization only uploads eligible local rows. Covered more fully in `02-form-flow.md`. | High |
| Sync summaries | ACTIVE-SUPPORT | Local only | `BaseDataSource.syncWithRemote` writes one summary row per resource. | `sync_summaries`: entity, lastSync, success/failure count, errors, lastSuccessfulSync. | N/A | Sync summary UI watches `syncSummariesDao.watchAllSummaries`. | High |

## How Key Entities Are Stored Locally

| Local table | Evidence | Stored shape |
| --- | --- | --- |
| `form_templates` | `lib/database/tables/form_templates.table.dart` | One row per form template with current version UID/number, name, label JSON map, description, disabled. |
| `form_template_versions` | `lib/database/tables/form_template_versions.table.dart` | One row per form version. `fields`, `sections`, and `options` are JSON/text columns mapped by `TemplateListConverter` and `FormOptionListConverter`. |
| `assignments` | `lib/database/tables/assignments.table.dart` | One row per assignment, linked to activity/team/org unit, with instance date, sync state, assignment status, completed date, client update time, disabled. |
| `assignment_forms` | `lib/database/tables/assignment_forms.table.dart` | Join/access table between assignment and form with add/view/edit/delete booleans. |
| `org_units` | `lib/database/tables/org_units.table.dart` | Org unit hierarchy with name/code/path/level/parent. |
| `activities` | `lib/database/tables/activities.table.dart` | Activity rows linked to project and disabled/date/description fields. |
| `teams` and `managed_teams` | `lib/database/tables/teams.table.dart`; `managed_teams.table.dart` | Team rows linked to activity; managed teams linked to managing team and activity. |
| `data_option_sets` and `data_options` | `option_sets.table.dart`; `options.table.dart` | Option sets and options, including option order, code/name, option-set FK, deletedAt. |
| `user_form_permissions` | `user_form_permissions.dart` | Team/form permission rows with converted permissions list. |
| `data_instances` | `data_submissions.table.dart` | Offline submission data and synced server submissions as one whole `formData` JSON map plus sync flags. |
| `sync_summaries` | `sync_summaries.dart` | Per-resource sync status, counts, serialized errors, and timestamps. |

`AppDatabase` registers both active and inactive-looking tables in one Drift database at `lib/database/app_database.dart`; table presence alone does not prove active sync use.

## Offline Consumption After Sync

| Consumer | Evidence | Local rows required |
| --- | --- | --- |
| Assignment list | `lib/database/dao/assignments_dao.dart` reads non-disabled assignments with prefetched forms, team, activity, and org unit. | `assignments`, `assignment_forms`, `teams`, `activities`, `org_units`. |
| Assignment list and form access | `lib/features/assignment/application/assignment_model.provider.dart` loads assignment rows and joins active `userAvailableFormsProvider`; `lib/data/form_template_list_service.dart` enforces `canAddSubmissions`; `lib/features/form_submission/application/submission_edit_access.dart` checks edit access for an existing submission. | `assignments`, `assignment_forms`, `form_templates`, `data_instances`. |
| Available forms | `lib/data/form_template_list_service.dart` reads `assignmentForms`, then `formTemplates`, and filters by active-user forms and `canAddSubmissions`. | `assignment_forms`, `form_templates`, user session form ids. |
| Form list/latest version | `lib/data/form_template_list_service.dart` and `form_template_versions_dao.dart` join form templates, form versions, and assignment forms to produce `FormTemplateModel`. | `form_templates`, `form_template_versions`, `assignment_forms`. |
| Form opening | `lib/data/form_template_repository.dart` loads the selected version and option sets/options before the form tree is built. | `form_template_versions`, `data_option_sets`, `data_options`. |
| Select/choice fields | `lib/data/option_set_service.dart` and `72-98` read local options and option sets, filtering out deleted records. | `data_options`, `data_option_sets`. |

## Inactive, Incomplete, Or Duplicate-Looking Paths

| Classification | File path | Evidence | Why it matters |
| --- | --- | --- | --- |
| OBSOLETE-REMOVED | Abandoned manifest services, party resolver, and `assignment_manifests`/party table declarations | No runtime consumer existed; persistence was TODO/comment-only; the resolver returned placeholders; the Play schema-3 database has none of these tables. Removed from active DI/schema declarations without a `DROP TABLE` migration. | Existing databases that happen to contain these unowned tables retain them, but active code no longer presents them as a production capability. |
| OBSOLETE-REMOVED | Duplicate DAO `syncWithRemote` mixin and metadata DAO wrappers | The active `SyncManager` calls registered `AbstractDatasource.syncWithRemote`; the duplicate DAO implementation and unused DAO wrappers were removed without changing tables. | Configuration sync now has one implementation path. |
| OBSOLETE-REMOVED | Former datasource order annotations/map | Ordering metadata did not determine active registration membership. The explicit order in `init_active_session_scope.dart` is now the only active source and is covered by a registration test. | Prevents generated annotations from being mistaken for sync membership. |
| OBSOLETE-REMOVED | `AssignmentService` and `AssignmentServiceImpl` | No runtime lookup or direct consumer existed; injectable registration was their only external reference. Active listing, creation availability, and edit access use the provider/service/query paths above. | Dormant assignment status/delete policy methods no longer look like active production authorization. |
| OBSOLETE-REMOVED | Unregistered data-value, repeat-instance, metadata-submission, form-version, and option datasources | No active `AbstractDatasource` registration or runtime caller existed. | Their names no longer imply active fetch paths. |
| OBSOLETE-REMOVED | Old Riverpod sync service and NMC worker providers | No active watcher or worker registration existed; the facade did not perform the real download. | Active config fetching remains `SyncResourcesController` plus `SyncManager`; the controller is a presentation projection over the real manager, not a second sync implementation. |
| OBSOLETE-REMOVED | `UserDatasource` | Its concrete registration had no resolver/caller and it was never part of `SyncManager.syncAll()`; active profile fetch remains `AuthApi.getUserProfile`. | Removes a false second user-profile fetch/persistence path from architectural reasoning. |

## Residual Risks And Questions

1. Should resources without `disableStale` keep stale rows indefinitely, especially projects, org units, option sets, and form permissions?
2. Child-table refresh deletes all rows from the child table before reinserting extras. Confirm this remains safe for `form_template_versions`, `assignment_forms`, `managed_teams`, and `data_options` under partial/server-side failures.
3. Cancellation stops the queue after the current resource; it does not interrupt the active Dio request, which remains bounded by configured timeouts.
4. Each resource is still a sequential whole `paged=false` download. Delta/versioned transfer requires measured deployed payloads and an explicit server contract.
5. Confirm whether `user_form_permissions` should become an active authorization source or stop syncing, since proven access decisions use `assignment_forms`.
6. Remove `OuLevelDatasource` from active sync only after a focused registration/config smoke, then drop `ou_levels` in a later production-safe migration if no reader emerges.

## Do Not Touch Until Understood

- `lib/features/sync/application/sync_resources.controller.dart`
- `lib/core/sync_manager/sync_manager.dart`
- `lib/datasource/base_datasource.dart`
- `lib/di/init_active_session_scope.dart`
- `lib/core/auth/auth_manager.dart`
- `lib/core/auth/auth_api.dart`
- `lib/core/auth/auth_storage.dart`
- `lib/database/db_factory/database_factory.dart`
- `lib/database/db_factory/platform_app.dart`
- `lib/database/app_database.dart`
- `lib/datasource/remote_data_sources/form_template_datasource.dart`
- `lib/datasource/remote_data_sources/assignment_datasource.dart`
- `lib/datasource/remote_data_sources/option_set_datasource.dart`
- `lib/datasource/remote_data_sources/team_datasource.dart`
- `lib/datasource/remote_data_sources/org_unit_datasource.dart`
- `lib/data/form_template_list_service.dart`
- `lib/data/form_template_repository.dart`
- `lib/data/option_set_service.dart`
- `lib/features/assignment/application/assignment_model.provider.dart`
- `lib/features/form_submission/application/submission_edit_access.dart`
- `lib/database/dao/form_template_versions_dao.dart`
- `lib/database/dao/assignments_dao.dart`
