import 'package:datarunmobile/generated/json/base/json_convert_content.dart';
import 'package:datarunmobile/core/user_session/current_user_entity.dart';

CurrentUserEntity $CurrentUserEntityFromJson(Map<String, dynamic> json) {
  final CurrentUserEntity currentUserEntity = CurrentUserEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    currentUserEntity.id = id;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    currentUserEntity.username = username;
  }
  final bool? activated = jsonConvert.convert<bool>(json['activated']);
  if (activated != null) {
    currentUserEntity.activated = activated;
  }
  final List<
      CurrentUserAuthorities>? authorities = (json['authorities'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<CurrentUserAuthorities>(e) as CurrentUserAuthorities)
      .toList();
  if (authorities != null) {
    currentUserEntity.authorities = authorities;
  }
  final String? firstName = jsonConvert.convert<String>(json['firstName']);
  if (firstName != null) {
    currentUserEntity.firstName = firstName;
  }
  final String? lastName = jsonConvert.convert<String>(json['lastName']);
  if (lastName != null) {
    currentUserEntity.lastName = lastName;
  }
  final String? langKey = jsonConvert.convert<String>(json['langKey']);
  if (langKey != null) {
    currentUserEntity.langKey = langKey;
  }
  final List<String>? activityUIDs = (json['activityUIDs'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (activityUIDs != null) {
    currentUserEntity.activityUIDs = activityUIDs;
  }
  final List<String>? userTeamsUIDs = (json['userTeamsUIDs'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (userTeamsUIDs != null) {
    currentUserEntity.userTeamsUIDs = userTeamsUIDs;
  }
  final List<dynamic>? managedTeamsUIDs = (json['managedTeamsUIDs'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (managedTeamsUIDs != null) {
    currentUserEntity.managedTeamsUIDs = managedTeamsUIDs;
  }
  final List<dynamic>? userGroupsUIDs = (json['userGroupsUIDs'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (userGroupsUIDs != null) {
    currentUserEntity.userGroupsUIDs = userGroupsUIDs;
  }
  final List<String>? userFormsUIDs = (json['userFormsUIDs'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (userFormsUIDs != null) {
    currentUserEntity.userFormsUIDs = userFormsUIDs;
  }
  final List<CurrentUserFormAccess>? formAccess = (json['formAccess'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<CurrentUserFormAccess>(e) as CurrentUserFormAccess)
      .toList();
  if (formAccess != null) {
    currentUserEntity.formAccess = formAccess;
  }
  return currentUserEntity;
}

Map<String, dynamic> $CurrentUserEntityToJson(CurrentUserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['username'] = entity.username;
  data['activated'] = entity.activated;
  data['authorities'] = entity.authorities.map((v) => v.toJson()).toList();
  data['firstName'] = entity.firstName;
  data['lastName'] = entity.lastName;
  data['langKey'] = entity.langKey;
  data['activityUIDs'] = entity.activityUIDs;
  data['userTeamsUIDs'] = entity.userTeamsUIDs;
  data['managedTeamsUIDs'] = entity.managedTeamsUIDs;
  data['userGroupsUIDs'] = entity.userGroupsUIDs;
  data['userFormsUIDs'] = entity.userFormsUIDs;
  data['formAccess'] = entity.formAccess.map((v) => v.toJson()).toList();
  return data;
}

extension CurrentUserEntityExtension on CurrentUserEntity {
  CurrentUserEntity copyWith({
    String? id,
    String? username,
    bool? activated,
    List<CurrentUserAuthorities>? authorities,
    String? firstName,
    String? lastName,
    String? langKey,
    List<String>? activityUIDs,
    List<String>? userTeamsUIDs,
    List<dynamic>? managedTeamsUIDs,
    List<dynamic>? userGroupsUIDs,
    List<String>? userFormsUIDs,
    List<CurrentUserFormAccess>? formAccess,
  }) {
    return CurrentUserEntity()
      ..id = id ?? this.id
      ..username = username ?? this.username
      ..activated = activated ?? this.activated
      ..authorities = authorities ?? this.authorities
      ..firstName = firstName ?? this.firstName
      ..lastName = lastName ?? this.lastName
      ..langKey = langKey ?? this.langKey
      ..activityUIDs = activityUIDs ?? this.activityUIDs
      ..userTeamsUIDs = userTeamsUIDs ?? this.userTeamsUIDs
      ..managedTeamsUIDs = managedTeamsUIDs ?? this.managedTeamsUIDs
      ..userGroupsUIDs = userGroupsUIDs ?? this.userGroupsUIDs
      ..userFormsUIDs = userFormsUIDs ?? this.userFormsUIDs
      ..formAccess = formAccess ?? this.formAccess;
  }
}

CurrentUserAuthorities $CurrentUserAuthoritiesFromJson(
    Map<String, dynamic> json) {
  final CurrentUserAuthorities currentUserAuthorities = CurrentUserAuthorities();
  final String? authority = jsonConvert.convert<String>(json['authority']);
  if (authority != null) {
    currentUserAuthorities.authority = authority;
  }
  return currentUserAuthorities;
}

Map<String, dynamic> $CurrentUserAuthoritiesToJson(
    CurrentUserAuthorities entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['authority'] = entity.authority;
  return data;
}

extension CurrentUserAuthoritiesExtension on CurrentUserAuthorities {
  CurrentUserAuthorities copyWith({
    String? authority,
  }) {
    return CurrentUserAuthorities()
      ..authority = authority ?? this.authority;
  }
}

CurrentUserFormAccess $CurrentUserFormAccessFromJson(
    Map<String, dynamic> json) {
  final CurrentUserFormAccess currentUserFormAccess = CurrentUserFormAccess();
  final String? user = jsonConvert.convert<String>(json['user']);
  if (user != null) {
    currentUserFormAccess.user = user;
  }
  final String? team = jsonConvert.convert<String>(json['team']);
  if (team != null) {
    currentUserFormAccess.team = team;
  }
  final String? form = jsonConvert.convert<String>(json['form']);
  if (form != null) {
    currentUserFormAccess.form = form;
  }
  final List<String>? permissions = (json['permissions'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (permissions != null) {
    currentUserFormAccess.permissions = permissions;
  }
  return currentUserFormAccess;
}

Map<String, dynamic> $CurrentUserFormAccessToJson(
    CurrentUserFormAccess entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['user'] = entity.user;
  data['team'] = entity.team;
  data['form'] = entity.form;
  data['permissions'] = entity.permissions;
  return data;
}

extension CurrentUserFormAccessExtension on CurrentUserFormAccess {
  CurrentUserFormAccess copyWith({
    String? user,
    String? team,
    String? form,
    List<String>? permissions,
  }) {
    return CurrentUserFormAccess()
      ..user = user ?? this.user
      ..team = team ?? this.team
      ..form = form ?? this.form
      ..permissions = permissions ?? this.permissions;
  }
}