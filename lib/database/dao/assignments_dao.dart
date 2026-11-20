import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/assignment_model.dart';
import 'package:datarunmobile/database/shared/d_identifiable_model.dart';
import 'package:datarunmobile/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'assignments_dao.g.dart';

@DriftAccessor(tables: [Assignments])
class AssignmentsDao extends DatabaseAccessor<AppDatabase>
    with _$AssignmentsDaoMixin {
  AssignmentsDao(AppDatabase db) : super(db);

  Future<List<AssignmentModel>> allAssignments(
      {String? activityId, String ouSearchFilter = ''}) async {
    var assignmentWithRefs = attachedDatabase.managers.assignments
        .filter((f) => f.disabled.not(true));

    if (activityId != null) {
      assignmentWithRefs =
          assignmentWithRefs.filter((f) => f.activity.id(activityId));
    }

    if (ouSearchFilter.isNotEmpty) {
      assignmentWithRefs = assignmentWithRefs
          .filter((f) => f.orgUnit.name.contains(ouSearchFilter));
    }

    // A supervisor also receives the assignments of the teams he manages.
    // Those teams are in the managed-teams table, not among his own teams.
    final managedTeamCodes = {
      for (final team in await attachedDatabase.managers.managedTeams.get())
        team.id: team.code,
    };

    final result = assignmentWithRefs
        .withReferences((prefetch) =>
            prefetch(forms: true, team: true, activity: true, orgUnit: true))
        .orderBy((o) => o.instanceDate.asc(nulls: NullsOrder.last))
        .map((assignmentsWithRefs) {
      final a = assignmentsWithRefs.$1;
      final forms = assignmentsWithRefs.$2.forms.prefetchedData?.length ?? 0;
      final activity =
          assignmentsWithRefs.$2.activity.prefetchedData?.firstOrNull;
      final ou = assignmentsWithRefs.$2.orgUnit.prefetchedData?.firstOrNull;
      final teamCode =
          assignmentsWithRefs.$2.team.prefetchedData?.firstOrNull?.code ??
              managedTeamCodes[a.team];
      return AssignmentModel(
          id: a.id,
          activity: activity != null
              ? IdentifiableModel(
                  id: activity.id, code: activity.code, name: activity.name)
              : null,
          // One assignment whose org unit did not arrive must not hide the rest.
          orgUnit: IdentifiableModel(
            id: a.orgUnit,
            code: ou?.code,
            name: ou?.name ?? a.orgUnit,
          ),
          team: IdentifiableModel(
            id: a.team,
            code: teamCode,
            name: teamCode ?? '',
          ),
          // startDay: a.startDay,
          startDate: a.instanceDate,
          dueDate: null,
          formCount: forms
          // status: a.assignmentStatus ?? AssignmentStatus.PLANNED,
          );
    }).get();

    return result;
  }
}
