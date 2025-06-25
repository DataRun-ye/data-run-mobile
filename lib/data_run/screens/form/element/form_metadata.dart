import 'package:datarunmobile/data_run/d_assignment/model/assignment_model.dart';
import 'package:equatable/equatable.dart';

class FormMetadata with EquatableMixin {
  const FormMetadata({
    // required this.formId,
    // required this.formLabel,
    // required this.activity,
    required this.assignmentModel,
    required this.formId,
    required this.versionUid,
    required this.version,
    // this.isNew = true,
    // this.version,
    this.submission,
  });

  // final String formId;

  // final String activity;
  // final String formLabel;
  // final AssignmentForm assignmentForm;

  final AssignmentModel assignmentModel;

  // final bool isNew;
  final String formId;

// final bool isNew;
  final String versionUid;
  final int version;
  final String? submission;

  FormMetadata copyWith({
    String? formId,
    String? versionUid,
    // String? formLabel,
    // String? activity,
    // AssignmentForm? assignmentForm,
    AssignmentModel? assignmentModel,
    int? version,
    String? submission,
  }) {
    return FormMetadata(
      formId: formId ?? this.formId,
      versionUid: versionUid ?? this.versionUid,
      // formLabel: formLabel ?? this.formLabel,
      // activity: activity ?? this.activity,
      assignmentModel: assignmentModel ?? this.assignmentModel,
      version: version ?? this.version,
      submission: submission ?? this.submission,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        submission,
        versionUid,
        version,
        assignmentModel, formId /*, formLabel, activity*/
      ];
}
