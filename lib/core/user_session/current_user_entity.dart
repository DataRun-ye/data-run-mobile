import 'dart:convert';

import 'package:datarunmobile/generated/json/base/json_field.dart';
import 'package:datarunmobile/generated/json/current_user_entity.g.dart';

export 'package:datarunmobile/generated/json/current_user_entity.g.dart';

@JsonSerializable()
class CurrentUserEntity {
  CurrentUserEntity();

  factory CurrentUserEntity.fromJson(Map<String, dynamic> json) =>
      $CurrentUserEntityFromJson(json);
  late String id;
  late String username;
  late bool activated;
  late List<CurrentUserAuthorities> authorities;
  late String firstName;
  late String lastName;
  late String langKey;
  late List<String> activityUIDs;
  late List<String> userTeamsUIDs;
  late List<dynamic> managedTeamsUIDs;
  late List<dynamic> userGroupsUIDs;
  late List<String> userFormsUIDs;
  late List<CurrentUserFormAccess> formAccess;

  Map<String, dynamic> toJson() => $CurrentUserEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CurrentUserAuthorities {
  CurrentUserAuthorities();

  factory CurrentUserAuthorities.fromJson(Map<String, dynamic> json) =>
      $CurrentUserAuthoritiesFromJson(json);
  late String authority;

  Map<String, dynamic> toJson() => $CurrentUserAuthoritiesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CurrentUserFormAccess {
  CurrentUserFormAccess();

  factory CurrentUserFormAccess.fromJson(Map<String, dynamic> json) =>
      $CurrentUserFormAccessFromJson(json);
  late String user;
  late String team;
  late String form;
  late List<String> permissions;

  Map<String, dynamic> toJson() => $CurrentUserFormAccessToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
