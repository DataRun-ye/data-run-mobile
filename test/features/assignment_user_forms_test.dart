import 'dart:math';

import 'package:collection/collection.dart';
import 'package:datarunmobile/data/teams.provider.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/assignment_model.dart';
import 'package:datarunmobile/database/shared/collections.dart';
import 'package:datarunmobile/database/shared/d_identifiable_model.dart';
import 'package:datarunmobile/features/assignment/application/assignment_model.provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('each assignment gets exactly its own forms, sorted by form', () {
    final random = Random(7);
    final assignments = [
      for (var a = 0; a < 300; a++) _assignment('assignment-$a'),
    ];
    final userForms = [
      for (var f = 0; f < 900; f++)
        AssignmentFormAvailability(
          assignmentForm: AssignmentForm(
            // Some forms belong to assignments of other activities.
            assignment: 'assignment-${random.nextInt(400)}',
            form: 'form-${random.nextInt(20)}',
          ),
          isAvailableLocally: random.nextBool(),
        ),
    ];

    final result = withUserForms(assignments, userForms);

    // The per-assignment scan this replaces, kept as the reference.
    List<Pair<AssignmentForm, bool>> scanned(AssignmentModel assignment) =>
        userForms
            .where((uf) => uf.assignmentForm.assignment == assignment.id)
            .map((uf) => Pair(uf.assignmentForm, uf.isAvailableLocally))
            .sorted((a, b) => a.first.form.compareTo(b.first.form))
            .toList();

    expect(result.map((a) => a.id), assignments.map((a) => a.id));
    for (final assignment in result) {
      expect(assignment.userForms, scanned(assignment), reason: assignment.id);
    }
    expect(result.where((a) => a.userForms.isEmpty), isNotEmpty);
  });
}

AssignmentModel _assignment(String id) => AssignmentModel(
      id: id,
      orgUnit: IdentifiableModel(id: 'org-$id', name: 'Village'),
      team: IdentifiableModel(id: 'team-1', name: 'Team'),
    );
