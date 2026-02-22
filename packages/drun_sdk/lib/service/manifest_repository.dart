import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Injectable(scope: UserSession.activeSessionScope)
class ManifestRepository {
  AppDatabase get db => DSdk.db;

  const ManifestRepository();

  Future<void> persistManifest(Map<String, dynamic> manifest) async {
    await db.transaction(() async {
      // 1. principals (user uid, team uids)
      // if provided: persist principals table

      // 2. assignments
      final assignments = manifest['assignments'] as List<dynamic>? ?? [];
      for (final a in assignments) {
        // upsert assignment row by id/uid
        // await upsertAssignment(a as Map<String, dynamic>);
        // upsert assignment_member entries
        final members = (a['members'] as List<dynamic>?) ?? [];
        // for (final m in members)
        //   await upsertAssignmentMember(m as Map<String, dynamic>);
        // upsert assignment_data_template if present on manifest
      }

      // 3. bindings (may be nested under assignments or root)
      // final allBindings = _collectBindings(manifest);
      // for (final b in allBindings) {
      //   await upsertBinding(b as Map<String, dynamic>);
      //   // if binding includes materialized party_set_member pages, persist them too
      // }

      // 4. party_sets & party rows & party_set_member pages (if supplied)
      final partySets = manifest['party_sets'] as List<dynamic>? ?? [];
      for (final ps in partySets) {
        // await upsertPartySet(ps as Map<String, dynamic>);
        // if manifest includes materialized members: persist pages
      }

      // 5. mark sync summary
      await recordManifestSync(DateTime.now().toUtc());
    }); // transaction
  }

  Future<void> recordManifestSync(DateTime when) async {
    await db.into(db.syncSummaries).insertOnConflictUpdate(
        SyncSummariesCompanion(
            entity: Value('manifest'), lastSync: Value(when)));
  }

// Implement upsertAssignment, upsertBinding, upsertPartySet, upsertAssignmentMember helpers.
}
