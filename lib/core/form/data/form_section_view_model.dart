import 'package:equatable/equatable.dart';

class FormSectionViewModel with EquatableMixin {
  const FormSectionViewModel(this.uid, this.sectionUid, this.label, this.type,
      this.renderType, this.path);

  final String uid;
  final String? path;
  final String? sectionUid;
  final String? label;
  final Type type;
  final String? renderType;

  static FormSectionViewModel createForSection(String eventUid,
      String sectionUid, String label, String? renderType, String path) {
    return FormSectionViewModel(
        eventUid, sectionUid, label, Type.SECTION, renderType, path);
  }

  static FormSectionViewModel createForProgramStage(
      String eventUid, String programStageUid, String path) {
    return FormSectionViewModel(
        eventUid, programStageUid, null, Type.PROGRAM_STAGE, null, path);
  }

  static FormSectionViewModel createForProgramStageWithLabel(String eventUid,
      String programStageDisplayName, String programStageUid, path) {
    return FormSectionViewModel(eventUid, null, programStageDisplayName,
        Type.PROGRAM_STAGE, null, path);
  }

  static FormSectionViewModel createForEnrollment(String enrollmentUid) {
    return FormSectionViewModel(
        enrollmentUid, null, null, Type.ENROLLMENT, null, null);
  }

  @override
  List<Object?> get props => [uid, sectionUid, label, type, renderType, path];
}

enum Type { SECTION, PROGRAM_STAGE, ENROLLMENT }
