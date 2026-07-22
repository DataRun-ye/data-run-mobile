enum AttributeType {
  uuid,
  today,
  username,
  userUid,
  phoneNumber,
  userInfo,
  deviceId,
  deviceModel,
  form,
  team,
  activity,
  version;

  static AttributeType? getAttributeType(String? attributeType) {
    switch (attributeType?.toLowerCase()) {
      case 'uuid':
        return AttributeType.uuid;
      case 'today':
        return AttributeType.today;
      case 'username':
        return AttributeType.username;
      case 'useruid':
        return AttributeType.userUid;
      case 'userinfo':
        return AttributeType.userInfo;
      case 'phonenumber':
        return AttributeType.phoneNumber;
      case 'deviceid':
        return AttributeType.deviceId;
      case 'devicemodel':
        return AttributeType.deviceModel;
      case 'form':
        return AttributeType.form;
      case 'team':
        return AttributeType.team;
      case 'activity':
        return AttributeType.activity;
      case 'version':
        return AttributeType.version;
      default:
        return null;
    }
  }
}
