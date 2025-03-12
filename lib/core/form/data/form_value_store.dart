import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:datarunmobile/commons/helpers/lazy.dart';
import 'package:datarunmobile/core/form/model/store_result.dart';

class FormValueStore {
  FormValueStore({
    required this.recordUidFuture,
    // required this.entryMode,
    // required this.enrollmentRepository,
    // this.crashReportController,
    // required this.networkUtils,
    // required this.resourceManager,
  });

  Future<String> recordUidFuture;
  late /*final*/ String recordUid;

  // EntryMode entryMode;

  // EnrollmentObjectRepository? enrollmentRepository;

  // CrashReportController crashReportController;
  // NetworkUtils networkUtils;
  // ResourceManager resourceManager;

  Lazy<String> get _loadRecordUid =>
      Lazy(() async => recordUid = await recordUidFuture);

  Future<StoreResult> save(String uid, String? value, String? extraData) async {
    return saveDataElement(uid, value);
  }

  Future<StoreResult> saveDataElement(String uid, String? value) async {
    throw UnimplementedError();
  }

  Future<bool> eventStateIsFinal() async {
    final DataFormSubmission? submission = await D2Remote
        .formSubmissionModule.formSubmission
        .byId(recordUid)
        .getOne();
    return submission?.isFinal ?? false;
  }

  Future<StoreResult> saveWithTypeCheck(String uid, String? value) async {
    throw UnimplementedError();
  }

  Future<StoreResult> deleteOptionValueIfSelected(
      String field, String optionUid) async {
    return deleteDataElementValue(field, optionUid);
  }

  Future<StoreResult> deleteDataElementValue(
      String field, String optionUid) async {
    throw UnimplementedError();
  }

  Future<StoreResult> deleteDataElementValueIfNotInGroup(
      String field, List<String> optionCodesToShow, bool isInGroup) async {
    throw UnimplementedError();
  }

  Future<void> completeEvent() async {
    try {
      // d2.eventModule().events().uid(recordUid).setStatus(EventStatus.COMPLETED);
    } catch (d2Error) {
      logError('', data: {'error': d2Error});
    }
  }

  Future<void> activateEvent() async {
    try {
      // d2.eventModule().events().uid(recordUid).setStatus(EventStatus.ACTIVE);
    } catch (d2Error) {
      logError('', data: {'error': d2Error});
    }
  }

// Future<StoreResult> checkStoreEnrollmentDetail(
//     String uid, String? value, String? extraData) async {
//   if (uid == EnrollmentDetail.ENROLLMENT_DATE_UID.name) {
//     await enrollmentRepository?.setEnrollmentDate(value.toDate());
//
//     return StoreResult(
//         uid: EnrollmentDetail.ENROLLMENT_DATE_UID.name,
//         valueStoreResult: ValueStoreResult.VALUE_CHANGED);
//   }
//   if (uid == EnrollmentDetail.INCIDENT_DATE_UID.name) {
//     await enrollmentRepository?.setIncidentDate(value.toDate());
//
//     return StoreResult(
//         uid: EnrollmentDetail.INCIDENT_DATE_UID.name,
//         valueStoreResult: ValueStoreResult.VALUE_CHANGED);
//   }
//   if (uid == EnrollmentDetail.ORG_UNIT_UID.name) {
//     return const StoreResult(
//         uid: '', valueStoreResult: ValueStoreResult.VALUE_CHANGED);
//   }
//   if (uid == EnrollmentDetail.TEI_COORDINATES_UID.name) {
//     Geometry? geometry;
//     // if(value != null) {
//     //   if(extraData != null){
//     //     geometry = Geometry.builder()
//     //         .coordinates(value)
//     //         .type(FeatureType.valueOf(it))
//     //         .build();
//     //   }
//     await saveTeiGeometry(geometry);
//     return const StoreResult(
//         uid: '', valueStoreResult: ValueStoreResult.VALUE_CHANGED);
//   }
//   if (uid == EnrollmentDetail.ENROLLMENT_COORDINATES_UID.name) {
//     Geometry? geometry;
//     // if(value != null) {
//     //   if(extraData != null){
//     //     geometry = Geometry.builder()
//     //         .coordinates(value)
//     //         .type(FeatureType.valueOf(it))
//     //         .build();
//     //   }
//     try {
//       await saveEnrollmentGeometry(geometry);
//       return const StoreResult(
//           uid: '', valueStoreResult: ValueStoreResult.VALUE_CHANGED);
//     } on D2Error catch (d2Error) {
//       String errorMessage = '${d2Error.errorDescription}: $geometry';
//       // crashReportController.trackError(d2Error, errorMessage);
//       return const StoreResult(
//           uid: '', valueStoreResult: ValueStoreResult.ERROR_UPDATING_VALUE);
//     }
//   }
//
//   return saveAttribute(uid, value);
// }

// Future<void> saveTeiGeometry(Geometry? geometry) async {
//   // TODO(NMC): Implement
//   // var teiRepository = d2.trackedEntityModule().trackedEntityInstances()
//   //     .uid(enrollmentRepository?.blockingGet()?.trackedEntityInstance())
//   // teiRepository.setGeometry(geometry);
// }

// Future<void> saveEnrollmentGeometry(Geometry? geometry) async {
//   await enrollmentRepository?.setGeometry(geometry);
// }

// Future<StoreResult> saveAttribute(String uid, String? value) async {
//   String? teiUid;
//
//   switch (entryMode) {
//     case EntryMode.DE:
//       await _loadRecordUid();
//       final Event event =
//           (await D2Remote.trackerModule.event.byId(recordUid).getOne())!;
//       final Enrollment enrollment = (await D2Remote.trackerModule.enrollment
//           .byId(event.enrollment.id)
//           .getOne())!;
//
//       teiUid = enrollment.trackedEntityInstance.id;
//       break;
//     case EntryMode.ATTR:
//       await _loadRecordUid();
//       teiUid = recordUid;
//       break;
//     case EntryMode.DV:
//       break;
//   }
//
//   if (teiUid == null) {
//     return StoreResult(
//         uid: uid, valueStoreResult: ValueStoreResult.VALUE_HAS_NOT_CHANGED);
//   }
//
//   if (!(await checkUniqueFilter(uid, value, teiUid))) {
//     return StoreResult(
//         uid: uid, valueStoreResult: ValueStoreResult.VALUE_NOT_UNIQUE);
//   }
//
//   final TrackedEntityAttributeValueQuery valueRepository = D2Remote
//       .trackerModule.trackedEntityAttributeValue
//       .byAttribute(uid)
//       .byTrackedEntityInstance(teiUid);
//
//   final tea =
//       await D2Remote.programModule.trackedEntityAttribute.byId(uid).getOne();
//   final ValueType? valueType = tea?.valueType.toValueType;
//
//   String newValue = value.withValueTypeCheck(valueType) ?? '';
//
//   if (valueType == ValueType.IMAGE && value != null) {
//     newValue = await saveFileResource(value);
//   }
//
//   String? currentValue;
//   if (await valueRepository.blockingExists()) {
//     currentValue =
//         (await valueRepository.getOne())?.value.withValueTypeCheck(valueType);
//   } else {
//     currentValue = '';
//   }
//
//   if (currentValue != newValue) {
//     if (!value.isNullOrEmpty) {
//       await valueRepository.blockingSetCheck(uid, newValue,
//           (String attrUid, String value) {
//         // crashReportController.addBreadCrumb(
//         //     'blockingSetCheck Crash',
//         //     'Attribute: $attrUid, value: $value'
//         // );
//       });
//     } else {
//       await valueRepository.blockingDeleteIfExist();
//     }
//     return StoreResult(
//         uid: uid, valueStoreResult: ValueStoreResult.VALUE_CHANGED);
//   } else {
//     return StoreResult(
//         uid: uid, valueStoreResult: ValueStoreResult.VALUE_HAS_NOT_CHANGED);
//   }
// }

// Future<bool> checkUniqueFilter(
//     String uid, String? value, String teiUid) async {
//   // NMC: TODO
//   // if (!networkUtils.isOnline()) {
//   //   return isTrackedEntityAttributeValueUnique(uid, value, teiUid);
//   // } else {
//   //   var programUid = enrollmentRepository?.blockingGet()?.program();
//   //   return isUniqueTEIAttributeOnline(uid, value, teiUid, programUid);
//   // }
//   return true;
// }

////////////////////////////////////////////////////////////
/////////////////////////////////////////
//   Future<String> saveFileResource(String path) async {
//
//     // var file = FileResizerHelper.resizeFile(
//     //     File(path), FileResizerHelper.Dimension.MEDIUM);
//     // return d2.fileResourceModule().fileResources().blockingAdd(file)
//     return '';
//   }

// Future<StoreResult> deleteAttributeValue(
//     String field, String optionUid) async {
//   final Option option =
//       (await D2Remote.optionModule.option.byId(optionUid).getOne())!;
//   final List<String> possibleValues = [option.name!, option.code!];
//   await _loadRecordUid();
//   final TrackedEntityAttributeValueQuery valueRepository = D2Remote
//       .trackerModule.trackedEntityAttributeValue
//       .byAttribute(field)
//       .byTrackedEntityInstance(recordUid);
//   if ((await valueRepository.blockingExists()) &&
//       possibleValues.contains((await valueRepository.getOne())?.value)) {
//     return saveAttribute(field, null);
//   } else {
//     return StoreResult(
//         uid: field, valueStoreResult: ValueStoreResult.VALUE_HAS_NOT_CHANGED);
//   }
// }
//
// Future<StoreResult> deleteOptionValueIfSelectedInGroup(
//     String field, String optionGroupUid, bool isInGroup) async {
//   final List<OptionGroupOption>? optionGroupOptions = (await D2Remote
//           .optionModule.optionGroup
//           .byId(optionGroupUid)
//           .withOptions()
//           .getOne())
//       ?.options;
//
//   final List<String> optionsInGroup = await Future.wait(
//       optionGroupOptions?.map((OptionGroupOption option) async {
//             // final String code = (await D2Remote.optionModule.option.getOne())!.code!;
//             return (await D2Remote.optionModule.option
//                     .byId(option.option)
//                     .getOne())!
//                 .code!;
//             // optionsInGroup.add(code);
//           }) ??
//           []);
//
//   switch (entryMode) {
//     case EntryMode.DE:
//       return deleteDataElementValueIfNotInGroup(
//           field, optionsInGroup, isInGroup);
//     case EntryMode.ATTR:
//       return deleteAttributeValueIfNotInGroup(
//           field, optionsInGroup, isInGroup);
//     case EntryMode.DV:
//       throw ArgumentError(
//           "DataValues can't be saved using these arguments. Use the other one.");
//   }
// }
//
// Future<StoreResult> deleteAttributeValueIfNotInGroup(
//     String field, List<String> optionCodesToShow, bool isInGroup) async {
//   await _loadRecordUid();
//   final TrackedEntityAttributeValueQuery valueRepository = D2Remote
//       .trackerModule.trackedEntityAttributeValue
//       .byAttribute(field)
//       .byTrackedEntityInstance(recordUid);
//   if ((await valueRepository.blockingExists()) &&
//       optionCodesToShow.contains((await valueRepository.getOne())?.value) ==
//           isInGroup) {
//     return saveAttribute(field, null);
//   } else {
//     return StoreResult(
//         uid: field, valueStoreResult: ValueStoreResult.VALUE_HAS_NOT_CHANGED);
//   }
// }
}
