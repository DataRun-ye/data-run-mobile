import 'package:equatable/equatable.dart';

class FormMetadata with EquatableMixin {
  const FormMetadata({
    // required this.formId,
    // required this.formLabel,
    // required this.activity,
    // required this.assignmentModel,
    required this.assignmentId,
    required this.formId,
    required this.versionUid,
    // required this.version,
    // this.isNew = true,
    // this.version,
    this.submission,
  });

  // final AssignmentModel assignmentModel;
  final String assignmentId;

  // final bool isNew;
  final String formId;

// final bool isNew;
  final String versionUid;

  // final int version;
  final String? submission;

  FormMetadata copyWith({
    String? formId,
    String? versionUid,
    // String? formLabel,
    // String? activity,
    // AssignmentForm? assignmentForm,
    // AssignmentModel? assignmentModel,
    String? assignmentId,
    // int? version,
    String? submission,
  }) {
    return FormMetadata(
      formId: formId ?? this.formId,
      versionUid: versionUid ?? this.versionUid,
      // formLabel: formLabel ?? this.formLabel,
      // activity: activity ?? this.activity,
      assignmentId: assignmentId ?? this.assignmentId,
      // version: version ?? this.version,
      submission: submission ?? this.submission,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        submission,
        versionUid,
        // version,
        // assignmentModel,
        assignmentId,
        formId /*, formLabel, activity*/
      ];
}
