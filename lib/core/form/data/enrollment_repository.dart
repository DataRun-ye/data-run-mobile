// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/collections.dart';
import 'package:datarunmobile/core/form/data/data_entry_base_repository.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:datarunmobile/core/form/ui/field_view_model_factory.dart';

class EnrollmentRepository extends DataEntryBaseRepository {
  EnrollmentRepository(
      {required FieldViewModelFactory fieldFactory,
      required this.formTemplateVersion,
      required this.enrollmentUid})
      : super(fieldFactory);

  static const String ENROLLMENT_DATA_SECTION_UID =
      'ENROLLMENT_DATA_SECTION_UID';
  static const String ENROLLMENT_DATE_UID = 'ENROLLMENT_DATE_UID';
  static const String INCIDENT_DATE_UID = 'INCIDENT_DATE_UID';
  static const String ORG_UNIT_UID = 'ORG_UNIT_UID';
  static const String TEI_COORDINATES_UID = 'TEI_COORDINATES_UID';
  static const String ENROLLMENT_COORDINATES_UID = 'ENROLLMENT_COORDINATES_UID';

  final String enrollmentUid;
  final FormTemplateVersion formTemplateVersion;

  //
  // final EnrollmentMode enrollmentMode;
  // final EnrollmentFormLabelsProvider enrollmentFormLabelsProvider;
  // Future<Enrollment?>? _enrollment;
  // Future<Program?>? _program;
  // Future<List<ProgramSection>>? _programSections;

  @override
  bool isEvent() {
    return false;
  }

  @override
  Future<List<FieldUiModel>> list() async {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> sectionUids() async {
    throw UnimplementedError();
  }

  Future<List<FieldUiModel>> _getEnrollmentData(/*Program program*/) async {
    throw UnimplementedError();
  }

  Future<List<FieldUiModel>> _getFieldsForMultipleSections() async {
    throw UnimplementedError();
  }

  Future<List<FieldUiModel>> _getSingleSectionList() async {
    throw UnimplementedError();
  }

  Future<List<FieldUiModel>> _getFieldsForSingleSection() async {
    throw UnimplementedError();
  }

  @override
  // TODO: implement disableCollapsableSections
  bool? get disableCollapsableSections => throw UnimplementedError();

  @override
  String? firstSectionToOpen() {
    // TODO: implement firstSectionToOpen
    throw UnimplementedError();
  }

  @override
  List<FieldUiModel> getSpecificDataEntryItems(String uid) {
    // TODO: implement getSpecificDataEntryItems
    throw UnimplementedError();
  }

  @override
  Pair<String, List<DataOption>> options(
      {required String optionSetUid,
      List<String> optionsToHide = const [],
      List<String> optionGroupsToHide = const [],
      List<String> optionGroupsToShow = const []}) {
    // TODO: implement options
    throw UnimplementedError();
  }

// Future<String?> _getAttributeValue(TrackedEntityAttributeValue? attrValue) {
//   if (attrValue != null) {
//     return attrValue.userFriendlyValue();
//   } else {
//     return Future.value();
//   }
// }
//
// SectionRenderingType? _getSectionRenderingType(
//     ProgramSection? programSection) {
//   return SectionRenderingType.valueOf(programSection?.renderType);
// }

// String? _getError(TrackerImportConflict? conflict, String? dataValue) {
//   if (conflict != null) {
//     if (conflict.value == dataValue) {
//       return conflict.displayDescription;
//     }
//   }
//   return null;
// }
}
