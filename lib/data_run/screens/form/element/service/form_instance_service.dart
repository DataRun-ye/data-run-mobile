import 'dart:async';

import 'package:d_sdk/core/form/attribute_type.dart';
import 'package:d_sdk/core/utilities/date_helper.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_metadata.dart';
import 'package:datarunmobile/data_run/screens/form/element/service/device_info_service.dart';
import 'package:uuid/uuid.dart';

class FormInstanceService {
  FormInstanceService(
      {AndroidDeviceInfoService? deviceInfoService, required this.formMetadata})
      : _uuid = const Uuid().v4(),
        _deviceInfoService = deviceInfoService;

  final FormMetadata formMetadata;

  final AndroidDeviceInfoService? _deviceInfoService;
  final String _uuid;

  Future<String?> getUserAttribute(AttributeType userAttributeType) async {
    User? currentUser = await DSdk.db.managers.users.getSingleOrNull();

    return switch (userAttributeType) {
      AttributeType.username => currentUser?.username,
      AttributeType.userUid => currentUser?.id,
      AttributeType.phoneNumber => currentUser?.mobile,
      AttributeType.userInfo => currentUser?.firstName,
      _ => null
    };
  }

  //
  // FormControl<String> orgUnitControl(
  //     List<String> formSelectableOrgUnit, initialValue) {
  //   return FormControl<String>(
  //       value: initialValue ??
  //           (formSelectableOrgUnit.length == 1
  //               ? formSelectableOrgUnit.first
  //               : null));
  // }

  FutureOr<dynamic> attributeControl(AttributeType attributeType,
          {initialValue}) async =>
      switch (attributeType) {
        AttributeType.uuid => initialValue ?? _uuid,
        AttributeType.today => initialValue ?? DateHelper.nowUtc(),
        AttributeType.username =>
          initialValue ?? await getUserAttribute(AttributeType.username),
        AttributeType.userUid =>
          initialValue ?? await getUserAttribute(AttributeType.userUid),
        AttributeType.phoneNumber =>
          initialValue ?? await getUserAttribute(AttributeType.phoneNumber),
        AttributeType.userInfo =>
          initialValue ?? await getUserAttribute(AttributeType.userInfo),
        AttributeType.deviceId =>
          initialValue ?? _deviceInfoService?.deviceId(),
        AttributeType.deviceModel =>
          initialValue ?? _deviceInfoService?.model(),
        AttributeType.form =>
          initialValue ?? formMetadata.formId.split('_').first,
        AttributeType.team => formMetadata.assignmentModel.team.id,
        AttributeType.activity =>
          initialValue ?? formMetadata.assignmentModel.activity?.id,
        AttributeType.version => initialValue ?? formMetadata.formId,
      };

  Future<Map<String, Object?>> formAttributesControls(initialValue) async {
    final Map<String, Object?> controls = {
      /// phoneNumber
      '_${AttributeType.phoneNumber.name}': await attributeControl(
          AttributeType.phoneNumber,
          initialValue: initialValue['_${AttributeType.phoneNumber.name}']),

      /// username
      '_${AttributeType.username.name}': await attributeControl(
          AttributeType.username,
          initialValue: initialValue['_${AttributeType.username.name}']),

      /// username
      '_${AttributeType.userUid.name}': await attributeControl(
          AttributeType.userUid,
          initialValue: initialValue['_${AttributeType.userUid.name}']),

      /// user first last name
      '_${AttributeType.userInfo.name}': await attributeControl(
          AttributeType.userInfo,
          initialValue: initialValue['_${AttributeType.userInfo.name}']),

      /// team name
      '_${AttributeType.team.name}': await attributeControl(AttributeType.team,
          initialValue: initialValue['_${AttributeType.team.name}']),

      /// form
      '_${AttributeType.form.name}':
          initialValue['_${AttributeType.form.name}'] ?? formMetadata.formId,

      /// activity
      '_${AttributeType.activity.name}': await attributeControl(
          AttributeType.activity,
          initialValue: initialValue['_${AttributeType.activity.name}']),

      /// device id
      '_${AttributeType.deviceId.name}': await attributeControl(
          AttributeType.deviceId,
          initialValue: initialValue['_${AttributeType.deviceId.name}']),

      /// form version
      '_${AttributeType.version.name}': await attributeControl(
          AttributeType.version,
          initialValue: initialValue['_${AttributeType.version.name}'])
    };

    return controls;
  }
//
// Future<Map<String, AbstractControl<dynamic>>> formDataControls(
//     initialValue) async {
//   final Map<String, AbstractControl<dynamic>> controls =
//       await formAttributesControls(initialValue);
//
//   for (var element in formFlatTemplate.formTemplate.fields) {
//     controls[element.name] = FromElementControlFactory.createTemplateControl(
//         element,
//         savedValue: initialValue?[element.name]);
//   }
//
//   return controls;
// }

// Future<Map<String, FormElementInstance<dynamic>>> formDataElements(
//     FormGroup form, FormValueMap formValueMap, initialValue) async {
//   final Map<String, FormElementInstance<dynamic>> elements = {};
//
//   for (var element in formFlatTemplate.formTemplate.fields) {
//     elements[element.name] = FromElementFactory.createElementInstance(
//         form, element,
//         savedValue: initialValue?[element.name]);
//   }
//
//   return elements;
// }
}
