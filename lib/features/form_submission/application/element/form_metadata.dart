import 'package:equatable/equatable.dart';

class FormMetadata with EquatableMixin {
  const FormMetadata({
    this.assignmentId,
    required this.formId,
    required this.versionUid,
    this.submission,
  });

  final String? assignmentId;

  final String formId;

  final String versionUid;

  final String? submission;

  FormMetadata copyWith({
    String? formId,
    String? versionUid,
    String? assignmentId,
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
