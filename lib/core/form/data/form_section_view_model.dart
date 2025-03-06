import 'package:equatable/equatable.dart';

class FormSectionViewModel with EquatableMixin {
  const FormSectionViewModel(
      this.uid, this.sectionUid, this.label, this.type, this.renderType);

  final String uid;
  final String? sectionUid;
  final String? label;
  final Type type;
  final String? renderType;

  static FormSectionViewModel createForSection(
      String eventUid, String sectionUid, String label, String? renderType) {
    return FormSectionViewModel(
        eventUid, sectionUid, label, Type.SECTION, renderType);
  }

  static FormSectionViewModel createForProgramStage(
      String eventUid, String programStageUid) {
    return FormSectionViewModel(
        eventUid, programStageUid, null, Type.PROGRAM_STAGE, null);
  }

  static FormSectionViewModel createForProgramStageWithLabel(
      String eventUid, String programStageDisplayName, String programStageUid) {
    return FormSectionViewModel(
        eventUid, null, programStageDisplayName, Type.PROGRAM_STAGE, null);
  }

  static FormSectionViewModel createForEnrollment(String enrollmentUid) {
    return FormSectionViewModel(
        enrollmentUid, null, null, Type.ENROLLMENT, null);
  }

  @override
  List<Object?> get props => [uid, sectionUid, label, type, renderType];
}

enum Type { SECTION, PROGRAM_STAGE, ENROLLMENT }
