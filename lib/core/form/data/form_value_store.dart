import 'dart:io';

import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/helpers/lazy.dart';
import 'package:datarunmobile/core/form/model/store_result.dart';
import 'package:datarunmobile/core/form/model/value_store_result.dart';
import 'package:datarunmobile/core/resources/resource_manager.provider.dart';

class FormValueStore {
  FormValueStore(
    this._db,
    this._recordUid,
    // this._entryMode,
    // this._enrollmentRepository,
    // this._eventRepository,
    // this._crashReportController,
    // this._networkUtils,
    // this._resourceManager,
    /*{
        FileController? fileController,
        UniqueAttributeController? uniqueAttributeController,
      }*/
  ) /*: _fileController = fileController ?? FileController(),
        _uniqueAttributeController = uniqueAttributeController ??
            UniqueAttributeController(_d2, _crashReportController)*/
  ;

  final AppDatabase _db;

  /// a submission uid for elements not in repeat
  /// or a repeat uid for elements inside the repeat
  final String _recordUid;

  // final EntryMode _entryMode;
  // final EnrollmentObjectRepository? _enrollmentRepository;
  // final EventObjectRepository? _eventRepository;
  // final CrashReportController _crashReportController;
  // final NetworkUtils _networkUtils;
  // final ResourceManager _resourceManager;
  // final FileController _fileController;
  // final UniqueAttributeController _uniqueAttributeController;

  Future<StoreResult> save(String uid, String? value, String? extraData) async {
    return await _checkStoreEventDetail(uid, value, extraData);
    // switch (_entryMode) {
    //   case EntryMode.DE:
    //     return await _checkStoreEventDetail(uid, value, extraData);
    //   case EntryMode.ATTR:
    //     return await _checkStoreEnrollmentDetail(uid, value, extraData);
    //   case EntryMode.DV:
    //     throw ArgumentError(
    //         _resourceManager.getString('data_values_save_error'));
    // }
  }

  Future<StoreResult> _checkStoreEventDetail(
      String uid, String? value, String? extraData) async {
    // if (uid == EVENT_REPORT_DATE_UID) {
    //   if (value != null) {
    //     final date = DateTime.tryParse(value);
    //     if (date != null) _eventRepository?.setEventDate(date);
    //     return StoreResult(
    //         uid: uid, valueStoreResult: ValueStoreResult.valueChanged);
    //   } else {
    //     return StoreResult(
    //         uid: uid, valueStoreResult: ValueStoreResult.valueHasNotChanged);
    //   }
    // }

    // if (uid == EVENT_ORG_UNIT_UID) {
    //   if (value?.isNotEmpty == true) {
    //     _eventRepository?.setOrganisationUnitUid(value!);
    //     return StoreResult(
    //         uid: uid, valueStoreResult: ValueStoreResult.valueChanged);
    //   } else {
    //     return StoreResult(
    //         uid: uid, valueStoreResult: ValueStoreResult.valueHasNotChanged);
    //   }
    // }

    // if (uid == EVENT_COORDINATE_UID) {
    //   return await _storeEventCoordinateAttribute(value, extraData);
    // }
    //
    // if (uid.contains(EVENT_CATEGORY_COMBO_UID)) {
    //   return await _storeEventCategoryComboAttribute(uid, value);
    // }

    return await _saveDataElement(uid, value);
  }

  Future<EventStatus?> eventState() async {
    final event = await _db.eventModule.events.byUid(_recordUid).get();
    return event?.status;
  }

  String recordUid() => _recordUid;

  Future<void> completeEvent() async {
    try {
      await _db.eventModule.events
          .byUid(_recordUid)
          .setStatus(EventStatus.completed);
    } catch (e, stack) {
      _crashReportController.trackError(e, stack.toString());
    }
  }

  Future<void> activateEvent() async {
    try {
      await _db.eventModule.events
          .byUid(_recordUid)
          .setStatus(EventStatus.active);
    } catch (e, stack) {
      _crashReportController.trackError(e, stack.toString());
    }
  }

  Future<StoreResult> _saveDataElement(String uid, String? value) async {
    final repository =
        _db.trackedEntityModule.trackedEntityDataValues.value(_recordUid, uid);
    final dataElement =
        await _db.dataElementModule.dataElements.byUid(uid).get();
    final valueType = dataElement?.valueType;
    final newValue =
        UniqueAttributeController.withValueTypeCheck(value, valueType) ?? '';

    final currentValue = await repository.exists()
        ? (await repository.get())?.value.withValueTypeCheck(valueType) ?? ''
        : '';

    if (currentValue != newValue) {
      if (value?.isNotEmpty == true) {
        final changed = await repository.setCheck(_db, uid, newValue);
        return StoreResult(
            uid: uid,
            valueStoreResult: changed
                ? ValueStoreResult.valueChanged
                : ValueStoreResult.valueHasNotChanged);
      } else {
        await repository.deleteIfExists();
        return StoreResult(
            uid: uid, valueStoreResult: ValueStoreResult.valueChanged);
      }
    }

    return StoreResult(
        uid: uid, valueStoreResult: ValueStoreResult.valueHasNotChanged);
  }

  Future<StoreResult> saveWithTypeCheck(String uid, String? value) async {
    final existsDE =
        await _db.dataElementModule.dataElements.byUid(uid).exists();
    if (existsDE) return _saveDataElement(uid, value);

    final existsAttr = await _db.trackedEntityModule.trackedEntityAttributes
        .byUid(uid)
        .exists();
    if (existsAttr) return _saveAttribute(uid, value);

    return StoreResult(
        uid: uid, valueStoreResult: ValueStoreResult.uidIsNotDEOrAttr);
  }

  Future<StoreResult> deleteOptionValueIfSelected(
      String field, String optionUid) async {
    switch (_entryMode) {
      case EntryMode.DE:
        return _deleteDataElementValue(field, optionUid);
      case EntryMode.ATTR:
        return _deleteAttributeValue(field, optionUid);
      case EntryMode.DV:
        throw ArgumentError(
            _resourceManager.getString('data_values_save_error'));
    }
  }

  Future<StoreResult> _deleteDataElementValue(
      String field, String optionUid) async {
    final option = await _db.optionModule.options.byUid(optionUid).get();
    final possible = [option?.name, option?.code].whereType<String>();
    final repository = _db.trackedEntityModule.trackedEntityDataValues
        .value(_recordUid, field);

    if (await repository.exists()) {
      final current = (await repository.get())?.value;
      if (current != null && possible.contains(current)) {
        return await _saveDataElement(field, null);
      }
    }
    return StoreResult(
        uid: field, valueStoreResult: ValueStoreResult.valueHasNotChanged);
  }

  Future<StoreResult> deleteOptionValueIfSelectedInGroup(
      String field, String groupUid, bool isInGroup) async {
    final group =
        await _db.optionModule.optionGroups.withOptions().byUid(groupUid).get();
    final codes = group?.options
            .map((o) => _db.optionModule.options
                .byUid(o.uid)
                .get()
                .then((opt) => opt?.code))
            .toList() ??
        [];

    final optionCodes = (await Future.wait(codes)).whereType<String>();

    if (_entryMode == EntryMode.DE) {
      if (!isInGroup) {
        return _deleteDataElementValueIfNotInGroup(
            field, optionCodes.toList(), isInGroup);
      }
      return StoreResult(
          uid: field, valueStoreResult: ValueStoreResult.valueHasNotChanged);
    }

    if (_entryMode == EntryMode.ATTR) {
      if (!isInGroup) {
        return _deleteAttributeValueIfNotInGroup(
            field, optionCodes.toList(), isInGroup);
      }
      return StoreResult(
          uid: field, valueStoreResult: ValueStoreResult.valueHasNotChanged);
    }

    throw ArgumentError(
        'DataValues can\'t be saved using these arguments. Use the other one.');
  }

  // Helpers for deleteIfNotInGroup
  Future<StoreResult> _deleteDataElementValueIfNotInGroup(
      String field, List<String> codes, bool _) async {
    final repository = _db.trackedEntityModule.trackedEntityDataValues
        .value(_recordUid, field);
    if (await repository.exists()) {
      final current = (await repository.get())?.value;
      if (current != null && codes.contains(current)) {
        return await _saveDataElement(field, null);
      }
    }
    return StoreResult(
        uid: field, valueStoreResult: ValueStoreResult.valueHasNotChanged);
  }

// Future<StoreResult> _storeEventCoordinateAttribute(
//     String? value, String? extraData) async {
//   final stageUid = await _eventRepository?.programStage();
//   final featureType = await _db.programModule.programStages
//       .byUid(stageUid)
//       .get()
//       .then((ps) => ps?.featureType);
//
//   if (featureType == null) {
//     return StoreResult(
//         uid: EVENT_COORDINATE_UID,
//         valueStoreResult: ValueStoreResult.valueHasNotChanged);
//   }
//
//   switch (featureType) {
//     case FeatureType.point:
//     case FeatureType.polygon:
//     case FeatureType.multiPolygon:
//       if (value != null && extraData != null) {
//         final geometry = Geometry(
//           coordinates: value,
//           type: FeatureType.values
//               .firstWhere((e) => e.toString().split('.').last == extraData),
//         );
//         await _eventRepository?.setGeometry(geometry);
//         return StoreResult(
//             uid: EVENT_COORDINATE_UID,
//             valueStoreResult: ValueStoreResult.valueChanged);
//       }
//       return StoreResult(
//           uid: EVENT_COORDINATE_UID,
//           valueStoreResult: ValueStoreResult.valueHasNotChanged);
//     default:
//       return StoreResult(
//           uid: EVENT_COORDINATE_UID,
//           valueStoreResult: ValueStoreResult.valueHasNotChanged);
//   }
// }

// Future<StoreResult> storeFile(String uid, String? filePath) async {
//   final valueType = await () async {
//     switch (_entryMode) {
//       case EntryMode.DE:
//         return _db.dataElementModule.dataElements
//             .byUid(uid)
//             .get()
//             .then((e) => e?.valueType);
//       case EntryMode.ATTR:
//         return _db.trackedEntityModule.trackedEntityAttributes
//             .byUid(uid)
//             .get()
//             .then((a) => a?.valueType);
//       case EntryMode.DV:
//         throw ArgumentError(
//             _resourceManager.getString('data_values_save_error'));
//     }
//   }();
//
//   if (filePath != null) {
//     try {
//       final fileResourceUid =
//           await _saveFileResource(filePath, valueType == ValueType.Image);
//       return StoreResult(
//           uid: fileResourceUid, valueStoreResult: ValueStoreResult.fileSaved);
//     } catch (e) {
//       return StoreResult(
//         uid: uid,
//         valueStoreResult: ValueStoreResult.errorUpdatingValue,
//         message: e.toString(),
//       );
//     }
//   }
//
//   return StoreResult(
//       uid: uid, valueStoreResult: ValueStoreResult.errorUpdatingValue);
// }

// Future<StoreResult> _checkStoreEnrollmentDetail(
//     String uid, String? value, String? extraData) async {
//   if (uid == EnrollmentDetail.enrollmentDate.name) {
//     await _enrollmentRepository
//         ?.setEnrollmentDate(value != null ? DateTime.tryParse(value) : null);
//     return StoreResult(
//         uid: uid, valueStoreResult: ValueStoreResult.valueChanged);
//   }
//
//   if (uid == EnrollmentDetail.incidentDate.name) {
//     await _enrollmentRepository
//         ?.setIncidentDate(value != null ? DateTime.tryParse(value) : null);
//     return StoreResult(
//         uid: uid, valueStoreResult: ValueStoreResult.valueChanged);
//   }
//
//   if (uid == EnrollmentDetail.orgUnitUid.name) {
//     try {
//       await _enrollmentRepository?.setOrganisationUnitUid(value);
//       return StoreResult(
//           uid: uid, valueStoreResult: ValueStoreResult.valueChanged);
//     } catch (e) {
//       return StoreResult(
//           uid: uid, valueStoreResult: ValueStoreResult.errorUpdatingValue);
//     }
//   }
//
//   if (uid == EnrollmentDetail.teiCoordinates.name) {
//     final geometry = value != null && extraData != null
//         ? Geometry(
//             coordinates: value,
//             type: FeatureType.values
//                 .firstWhere((e) => e.toString().split('.').last == extraData),
//           )
//         : null;
//     _saveTeiGeometry(geometry);
//     return StoreResult(
//         uid: uid, valueStoreResult: ValueStoreResult.valueChanged);
//   }
//
//   if (uid == EnrollmentDetail.enrollmentCoordinates.name) {
//     final geometry = value != null && extraData != null
//         ? Geometry(
//             coordinates: value,
//             type: FeatureType.values
//                 .firstWhere((e) => e.toString().split('.').last == extraData),
//           )
//         : null;
//     try {
//       _saveEnrollmentGeometry(geometry);
//       return StoreResult(
//           uid: uid, valueStoreResult: ValueStoreResult.valueChanged);
//     } catch (e, stack) {
//       _crashReportController.trackError(e, stack.toString());
//       return StoreResult(
//           uid: uid, valueStoreResult: ValueStoreResult.errorUpdatingValue);
//     }
//   }
//
//   return await _saveAttribute(uid, value);
// }

// void _saveTeiGeometry(Geometry? geometry) {
//   final teiUid =
//       _enrollmentRepository?.get().then((e) => e?.trackedEntityInstance);
//   teiUid.then((uid) {
//     if (uid != null) {
//       _db.trackedEntityModule.trackedEntityInstances
//           .byUid(uid)
//           .setGeometry(geometry);
//     }
//   });
// }

// void _saveEnrollmentGeometry(Geometry? geometry) {
//   _enrollmentRepository?.setGeometry(geometry);
// }

// Future<StoreResult> _saveAttribute(String uid, String? value) async {
//   final teiUid = await () async {
//     if (_entryMode == EntryMode.DE) {
//       final event = await _db.eventModule.events.byUid(_recordUid).get();
//       return event?.enrollmentChain()?.trackedEntityInstance;
//     }
//     if (_entryMode == EntryMode.ATTR) return _recordUid;
//     return null;
//   }();
//
//   if (teiUid == null) {
//     return StoreResult(
//         uid: uid, valueStoreResult: ValueStoreResult.valueHasNotChanged);
//   }
//
//   if (!await _uniqueAttributeController.checkUniqueFilter(
//       uid, value, teiUid)) {
//     return StoreResult(
//         uid: uid, valueStoreResult: ValueStoreResult.valueNotUnique);
//   }
//
//   final repository =
//       _db.trackedEntityModule.trackedEntityAttributeValues.value(uid, teiUid);
//   final attribute =
//       await _db.trackedEntityModule.trackedEntityAttributes.byUid(uid).get();
//   final valueType = attribute?.valueType;
//   final newValue =
//       UniqueAttributeController.withValueTypeCheck(value, valueType) ?? '';
//
//   final currentValue = await repository.exists()
//       ? (await repository.get())?.value.withValueTypeCheck(valueType) ?? ''
//       : '';
//
//   if (currentValue != newValue) {
//     if (value?.isNotEmpty == true) {
//       await repository.setCheck(_db, uid, newValue, onError: (attrUid, val) {
//         _crashReportController.addBreadCrumb(
//             'setCheck Crash', 'Attribute: $attrUid, value: $val');
//       });
//     } else {
//       await repository.deleteIfExists();
//     }
//     return StoreResult(
//         uid: uid, valueStoreResult: ValueStoreResult.valueChanged);
//   }
//
//   return StoreResult(
//       uid: uid, valueStoreResult: ValueStoreResult.valueHasNotChanged);
// }

// Future<String> _saveFileResource(String path, bool resize) async {
//   final file = resize ? await _fileController.resize(path) : File(path);
//   return await _db.fileResourceModule.fileResources.add(file);
// }
// Future<StoreResult> _deleteAttributeValue(
//     String field, String optionUid) async {
//   final option = await _db.optionModule.options.byUid(optionUid).get();
//   final possible = [option?.name, option?.code].whereType<String>();
//   final repository = _db.trackedEntityModule.trackedEntityAttributeValues
//       .value(field, _recordUid);
//
//   if (await repository.exists()) {
//     final current = (await repository.get())?.value;
//     if (current != null && possible.contains(current)) {
//       return await _saveAttribute(field, null);
//     }
//   }
//   return StoreResult(
//       uid: field, valueStoreResult: ValueStoreResult.valueHasNotChanged);
// }
// Future<StoreResult> _deleteAttributeValueIfNotInGroup(
//     String field, List<String> codes, bool _) async {
//   final repository = _db.trackedEntityModule.trackedEntityAttributeValues
//       .value(field, _recordUid);
//   if (await repository.exists()) {
//     final current = (await repository.get())?.value;
//     if (current != null && codes.contains(current)) {
//       return await _saveAttribute(field, null);
//     }
//   }
//   return StoreResult(
//       uid: field, valueStoreResult: ValueStoreResult.valueHasNotChanged);
// }
}
