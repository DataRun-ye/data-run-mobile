# Config Fetching And Offline Cache Map

Generated: 2026-07-10

Scope: server-to-local fetching for configuration, metadata, assignments, forms, options, org units, teams, and related rows needed for offline work. This complements `01-production-code-path-map.md` and `02-form-flow.md`; it does not remap form rendering or submission save internals except where those depend on synced config.

Status legend:

- ACTIVE: used by reachable production runtime flow.
- ACTIVE-SEPARATE: reachable production path, but not part of the bulk config sync loop.
- INACTIVE: present but not referenced by active runtime flow found in this scan.
- INCOMPLETE: looks like unfinished feature work.
- LEGACY-RISK: old or duplicate-looking code that could be mistaken for the active path.
- UNKNOWN: cannot prove either way from static references.

## Executive Map

Active sync path:

1. Login or startup routes the user to `SyncResourcesView`.
2. `SyncResourcesViewModel.triggerSync()` calls `SyncManager.syncAll()`.
3. `SyncManager` collects all registered `AbstractDatasource` instances from the active user scope.
4. Each SDK datasource fetches one server resource through `BaseDataSource.syncWithRemote()`.
5. The base datasource maps JSON into Drift row objects, upserts rows in a transaction, optionally writes child tables, optionally disables stale rows, and writes a `sync_summaries` row.
6. Offline screens later read only local Drift tables through DAOs/managers.

Primary active config store:

- A per-user Drift database opened as `datarun_<username>.db`.
- Form definitions are cached as `form_templates` plus `form_template_versions`.
- Form elements live inside JSON/text columns on `form_template_versions.fields`, `sections`, and `options`.
- Assignment access lives in `assignments` plus `assignment_forms`.
- Org, project, activity, team, option, data element, and permission metadata live in their own local tables.

## Active Trigger And Session Setup

| Area | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Login-triggered initial sync | ACTIVE | `lib/features/login/presentation/login_viewmodel.dart` | Successful `AuthManager.login(...)` is followed by `replaceWithSyncResourcesView()` at lines 33-35 and 57-59. | High | Fresh login always enters metadata/config sync before home. |
| Startup-triggered sync | ACTIVE | `lib/features/startup/presentation/splash_viewmodel.dart` | `runStartupLogic()` calls `_syncScheduler.shouldSync()` and routes to `SyncResourcesView` at lines 18-24. | High | Existing users refresh config when online and due. |
| Manual refresh | ACTIVE | `lib/features/home/presentation/drawer/app_drawer_sync_item.dart` | Drawer item calls `replaceWithSyncResourcesView()` at line 53 when online. | High | Users can explicitly refresh offline config. |
| Sync due decision | ACTIVE | `lib/core/sync/sync_scheduler.dart` | `shouldSync()` returns false when offline, true when initial sync is missing, or true when interval elapsed at lines 16-22. | High | Offline startup does not force config fetch; existing local DB remains the source. |
| Sync screen autostart | ACTIVE | `lib/features/sync/presentation/sync_resources_view.dart` | `onViewModelReady` schedules `viewModel.triggerSync()` at lines 77-79. | High | The sync route automatically starts the server fetch. |
| Sync completion flags | ACTIVE | `lib/features/sync/presentation/sync_resources_viewmodel.dart` | On completed global state, updates `SYNC_DONE` and `LAST_SYNC_TIME` at lines 31-33, then routes home at lines 35-37. | High | These SharedPreferences flags control future startup sync decisions. |
| User profile fetch | ACTIVE-SEPARATE | `lib/core/auth/auth_api.dart` | Login posts to `/api/v1/authenticate`; profile fetch reads `/api/v1/myDetails` and converts authorities before `UserSession.fromJson`. | High | User/session config is fetched before bulk sync and saved outside the bulk datasource list. |
| User session activation | ACTIVE | `lib/core/auth/auth_manager.dart` | Login gets user profile at lines 101-105, activates session at line 107, writes session/tokens at lines 109-113, opens user DB and registers `DbManager` at lines 144-159, then calls `registerUserSdkDeps` at line 163. | High | Bulk sync only works after the per-user DB and SDK datasources are registered. |
| Per-user database file | ACTIVE | `packages/drun_sdk/lib/database/db_factory/platform_app.dart` | Opens `UserFileManager(userId).getUserFile('datarun_$userId.db')` and uses a background Drift connection. | High | Offline metadata is scoped by username. |

## Active Bulk Sync Registration

The active datasource list is generated in `packages/drun_sdk/lib/di/init_active_session_scope.dart:33-60`.

Registered as `AbstractDatasource` and therefore collected by `SyncManager`:

1. `ProjectDatasource`
2. `ActivityDatasource`
3. `OuLevelDatasource`
4. `OrgUnitDatasource`
5. `OptionSetDatasource`
6. `DataElementDatasource`
7. `DataFormTemplateDatasource`
8. `TeamDatasource`
9. `UserFormAccessesDatasource`
10. `AssignmentDatasource`

Registered but not part of `SyncManager.getAll<AbstractDatasource>()`:

- `UserDatasource` as a concrete registration.

Why this matters: changing registration order or converting a concrete registration into `AbstractDatasource` changes what the app fetches during config sync. Some tables have foreign keys, so order is not just cosmetic.

## Generic Fetch-Parse-Persist Algorithm

Active implementation: `packages/drun_sdk/lib/datasource/base_datasource.dart`.

| Step | Evidence | Behavior |
| --- | --- | --- |
| Fetch | Lines 41-45 and 172-183 | `getOnlineRaw()` GETs `resourcePath`, defaulting to `<resourceName>?paged=false`, and expects `response.data[resourceName]` to be a list. |
| Extract child rows | Lines 64-82 and 186-193 | Datasources can return `CompanionInsert` rows for auxiliary tables such as options, form versions, managed teams, and assignment forms. |
| Map JSON | Lines 87-108 and 196-208 | Each JSON item becomes a Drift row. The default mapper injects `id`, `dirty: false`, `isToUpdate: true`, default `label`, and default `translations`, then calls `fromApiJson(..., CustomSerializer())`. |
| Upsert main rows | Lines 110-116 | Mapped rows are written with `insertAllOnConflictUpdate(table, mapped)`. |
| Refresh child table | Lines 118-126 | If extras exist, the code deletes all rows from `extra.first.table`, then upserts every extra row. This is a full child-table refresh per datasource, not a per-parent merge. |
| Disable stale rows | Lines 131-138 | If live IDs exist and fetch did not fail, datasource-specific `disableStale(liveIds)` may run. Base implementation is no-op. |
| Sync summary | Lines 161-167 | Writes `sync_summaries` with success count, failure count, and serialized errors. |

Important behavior to verify: fetch errors are caught and converted to `syncErrors`, but the method continues with empty data and can still emit a final saved/succeeded progress event unless the database write fails.

## Entity Fetch And Storage Map

| Entity/resource | Classification | Server endpoint/path | Parser/normalizer | Local storage | Stale behavior | Offline consumer evidence | Confidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| User session/profile | ACTIVE-SEPARATE | `POST /api/v1/authenticate`, `GET /api/v1/myDetails` | `AuthApi.getUserProfile` flattens authorities before `UserSession.fromJson`; `AuthStorage` stores active user/session/tokens. | SharedPreferences/session storage/token storage; per-user DB then opens. | Not a bulk datasource refresh. | `AuthManager.login` requires profile before session activation. | High |
| Projects | ACTIVE | `projects?paged=false` | `ProjectDatasource.fromApiJson` uses default mapping. | `projects` table: `name`, `code`, `disabled`. | No datasource `disableStale` override found. | Activities reference projects. | High |
| Activities | ACTIVE | `activities?paged=false` | `ActivityDatasource.fromApiJson` collapses nested `project.uid`/`project.id` to `project`. | `activities` table references `projects`; includes disabled/start/end/description. | Overrides `disableStale` to set `disabled = true`. | Assignment list prefetches activity refs. | High |
| OU levels | ACTIVE | `ouLevels?paged=false` | `OuLevelDatasource.fromApiJson` uses default mapping. | `ou_levels` table: name/code/level/offlineLevels. | No datasource `disableStale` override found. | Org hierarchy support; direct active UI use not deeply traced in this pass. | Medium |
| Org units | ACTIVE | `orgUnits?paged=false` | `OrgUnitDatasource.fromApiJson` collapses nested `parent.uid`/`parent.id` to `parent`. | `org_units` table: name/code/path/level/parent. | No datasource `disableStale` override found. | Assignment list/detail prefetch org unit refs. | High |
| Option sets | ACTIVE | `optionSets?paged=false` | `OptionSetDatasource` maps option sets and extracts nested `options` into `DataOption` rows with `optionSet`, `order`, label/translations, and delete flags. | `data_option_sets`; child `data_options`. | No option-set stale override found. Child `data_options` is fully deleted/reinserted when extras exist. | `OptionSetService.getOptions` reads local `dataOptions` and `dataOptionSets` for select fields. | High |
| Data elements | ACTIVE | `dataElements?paged=false` | `DataElementDatasource.fromApiJson` collapses nested `optionSet.uid` to `optionSet`. | `data_elements` table: value type, optionSet, mandatory/default/scanned-code/resource metadata columns. | No datasource `disableStale` override found. | Form element templates may refer to data element metadata; direct active form rendering mainly uses `form_template_versions` JSON. | Medium |
| Form templates | ACTIVE | `formTemplates?paged=false` | `DataFormTemplateDatasource.mapRemoteItem` marks disabled; `fromApiJson` treats `disabled` or `deleted` as disabled. | `form_templates`: id/version/name/label/disabled. | Overrides `disableStale` to set `disabled = true`. | Form lists and assignment access query `formTemplates`. | High |
| Form template versions/elements | ACTIVE | Extra fetch: `formTemplateVersions?paged=false` from `DataFormTemplateDatasource._getFormVersions`. | Each item becomes `FormTemplateVersion` with `id = uid` and `template = templateUid`. Drift converters parse/store `fields`, `sections`, and `options` JSON. | `form_template_versions`: template FK, versionNumber, `fields`, `sections`, `options`. | Child table is fully deleted/reinserted when form template extras exist. Separate `FormTemplateVersionDatasource` is not active. | `FormTemplateListService.getTemplateByVersionOrLatest` and `FormTemplateVersionsDao.selectFormTemplatesWithRefs` read this table to open forms. | High |
| Teams | ACTIVE | `teams?paged=false` | `TeamDatasource.fromApiJson` collapses nested activity UID and marks disabled if team or activity is disabled. | `teams`; child `managed_teams`. | Overrides `disableStale` to set `disabled = true`. Child `managed_teams` is fully deleted/reinserted when extras exist. | Assignment list/detail prefetch team refs; team fields can read managed teams. | High |
| Form permissions | ACTIVE | `formPermissions` | `UserFormAccessesDatasource` maps rows directly; `extractId` returns empty string because primary key is team+form. | `user_form_permissions`: team, form, valid dates, permissions list. | No datasource stale override found. | Access is partly represented elsewhere by `assignment_forms`; direct active use of `user_form_permissions` was not proven in this pass. | Medium |
| Assignments | ACTIVE | `assignments?paged=false` | `AssignmentDatasource.mapRemoteItem` collapses nested activity/orgUnit/team UIDs, defaults status to `PLANNED`, sets `syncState: synced`, and maps disabled. | `assignments`: activity/team/orgUnit FKs, dates, status, syncState, disabled. | Overrides `disableStale` to set `disabled = true`. | Assignment screens read assignments with org/team/activity/form refs. | High |
| Assignment forms/access | ACTIVE | Extra fetch: `assignments/forms?paged=false` | `_AssignmentWithAccess.fromJson` expands `accessibleForms` into `AssignmentForm` rows. | `assignment_forms`: assignment+form PK, canAdd/canView/canEdit/canDelete flags. | Child table is fully deleted/reinserted when assignment extras exist. | `FormTemplateListService.userAvailableForms` and assignment permission checks read this table. | High |
| Data submissions | ACTIVE, DATA-NOT-CONFIG | `dataSubmission?paged=false` | `DataInstanceDatasource.fromApiJson` computes form/version id, sets local sync status to synced, maps assignment/orgUnit/team values. | `data_instances`: formTemplate/templateVersion/assignment refs, whole `formData`, sync flags. | No datasource stale override found. | Offline submission list/edit paths read `data_instances`. Covered more fully in `02-form-flow.md`. | High |
| Sync summaries | ACTIVE | Local only | `BaseDataSource.syncWithRemote` writes one summary row per resource. | `sync_summaries`: entity, lastSync, success/failure count, errors, lastSuccessfulSync. | N/A | Sync summary UI watches `syncSummariesDao.watchAllSummaries`. | High |

## How Key Entities Are Stored Locally

| Local table | Evidence | Stored shape |
| --- | --- | --- |
| `form_templates` | `packages/drun_sdk/lib/database/tables/form_templates.table.dart:4-25` | One row per form template with current version UID/number, name, label JSON map, description, disabled. |
| `form_template_versions` | `packages/drun_sdk/lib/database/tables/form_template_versions.table.dart:8-23` | One row per form version. `fields`, `sections`, and `options` are JSON/text columns mapped by `TemplateListConverter` and `FormOptionListConverter`. |
| `assignments` | `packages/drun_sdk/lib/database/tables/assignments.table.dart:6-28` | One row per assignment, linked to activity/team/org unit, with instance date, sync state, assignment status, completed date, client update time, disabled. |
| `assignment_forms` | `packages/drun_sdk/lib/database/tables/assignment_forms.table.dart:4-25` | Join/access table between assignment and form with add/view/edit/delete booleans. |
| `org_units` | `packages/drun_sdk/lib/database/tables/org_units.table.dart:8-18` | Org unit hierarchy with name/code/path/level/parent. |
| `activities` | `packages/drun_sdk/lib/database/tables/activities.table.dart:5-18` | Activity rows linked to project and disabled/date/description fields. |
| `teams` and `managed_teams` | `packages/drun_sdk/lib/database/tables/teams.table.dart:6-12`; `managed_teams.table.dart:5-12` | Team rows linked to activity; managed teams linked to managing team and activity. |
| `data_option_sets` and `data_options` | `option_sets.table.dart:6-11`; `options.table.dart:6-20` | Option sets and options, including option order, code/name, option-set FK, deletedAt. |
| `data_elements` | `data_elements.table.dart:7-33` | Metadata for value type, option set, defaults, scanning properties, and resource metadata schema. |
| `user_form_permissions` | `user_form_permissions.dart:6-20` | Team/form permission rows with converted permissions list. |
| `data_instances` | `data_submissions.table.dart:9-56` | Offline submission data and synced server submissions as one whole `formData` JSON map plus sync flags. |
| `sync_summaries` | `sync_summaries.dart:4-20` | Per-resource sync status, counts, serialized errors, and timestamps. |

`AppDatabase` registers both active and inactive-looking tables in one Drift database at `packages/drun_sdk/lib/database/app_database.dart:11-36`; table presence alone does not prove active sync use.

## Offline Consumption After Sync

| Consumer | Evidence | Local rows required |
| --- | --- | --- |
| Assignment list | `packages/drun_sdk/lib/database/dao/assignments_dao.dart:97-132` reads non-disabled assignments with prefetched forms, team, activity, and org unit. | `assignments`, `assignment_forms`, `teams`, `activities`, `org_units`. |
| Assignment detail/access checks | `lib/features/assignment/application/assignment_service_impl.dart:43-83` fetches assignment with org/team/activity/forms; lines 98-142 check assignment form permissions and synced/local submission state. | `assignments`, `assignment_forms`, `form_templates`, `data_instances`. |
| Available forms | `lib/data/form_template_list_service.dart:23-47` reads `assignmentForms`, then `formTemplates`; lines 111-131 further filter by active user forms and `canAddSubmissions`. | `assignment_forms`, `form_templates`, user session form ids. |
| Form list/latest version | `lib/data/form_template_list_service.dart:154-180` and `form_template_versions_dao.dart:30-100` join form templates, form versions, and assignment forms to produce `FormTemplateModel`. | `form_templates`, `form_template_versions`, `assignment_forms`. |
| Form opening | `lib/data/form_template_repository.dart:18-27` loads the selected version and option sets/options before the form tree is built. | `form_template_versions`, `data_option_sets`, `data_options`. |
| Select/choice fields | `lib/data/option_set_service.dart:11-47` and `72-98` read local options and option sets, filtering out deleted records. | `data_options`, `data_option_sets`. |

## Inactive, Incomplete, Or Duplicate-Looking Paths

| Classification | File path | Evidence | Why it matters |
| --- | --- | --- | --- |
| OBSOLETE-REMOVED | Abandoned manifest services, party resolver, and `assignment_manifests`/party table declarations | No runtime consumer existed; persistence was TODO/comment-only; the resolver returned placeholders; the Play schema-3 database has none of these tables. Removed from active DI/schema declarations without a `DROP TABLE` migration. | Existing databases that happen to contain these unowned tables retain them, but active code no longer presents them as a production capability. |
| LEGACY-RISK | `packages/drun_sdk/lib/database/dao/base_dao_extension.dart` and DAO `syncWithRemote` mixins | Many DAOs import `BaseDaoMixin`, which duplicates the datasource fetch/upsert algorithm. Active `SyncManager` calls `AbstractDatasource.syncWithRemote`, not DAO sync methods. | Changing DAO sync code may not affect production config fetch, while changing datasource code will. |
| LEGACY-RISK | `packages/drun_sdk/lib/datasource/remote_datasource_order_map.dart` | Defines `DSOrder` and ordered datasource type map, including commented/unused resources. Active registration is generated in `init_active_session_scope.dart`. | Useful evidence for intended order, but not the runtime list by itself. |
| INACTIVE | `DataValueDatasource`, `RepeatInstanceDatasource`, `MetadataSubmissionDatasource`, `FormTemplateVersionDatasource`, `OptionDatasource` | Injectable annotations are commented or these are not registered as active `AbstractDatasource` in `init_active_session_scope.dart`. | Table/datasource names sound form-related but are not active for current config or form capture sync. |
| LEGACY-RISK | `lib/core/sync_manager/sync_service.provider.dart` | Riverpod `SyncService.performSync` only checks connectivity and writes SharedPreferences; real download call is commented. Active UI uses `SyncResourcesViewModel` and `SyncManager`. | Do not use this provider as the source of truth for config fetching. |
| ACTIVE-SEPARATE/UNKNOWN | `UserDatasource` | Registered as concrete `UserDatasource`, not as `AbstractDatasource`; active profile fetch is through `AuthApi.getUserProfile`. | It may be usable manually, but it is not part of `SyncManager.syncAll()` based on current registrations. |

## Risks And Questions For Next Pass

1. Does `GetIt.getAll<AbstractDatasource>()` preserve the generated registration order on all targets? The current order matters for FK-linked tables.
2. Should resources without `disableStale` keep stale rows forever, especially projects, org units, option sets, data elements, and form permissions?
3. Child-table refresh deletes all rows from the child table before reinserting extras. Confirm this is acceptable for `form_template_versions`, `assignment_forms`, `managed_teams`, and `data_options`.
4. Confirm runtime behavior when one resource fetch fails: the base datasource records errors, but may still emit a final succeeded event and the sync screen may mark global sync done.
5. Confirm whether `user_form_permissions` is still needed, since active form access appears to rely mostly on `assignment_forms`.

## Do Not Touch Until Understood

- `lib/features/sync/presentation/sync_resources_viewmodel.dart`
- `lib/core/sync_manager/sync_manager.dart`
- `packages/drun_sdk/lib/datasource/base_datasource.dart`
- `packages/drun_sdk/lib/di/init_active_session_scope.dart`
- `lib/core/auth/auth_manager.dart`
- `lib/core/auth/auth_api.dart`
- `lib/core/auth/auth_storage.dart`
- `packages/drun_sdk/lib/database/db_factory/database_factory.dart`
- `packages/drun_sdk/lib/database/db_factory/platform_app.dart`
- `packages/drun_sdk/lib/database/app_database.dart`
- `packages/drun_sdk/lib/datasource/remote_data_sources/form_template_datasource.dart`
- `packages/drun_sdk/lib/datasource/remote_data_sources/assignment_datasource.dart`
- `packages/drun_sdk/lib/datasource/remote_data_sources/option_set_datasource.dart`
- `packages/drun_sdk/lib/datasource/remote_data_sources/team_datasource.dart`
- `packages/drun_sdk/lib/datasource/remote_data_sources/data_submission_datasource.dart`
- `packages/drun_sdk/lib/datasource/remote_data_sources/org_unit_datasource.dart`
- `packages/drun_sdk/lib/datasource/remote_data_sources/data_element_datasource.dart`
- `lib/data/form_template_list_service.dart`
- `lib/data/form_template_repository.dart`
- `lib/data/option_set_service.dart`
- `lib/features/assignment/application/assignment_service_impl.dart`
- `packages/drun_sdk/lib/database/dao/form_template_versions_dao.dart`
- `packages/drun_sdk/lib/database/dao/assignments_dao.dart`
