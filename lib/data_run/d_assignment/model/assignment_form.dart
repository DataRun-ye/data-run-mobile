import 'package:equatable/equatable.dart';

import 'package:datarunmobile/data_run/d_assignment/model/assignment_model.dart';

class AssignmentForm with EquatableMixin {
  AssignmentForm(
      {required this.assignmentModel, required this.formId, this.isNew = true});

  final AssignmentModel assignmentModel;
  final bool isNew;
  final String formId;

  @override
  List<Object?> get props => [assignmentModel, isNew, formId];
}
