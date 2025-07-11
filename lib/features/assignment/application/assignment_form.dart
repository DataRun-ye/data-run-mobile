import 'package:equatable/equatable.dart';

import 'package:d_sdk/database/shared/assignment_model.dart';

class AssignmentForm with EquatableMixin {
  AssignmentForm(
      {required this.assignmentModel, required this.formId, this.isNew = true});

  final AssignmentModel assignmentModel;
  final bool isNew;
  final String formId;

  @override
  List<Object?> get props => [assignmentModel, isNew, formId];
}
