import 'dart:async';

import 'package:d_sdk/core/form/attribute_type.dart';
import 'package:d_sdk/core/util/date_helper.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/features/form_submission/application/device_info_service.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
class FormMetadataService {
  FormMetadataService(
      {AndroidDeviceInfoService? deviceInfoService,
      @factoryParam required this.formMetadata})
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
        // AttributeType.team => formMetadata.assignmentModel.team.id,
        // AttributeType.activity =>
        //   initialValue ?? formMetadata.assignmentModel.activity?.id,
        AttributeType.version => initialValue ?? formMetadata.versionUid,
        _ => initialValue,
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
}
