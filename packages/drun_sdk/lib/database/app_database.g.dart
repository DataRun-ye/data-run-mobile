// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  @override
  late final GeneratedColumn<String> mobile = GeneratedColumn<String>(
      'mobile', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _langKeyMeta =
      const VerificationMeta('langKey');
  @override
  late final GeneratedColumn<String> langKey = GeneratedColumn<String>(
      'lang_key', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => 'ar');
  static const VerificationMeta _activatedMeta =
      const VerificationMeta('activated');
  @override
  late final GeneratedColumn<bool> activated = GeneratedColumn<bool>(
      'activated', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("activated" IN (0, 1))'),
      clientDefault: () => false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      authorities = GeneratedColumn<String>('authorities', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($UsersTable.$converterauthorities);
  static const VerificationMeta _submissionCountMeta =
      const VerificationMeta('submissionCount');
  @override
  late final GeneratedColumn<int> submissionCount = GeneratedColumn<int>(
      'submission_count', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      clientDefault: () => 0);
  static const VerificationMeta _assignmentCountMeta =
      const VerificationMeta('assignmentCount');
  @override
  late final GeneratedColumn<int> assignmentCount = GeneratedColumn<int>(
      'assignment_count', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      clientDefault: () => 0);
  static const VerificationMeta _orgUnitCountMeta =
      const VerificationMeta('orgUnitCount');
  @override
  late final GeneratedColumn<int> orgUnitCount = GeneratedColumn<int>(
      'org_unit_count', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      clientDefault: () => 0);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      activityUIDs = GeneratedColumn<String>(
              'activity_u_i_ds', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($UsersTable.$converteractivityUIDs);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      userTeamsUIDs = GeneratedColumn<String>(
              'user_teams_u_i_ds', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($UsersTable.$converteruserTeamsUIDs);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      managedTeamsUIDs = GeneratedColumn<String>(
              'managed_teams_u_i_ds', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($UsersTable.$convertermanagedTeamsUIDs);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      userGroupsUIDs = GeneratedColumn<String>(
              'user_groups_u_i_ds', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($UsersTable.$converteruserGroupsUIDs);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      userFormsUIDs = GeneratedColumn<String>(
              'user_forms_u_i_ds', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($UsersTable.$converteruserFormsUIDs);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lastModifiedDate,
        createdDate,
        username,
        firstName,
        lastName,
        mobile,
        email,
        langKey,
        activated,
        imageUrl,
        authorities,
        submissionCount,
        assignmentCount,
        orgUnitCount,
        activityUIDs,
        userTeamsUIDs,
        managedTeamsUIDs,
        userGroupsUIDs,
        userFormsUIDs
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    }
    if (data.containsKey('mobile')) {
      context.handle(_mobileMeta,
          mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('lang_key')) {
      context.handle(_langKeyMeta,
          langKey.isAcceptableOrUnknown(data['lang_key']!, _langKeyMeta));
    }
    if (data.containsKey('activated')) {
      context.handle(_activatedMeta,
          activated.isAcceptableOrUnknown(data['activated']!, _activatedMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('submission_count')) {
      context.handle(
          _submissionCountMeta,
          submissionCount.isAcceptableOrUnknown(
              data['submission_count']!, _submissionCountMeta));
    }
    if (data.containsKey('assignment_count')) {
      context.handle(
          _assignmentCountMeta,
          assignmentCount.isAcceptableOrUnknown(
              data['assignment_count']!, _assignmentCountMeta));
    }
    if (data.containsKey('org_unit_count')) {
      context.handle(
          _orgUnitCountMeta,
          orgUnitCount.isAcceptableOrUnknown(
              data['org_unit_count']!, _orgUnitCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name']),
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name']),
      mobile: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mobile']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      langKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lang_key']),
      activated: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}activated'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      authorities: $UsersTable.$converterauthorities.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}authorities'])!),
      submissionCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}submission_count']),
      assignmentCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}assignment_count']),
      orgUnitCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}org_unit_count']),
      activityUIDs: $UsersTable.$converteractivityUIDs.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}activity_u_i_ds'])!),
      userTeamsUIDs: $UsersTable.$converteruserTeamsUIDs.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}user_teams_u_i_ds'])!),
      managedTeamsUIDs: $UsersTable.$convertermanagedTeamsUIDs.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}managed_teams_u_i_ds'])!),
      userGroupsUIDs: $UsersTable.$converteruserGroupsUIDs.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}user_groups_u_i_ds'])!),
      userFormsUIDs: $UsersTable.$converteruserFormsUIDs.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}user_forms_u_i_ds'])!),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterauthorities =
      const ListConverter<String>();
  static TypeConverter<List<String>, String> $converteractivityUIDs =
      const ListConverter<String>();
  static TypeConverter<List<String>, String> $converteruserTeamsUIDs =
      const ListConverter<String>();
  static TypeConverter<List<String>, String> $convertermanagedTeamsUIDs =
      const ListConverter<String>();
  static TypeConverter<List<String>, String> $converteruserGroupsUIDs =
      const ListConverter<String>();
  static TypeConverter<List<String>, String> $converteruserFormsUIDs =
      const ListConverter<String>();
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final String username;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? email;
  final String? langKey;
  final bool activated;
  final String? imageUrl;
  final List<String> authorities;
  final int? submissionCount;
  final int? assignmentCount;
  final int? orgUnitCount;
  final List<String> activityUIDs;
  final List<String> userTeamsUIDs;
  final List<String> managedTeamsUIDs;
  final List<String> userGroupsUIDs;
  final List<String> userFormsUIDs;
  const User(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      required this.username,
      this.firstName,
      this.lastName,
      this.mobile,
      this.email,
      this.langKey,
      required this.activated,
      this.imageUrl,
      required this.authorities,
      this.submissionCount,
      this.assignmentCount,
      this.orgUnitCount,
      required this.activityUIDs,
      required this.userTeamsUIDs,
      required this.managedTeamsUIDs,
      required this.userGroupsUIDs,
      required this.userFormsUIDs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    map['username'] = Variable<String>(username);
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    if (!nullToAbsent || mobile != null) {
      map['mobile'] = Variable<String>(mobile);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || langKey != null) {
      map['lang_key'] = Variable<String>(langKey);
    }
    map['activated'] = Variable<bool>(activated);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    {
      map['authorities'] = Variable<String>(
          $UsersTable.$converterauthorities.toSql(authorities));
    }
    if (!nullToAbsent || submissionCount != null) {
      map['submission_count'] = Variable<int>(submissionCount);
    }
    if (!nullToAbsent || assignmentCount != null) {
      map['assignment_count'] = Variable<int>(assignmentCount);
    }
    if (!nullToAbsent || orgUnitCount != null) {
      map['org_unit_count'] = Variable<int>(orgUnitCount);
    }
    {
      map['activity_u_i_ds'] = Variable<String>(
          $UsersTable.$converteractivityUIDs.toSql(activityUIDs));
    }
    {
      map['user_teams_u_i_ds'] = Variable<String>(
          $UsersTable.$converteruserTeamsUIDs.toSql(userTeamsUIDs));
    }
    {
      map['managed_teams_u_i_ds'] = Variable<String>(
          $UsersTable.$convertermanagedTeamsUIDs.toSql(managedTeamsUIDs));
    }
    {
      map['user_groups_u_i_ds'] = Variable<String>(
          $UsersTable.$converteruserGroupsUIDs.toSql(userGroupsUIDs));
    }
    {
      map['user_forms_u_i_ds'] = Variable<String>(
          $UsersTable.$converteruserFormsUIDs.toSql(userFormsUIDs));
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      username: Value(username),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      mobile:
          mobile == null && nullToAbsent ? const Value.absent() : Value(mobile),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      langKey: langKey == null && nullToAbsent
          ? const Value.absent()
          : Value(langKey),
      activated: Value(activated),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      authorities: Value(authorities),
      submissionCount: submissionCount == null && nullToAbsent
          ? const Value.absent()
          : Value(submissionCount),
      assignmentCount: assignmentCount == null && nullToAbsent
          ? const Value.absent()
          : Value(assignmentCount),
      orgUnitCount: orgUnitCount == null && nullToAbsent
          ? const Value.absent()
          : Value(orgUnitCount),
      activityUIDs: Value(activityUIDs),
      userTeamsUIDs: Value(userTeamsUIDs),
      managedTeamsUIDs: Value(managedTeamsUIDs),
      userGroupsUIDs: Value(userGroupsUIDs),
      userFormsUIDs: Value(userFormsUIDs),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      username: serializer.fromJson<String>(json['username']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      mobile: serializer.fromJson<String?>(json['mobile']),
      email: serializer.fromJson<String?>(json['email']),
      langKey: serializer.fromJson<String?>(json['langKey']),
      activated: serializer.fromJson<bool>(json['activated']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      authorities: serializer.fromJson<List<String>>(json['authorities']),
      submissionCount: serializer.fromJson<int?>(json['submissionCount']),
      assignmentCount: serializer.fromJson<int?>(json['assignmentCount']),
      orgUnitCount: serializer.fromJson<int?>(json['orgUnitCount']),
      activityUIDs: serializer.fromJson<List<String>>(json['activityUIDs']),
      userTeamsUIDs: serializer.fromJson<List<String>>(json['userTeamsUIDs']),
      managedTeamsUIDs:
          serializer.fromJson<List<String>>(json['managedTeamsUIDs']),
      userGroupsUIDs: serializer.fromJson<List<String>>(json['userGroupsUIDs']),
      userFormsUIDs: serializer.fromJson<List<String>>(json['userFormsUIDs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'username': serializer.toJson<String>(username),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'mobile': serializer.toJson<String?>(mobile),
      'email': serializer.toJson<String?>(email),
      'langKey': serializer.toJson<String?>(langKey),
      'activated': serializer.toJson<bool>(activated),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'authorities': serializer.toJson<List<String>>(authorities),
      'submissionCount': serializer.toJson<int?>(submissionCount),
      'assignmentCount': serializer.toJson<int?>(assignmentCount),
      'orgUnitCount': serializer.toJson<int?>(orgUnitCount),
      'activityUIDs': serializer.toJson<List<String>>(activityUIDs),
      'userTeamsUIDs': serializer.toJson<List<String>>(userTeamsUIDs),
      'managedTeamsUIDs': serializer.toJson<List<String>>(managedTeamsUIDs),
      'userGroupsUIDs': serializer.toJson<List<String>>(userGroupsUIDs),
      'userFormsUIDs': serializer.toJson<List<String>>(userFormsUIDs),
    };
  }

  User copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          String? username,
          Value<String?> firstName = const Value.absent(),
          Value<String?> lastName = const Value.absent(),
          Value<String?> mobile = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> langKey = const Value.absent(),
          bool? activated,
          Value<String?> imageUrl = const Value.absent(),
          List<String>? authorities,
          Value<int?> submissionCount = const Value.absent(),
          Value<int?> assignmentCount = const Value.absent(),
          Value<int?> orgUnitCount = const Value.absent(),
          List<String>? activityUIDs,
          List<String>? userTeamsUIDs,
          List<String>? managedTeamsUIDs,
          List<String>? userGroupsUIDs,
          List<String>? userFormsUIDs}) =>
      User(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        username: username ?? this.username,
        firstName: firstName.present ? firstName.value : this.firstName,
        lastName: lastName.present ? lastName.value : this.lastName,
        mobile: mobile.present ? mobile.value : this.mobile,
        email: email.present ? email.value : this.email,
        langKey: langKey.present ? langKey.value : this.langKey,
        activated: activated ?? this.activated,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        authorities: authorities ?? this.authorities,
        submissionCount: submissionCount.present
            ? submissionCount.value
            : this.submissionCount,
        assignmentCount: assignmentCount.present
            ? assignmentCount.value
            : this.assignmentCount,
        orgUnitCount:
            orgUnitCount.present ? orgUnitCount.value : this.orgUnitCount,
        activityUIDs: activityUIDs ?? this.activityUIDs,
        userTeamsUIDs: userTeamsUIDs ?? this.userTeamsUIDs,
        managedTeamsUIDs: managedTeamsUIDs ?? this.managedTeamsUIDs,
        userGroupsUIDs: userGroupsUIDs ?? this.userGroupsUIDs,
        userFormsUIDs: userFormsUIDs ?? this.userFormsUIDs,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      username: data.username.present ? data.username.value : this.username,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      mobile: data.mobile.present ? data.mobile.value : this.mobile,
      email: data.email.present ? data.email.value : this.email,
      langKey: data.langKey.present ? data.langKey.value : this.langKey,
      activated: data.activated.present ? data.activated.value : this.activated,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      authorities:
          data.authorities.present ? data.authorities.value : this.authorities,
      submissionCount: data.submissionCount.present
          ? data.submissionCount.value
          : this.submissionCount,
      assignmentCount: data.assignmentCount.present
          ? data.assignmentCount.value
          : this.assignmentCount,
      orgUnitCount: data.orgUnitCount.present
          ? data.orgUnitCount.value
          : this.orgUnitCount,
      activityUIDs: data.activityUIDs.present
          ? data.activityUIDs.value
          : this.activityUIDs,
      userTeamsUIDs: data.userTeamsUIDs.present
          ? data.userTeamsUIDs.value
          : this.userTeamsUIDs,
      managedTeamsUIDs: data.managedTeamsUIDs.present
          ? data.managedTeamsUIDs.value
          : this.managedTeamsUIDs,
      userGroupsUIDs: data.userGroupsUIDs.present
          ? data.userGroupsUIDs.value
          : this.userGroupsUIDs,
      userFormsUIDs: data.userFormsUIDs.present
          ? data.userFormsUIDs.value
          : this.userFormsUIDs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('username: $username, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('mobile: $mobile, ')
          ..write('email: $email, ')
          ..write('langKey: $langKey, ')
          ..write('activated: $activated, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('authorities: $authorities, ')
          ..write('submissionCount: $submissionCount, ')
          ..write('assignmentCount: $assignmentCount, ')
          ..write('orgUnitCount: $orgUnitCount, ')
          ..write('activityUIDs: $activityUIDs, ')
          ..write('userTeamsUIDs: $userTeamsUIDs, ')
          ..write('managedTeamsUIDs: $managedTeamsUIDs, ')
          ..write('userGroupsUIDs: $userGroupsUIDs, ')
          ..write('userFormsUIDs: $userFormsUIDs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      lastModifiedDate,
      createdDate,
      username,
      firstName,
      lastName,
      mobile,
      email,
      langKey,
      activated,
      imageUrl,
      authorities,
      submissionCount,
      assignmentCount,
      orgUnitCount,
      activityUIDs,
      userTeamsUIDs,
      managedTeamsUIDs,
      userGroupsUIDs,
      userFormsUIDs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.username == this.username &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.mobile == this.mobile &&
          other.email == this.email &&
          other.langKey == this.langKey &&
          other.activated == this.activated &&
          other.imageUrl == this.imageUrl &&
          other.authorities == this.authorities &&
          other.submissionCount == this.submissionCount &&
          other.assignmentCount == this.assignmentCount &&
          other.orgUnitCount == this.orgUnitCount &&
          other.activityUIDs == this.activityUIDs &&
          other.userTeamsUIDs == this.userTeamsUIDs &&
          other.managedTeamsUIDs == this.managedTeamsUIDs &&
          other.userGroupsUIDs == this.userGroupsUIDs &&
          other.userFormsUIDs == this.userFormsUIDs);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<String> username;
  final Value<String?> firstName;
  final Value<String?> lastName;
  final Value<String?> mobile;
  final Value<String?> email;
  final Value<String?> langKey;
  final Value<bool> activated;
  final Value<String?> imageUrl;
  final Value<List<String>> authorities;
  final Value<int?> submissionCount;
  final Value<int?> assignmentCount;
  final Value<int?> orgUnitCount;
  final Value<List<String>> activityUIDs;
  final Value<List<String>> userTeamsUIDs;
  final Value<List<String>> managedTeamsUIDs;
  final Value<List<String>> userGroupsUIDs;
  final Value<List<String>> userFormsUIDs;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.username = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.mobile = const Value.absent(),
    this.email = const Value.absent(),
    this.langKey = const Value.absent(),
    this.activated = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.authorities = const Value.absent(),
    this.submissionCount = const Value.absent(),
    this.assignmentCount = const Value.absent(),
    this.orgUnitCount = const Value.absent(),
    this.activityUIDs = const Value.absent(),
    this.userTeamsUIDs = const Value.absent(),
    this.managedTeamsUIDs = const Value.absent(),
    this.userGroupsUIDs = const Value.absent(),
    this.userFormsUIDs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    required String username,
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.mobile = const Value.absent(),
    this.email = const Value.absent(),
    this.langKey = const Value.absent(),
    this.activated = const Value.absent(),
    this.imageUrl = const Value.absent(),
    required List<String> authorities,
    this.submissionCount = const Value.absent(),
    this.assignmentCount = const Value.absent(),
    this.orgUnitCount = const Value.absent(),
    required List<String> activityUIDs,
    required List<String> userTeamsUIDs,
    required List<String> managedTeamsUIDs,
    required List<String> userGroupsUIDs,
    required List<String> userFormsUIDs,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        username = Value(username),
        authorities = Value(authorities),
        activityUIDs = Value(activityUIDs),
        userTeamsUIDs = Value(userTeamsUIDs),
        managedTeamsUIDs = Value(managedTeamsUIDs),
        userGroupsUIDs = Value(userGroupsUIDs),
        userFormsUIDs = Value(userFormsUIDs);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? username,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? mobile,
    Expression<String>? email,
    Expression<String>? langKey,
    Expression<bool>? activated,
    Expression<String>? imageUrl,
    Expression<String>? authorities,
    Expression<int>? submissionCount,
    Expression<int>? assignmentCount,
    Expression<int>? orgUnitCount,
    Expression<String>? activityUIDs,
    Expression<String>? userTeamsUIDs,
    Expression<String>? managedTeamsUIDs,
    Expression<String>? userGroupsUIDs,
    Expression<String>? userFormsUIDs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (username != null) 'username': username,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (mobile != null) 'mobile': mobile,
      if (email != null) 'email': email,
      if (langKey != null) 'lang_key': langKey,
      if (activated != null) 'activated': activated,
      if (imageUrl != null) 'image_url': imageUrl,
      if (authorities != null) 'authorities': authorities,
      if (submissionCount != null) 'submission_count': submissionCount,
      if (assignmentCount != null) 'assignment_count': assignmentCount,
      if (orgUnitCount != null) 'org_unit_count': orgUnitCount,
      if (activityUIDs != null) 'activity_u_i_ds': activityUIDs,
      if (userTeamsUIDs != null) 'user_teams_u_i_ds': userTeamsUIDs,
      if (managedTeamsUIDs != null) 'managed_teams_u_i_ds': managedTeamsUIDs,
      if (userGroupsUIDs != null) 'user_groups_u_i_ds': userGroupsUIDs,
      if (userFormsUIDs != null) 'user_forms_u_i_ds': userFormsUIDs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<String>? username,
      Value<String?>? firstName,
      Value<String?>? lastName,
      Value<String?>? mobile,
      Value<String?>? email,
      Value<String?>? langKey,
      Value<bool>? activated,
      Value<String?>? imageUrl,
      Value<List<String>>? authorities,
      Value<int?>? submissionCount,
      Value<int?>? assignmentCount,
      Value<int?>? orgUnitCount,
      Value<List<String>>? activityUIDs,
      Value<List<String>>? userTeamsUIDs,
      Value<List<String>>? managedTeamsUIDs,
      Value<List<String>>? userGroupsUIDs,
      Value<List<String>>? userFormsUIDs,
      Value<int>? rowid}) {
    return UsersCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      langKey: langKey ?? this.langKey,
      activated: activated ?? this.activated,
      imageUrl: imageUrl ?? this.imageUrl,
      authorities: authorities ?? this.authorities,
      submissionCount: submissionCount ?? this.submissionCount,
      assignmentCount: assignmentCount ?? this.assignmentCount,
      orgUnitCount: orgUnitCount ?? this.orgUnitCount,
      activityUIDs: activityUIDs ?? this.activityUIDs,
      userTeamsUIDs: userTeamsUIDs ?? this.userTeamsUIDs,
      managedTeamsUIDs: managedTeamsUIDs ?? this.managedTeamsUIDs,
      userGroupsUIDs: userGroupsUIDs ?? this.userGroupsUIDs,
      userFormsUIDs: userFormsUIDs ?? this.userFormsUIDs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (langKey.present) {
      map['lang_key'] = Variable<String>(langKey.value);
    }
    if (activated.present) {
      map['activated'] = Variable<bool>(activated.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (authorities.present) {
      map['authorities'] = Variable<String>(
          $UsersTable.$converterauthorities.toSql(authorities.value));
    }
    if (submissionCount.present) {
      map['submission_count'] = Variable<int>(submissionCount.value);
    }
    if (assignmentCount.present) {
      map['assignment_count'] = Variable<int>(assignmentCount.value);
    }
    if (orgUnitCount.present) {
      map['org_unit_count'] = Variable<int>(orgUnitCount.value);
    }
    if (activityUIDs.present) {
      map['activity_u_i_ds'] = Variable<String>(
          $UsersTable.$converteractivityUIDs.toSql(activityUIDs.value));
    }
    if (userTeamsUIDs.present) {
      map['user_teams_u_i_ds'] = Variable<String>(
          $UsersTable.$converteruserTeamsUIDs.toSql(userTeamsUIDs.value));
    }
    if (managedTeamsUIDs.present) {
      map['managed_teams_u_i_ds'] = Variable<String>(
          $UsersTable.$convertermanagedTeamsUIDs.toSql(managedTeamsUIDs.value));
    }
    if (userGroupsUIDs.present) {
      map['user_groups_u_i_ds'] = Variable<String>(
          $UsersTable.$converteruserGroupsUIDs.toSql(userGroupsUIDs.value));
    }
    if (userFormsUIDs.present) {
      map['user_forms_u_i_ds'] = Variable<String>(
          $UsersTable.$converteruserFormsUIDs.toSql(userFormsUIDs.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('username: $username, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('mobile: $mobile, ')
          ..write('email: $email, ')
          ..write('langKey: $langKey, ')
          ..write('activated: $activated, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('authorities: $authorities, ')
          ..write('submissionCount: $submissionCount, ')
          ..write('assignmentCount: $assignmentCount, ')
          ..write('orgUnitCount: $orgUnitCount, ')
          ..write('activityUIDs: $activityUIDs, ')
          ..write('userTeamsUIDs: $userTeamsUIDs, ')
          ..write('managedTeamsUIDs: $managedTeamsUIDs, ')
          ..write('userGroupsUIDs: $userGroupsUIDs, ')
          ..write('userFormsUIDs: $userFormsUIDs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrgUnitsTable extends OrgUnits with TableInfo<$OrgUnitsTable, OrgUnit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrgUnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      label = GeneratedColumn<String>('label', aliasedName, true,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '{}')
          .withConverter<Map<String, dynamic>?>($OrgUnitsTable.$converterlabel);
  @override
  late final GeneratedColumnWithTypeConverter<List<Translation>, String>
      translations = GeneratedColumn<String>('translations', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '[]')
          .withConverter<List<Translation>>(
              $OrgUnitsTable.$convertertranslations);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _parentMeta = const VerificationMeta('parent');
  @override
  late final GeneratedColumn<String> parent = GeneratedColumn<String>(
      'parent', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES org_units (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lastModifiedDate,
        createdDate,
        displayName,
        label,
        translations,
        name,
        code,
        path,
        level,
        parent
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'org_units';
  @override
  VerificationContext validateIntegrity(Insertable<OrgUnit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('parent')) {
      context.handle(_parentMeta,
          parent.isAcceptableOrUnknown(data['parent']!, _parentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrgUnit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrgUnit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name']),
      label: $OrgUnitsTable.$converterlabel.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])),
      translations: $OrgUnitsTable.$convertertranslations.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}translations'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      parent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent']),
    );
  }

  @override
  $OrgUnitsTable createAlias(String alias) {
    return $OrgUnitsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?> $converterlabel =
      const NullAwareMapConverter();
  static TypeConverter<List<Translation>, String> $convertertranslations =
      const TranslationConverter();
}

class OrgUnit extends DataClass implements Insertable<OrgUnit> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final String? displayName;
  final Map<String, dynamic>? label;
  final List<Translation> translations;
  final String name;
  final String? code;

  /// a comma separated ids for ancestor starting from root to this orgUnit
  final String path;
  final int level;
  final String? parent;
  const OrgUnit(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      this.displayName,
      this.label,
      required this.translations,
      required this.name,
      this.code,
      required this.path,
      required this.level,
      this.parent});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || label != null) {
      map['label'] =
          Variable<String>($OrgUnitsTable.$converterlabel.toSql(label));
    }
    {
      map['translations'] = Variable<String>(
          $OrgUnitsTable.$convertertranslations.toSql(translations));
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['path'] = Variable<String>(path);
    map['level'] = Variable<int>(level);
    if (!nullToAbsent || parent != null) {
      map['parent'] = Variable<String>(parent);
    }
    return map;
  }

  OrgUnitsCompanion toCompanion(bool nullToAbsent) {
    return OrgUnitsCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
      translations: Value(translations),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      path: Value(path),
      level: Value(level),
      parent:
          parent == null && nullToAbsent ? const Value.absent() : Value(parent),
    );
  }

  factory OrgUnit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrgUnit(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      label: serializer.fromJson<Map<String, dynamic>?>(json['label']),
      translations:
          serializer.fromJson<List<Translation>>(json['translations']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      path: serializer.fromJson<String>(json['path']),
      level: serializer.fromJson<int>(json['level']),
      parent: serializer.fromJson<String?>(json['parent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'displayName': serializer.toJson<String?>(displayName),
      'label': serializer.toJson<Map<String, dynamic>?>(label),
      'translations': serializer.toJson<List<Translation>>(translations),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'path': serializer.toJson<String>(path),
      'level': serializer.toJson<int>(level),
      'parent': serializer.toJson<String?>(parent),
    };
  }

  OrgUnit copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          Value<String?> displayName = const Value.absent(),
          Value<Map<String, dynamic>?> label = const Value.absent(),
          List<Translation>? translations,
          String? name,
          Value<String?> code = const Value.absent(),
          String? path,
          int? level,
          Value<String?> parent = const Value.absent()}) =>
      OrgUnit(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        displayName: displayName.present ? displayName.value : this.displayName,
        label: label.present ? label.value : this.label,
        translations: translations ?? this.translations,
        name: name ?? this.name,
        code: code.present ? code.value : this.code,
        path: path ?? this.path,
        level: level ?? this.level,
        parent: parent.present ? parent.value : this.parent,
      );
  OrgUnit copyWithCompanion(OrgUnitsCompanion data) {
    return OrgUnit(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      label: data.label.present ? data.label.value : this.label,
      translations: data.translations.present
          ? data.translations.value
          : this.translations,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      path: data.path.present ? data.path.value : this.path,
      level: data.level.present ? data.level.value : this.level,
      parent: data.parent.present ? data.parent.value : this.parent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrgUnit(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('path: $path, ')
          ..write('level: $level, ')
          ..write('parent: $parent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastModifiedDate, createdDate,
      displayName, label, translations, name, code, path, level, parent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrgUnit &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.displayName == this.displayName &&
          other.label == this.label &&
          other.translations == this.translations &&
          other.name == this.name &&
          other.code == this.code &&
          other.path == this.path &&
          other.level == this.level &&
          other.parent == this.parent);
}

class OrgUnitsCompanion extends UpdateCompanion<OrgUnit> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<String?> displayName;
  final Value<Map<String, dynamic>?> label;
  final Value<List<Translation>> translations;
  final Value<String> name;
  final Value<String?> code;
  final Value<String> path;
  final Value<int> level;
  final Value<String?> parent;
  final Value<int> rowid;
  const OrgUnitsCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.path = const Value.absent(),
    this.level = const Value.absent(),
    this.parent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrgUnitsCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    required String name,
    this.code = const Value.absent(),
    required String path,
    required int level,
    this.parent = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        path = Value(path),
        level = Value(level);
  static Insertable<OrgUnit> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? displayName,
    Expression<String>? label,
    Expression<String>? translations,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? path,
    Expression<int>? level,
    Expression<String>? parent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (displayName != null) 'display_name': displayName,
      if (label != null) 'label': label,
      if (translations != null) 'translations': translations,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (path != null) 'path': path,
      if (level != null) 'level': level,
      if (parent != null) 'parent': parent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrgUnitsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<String?>? displayName,
      Value<Map<String, dynamic>?>? label,
      Value<List<Translation>>? translations,
      Value<String>? name,
      Value<String?>? code,
      Value<String>? path,
      Value<int>? level,
      Value<String?>? parent,
      Value<int>? rowid}) {
    return OrgUnitsCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      displayName: displayName ?? this.displayName,
      label: label ?? this.label,
      translations: translations ?? this.translations,
      name: name ?? this.name,
      code: code ?? this.code,
      path: path ?? this.path,
      level: level ?? this.level,
      parent: parent ?? this.parent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (label.present) {
      map['label'] =
          Variable<String>($OrgUnitsTable.$converterlabel.toSql(label.value));
    }
    if (translations.present) {
      map['translations'] = Variable<String>(
          $OrgUnitsTable.$convertertranslations.toSql(translations.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (parent.present) {
      map['parent'] = Variable<String>(parent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrgUnitsCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('path: $path, ')
          ..write('level: $level, ')
          ..write('parent: $parent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OuLevelsTable extends OuLevels with TableInfo<$OuLevelsTable, OuLevel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OuLevelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      label = GeneratedColumn<String>('label', aliasedName, true,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '{}')
          .withConverter<Map<String, dynamic>?>($OuLevelsTable.$converterlabel);
  @override
  late final GeneratedColumnWithTypeConverter<List<Translation>, String>
      translations = GeneratedColumn<String>('translations', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '[]')
          .withConverter<List<Translation>>(
              $OuLevelsTable.$convertertranslations);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _offlineLevelsMeta =
      const VerificationMeta('offlineLevels');
  @override
  late final GeneratedColumn<int> offlineLevels = GeneratedColumn<int>(
      'offline_levels', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lastModifiedDate,
        createdDate,
        displayName,
        label,
        translations,
        name,
        code,
        level,
        offlineLevels
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ou_levels';
  @override
  VerificationContext validateIntegrity(Insertable<OuLevel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('offline_levels')) {
      context.handle(
          _offlineLevelsMeta,
          offlineLevels.isAcceptableOrUnknown(
              data['offline_levels']!, _offlineLevelsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OuLevel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OuLevel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name']),
      label: $OuLevelsTable.$converterlabel.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])),
      translations: $OuLevelsTable.$convertertranslations.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}translations'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      offlineLevels: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}offline_levels']),
    );
  }

  @override
  $OuLevelsTable createAlias(String alias) {
    return $OuLevelsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?> $converterlabel =
      const NullAwareMapConverter();
  static TypeConverter<List<Translation>, String> $convertertranslations =
      const TranslationConverter();
}

class OuLevel extends DataClass implements Insertable<OuLevel> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final String? displayName;
  final Map<String, dynamic>? label;
  final List<Translation> translations;
  final String name;
  final String? code;
  final int level;
  final int? offlineLevels;
  const OuLevel(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      this.displayName,
      this.label,
      required this.translations,
      required this.name,
      this.code,
      required this.level,
      this.offlineLevels});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || label != null) {
      map['label'] =
          Variable<String>($OuLevelsTable.$converterlabel.toSql(label));
    }
    {
      map['translations'] = Variable<String>(
          $OuLevelsTable.$convertertranslations.toSql(translations));
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['level'] = Variable<int>(level);
    if (!nullToAbsent || offlineLevels != null) {
      map['offline_levels'] = Variable<int>(offlineLevels);
    }
    return map;
  }

  OuLevelsCompanion toCompanion(bool nullToAbsent) {
    return OuLevelsCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
      translations: Value(translations),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      level: Value(level),
      offlineLevels: offlineLevels == null && nullToAbsent
          ? const Value.absent()
          : Value(offlineLevels),
    );
  }

  factory OuLevel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OuLevel(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      label: serializer.fromJson<Map<String, dynamic>?>(json['label']),
      translations:
          serializer.fromJson<List<Translation>>(json['translations']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      level: serializer.fromJson<int>(json['level']),
      offlineLevels: serializer.fromJson<int?>(json['offlineLevels']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'displayName': serializer.toJson<String?>(displayName),
      'label': serializer.toJson<Map<String, dynamic>?>(label),
      'translations': serializer.toJson<List<Translation>>(translations),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'level': serializer.toJson<int>(level),
      'offlineLevels': serializer.toJson<int?>(offlineLevels),
    };
  }

  OuLevel copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          Value<String?> displayName = const Value.absent(),
          Value<Map<String, dynamic>?> label = const Value.absent(),
          List<Translation>? translations,
          String? name,
          Value<String?> code = const Value.absent(),
          int? level,
          Value<int?> offlineLevels = const Value.absent()}) =>
      OuLevel(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        displayName: displayName.present ? displayName.value : this.displayName,
        label: label.present ? label.value : this.label,
        translations: translations ?? this.translations,
        name: name ?? this.name,
        code: code.present ? code.value : this.code,
        level: level ?? this.level,
        offlineLevels:
            offlineLevels.present ? offlineLevels.value : this.offlineLevels,
      );
  OuLevel copyWithCompanion(OuLevelsCompanion data) {
    return OuLevel(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      label: data.label.present ? data.label.value : this.label,
      translations: data.translations.present
          ? data.translations.value
          : this.translations,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      level: data.level.present ? data.level.value : this.level,
      offlineLevels: data.offlineLevels.present
          ? data.offlineLevels.value
          : this.offlineLevels,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OuLevel(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('level: $level, ')
          ..write('offlineLevels: $offlineLevels')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastModifiedDate, createdDate,
      displayName, label, translations, name, code, level, offlineLevels);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OuLevel &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.displayName == this.displayName &&
          other.label == this.label &&
          other.translations == this.translations &&
          other.name == this.name &&
          other.code == this.code &&
          other.level == this.level &&
          other.offlineLevels == this.offlineLevels);
}

class OuLevelsCompanion extends UpdateCompanion<OuLevel> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<String?> displayName;
  final Value<Map<String, dynamic>?> label;
  final Value<List<Translation>> translations;
  final Value<String> name;
  final Value<String?> code;
  final Value<int> level;
  final Value<int?> offlineLevels;
  final Value<int> rowid;
  const OuLevelsCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.level = const Value.absent(),
    this.offlineLevels = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OuLevelsCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    required String name,
    this.code = const Value.absent(),
    required int level,
    this.offlineLevels = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        level = Value(level);
  static Insertable<OuLevel> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? displayName,
    Expression<String>? label,
    Expression<String>? translations,
    Expression<String>? name,
    Expression<String>? code,
    Expression<int>? level,
    Expression<int>? offlineLevels,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (displayName != null) 'display_name': displayName,
      if (label != null) 'label': label,
      if (translations != null) 'translations': translations,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (level != null) 'level': level,
      if (offlineLevels != null) 'offline_levels': offlineLevels,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OuLevelsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<String?>? displayName,
      Value<Map<String, dynamic>?>? label,
      Value<List<Translation>>? translations,
      Value<String>? name,
      Value<String?>? code,
      Value<int>? level,
      Value<int?>? offlineLevels,
      Value<int>? rowid}) {
    return OuLevelsCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      displayName: displayName ?? this.displayName,
      label: label ?? this.label,
      translations: translations ?? this.translations,
      name: name ?? this.name,
      code: code ?? this.code,
      level: level ?? this.level,
      offlineLevels: offlineLevels ?? this.offlineLevels,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (label.present) {
      map['label'] =
          Variable<String>($OuLevelsTable.$converterlabel.toSql(label.value));
    }
    if (translations.present) {
      map['translations'] = Variable<String>(
          $OuLevelsTable.$convertertranslations.toSql(translations.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (offlineLevels.present) {
      map['offline_levels'] = Variable<int>(offlineLevels.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OuLevelsCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('level: $level, ')
          ..write('offlineLevels: $offlineLevels, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      label = GeneratedColumn<String>('label', aliasedName, true,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '{}')
          .withConverter<Map<String, dynamic>?>($ProjectsTable.$converterlabel);
  @override
  late final GeneratedColumnWithTypeConverter<List<Translation>, String>
      translations = GeneratedColumn<String>('translations', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '[]')
          .withConverter<List<Translation>>(
              $ProjectsTable.$convertertranslations);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _disabledMeta =
      const VerificationMeta('disabled');
  @override
  late final GeneratedColumn<bool> disabled = GeneratedColumn<bool>(
      'disabled', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("disabled" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lastModifiedDate,
        createdDate,
        displayName,
        label,
        translations,
        name,
        code,
        disabled
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(Insertable<Project> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('disabled')) {
      context.handle(_disabledMeta,
          disabled.isAcceptableOrUnknown(data['disabled']!, _disabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name']),
      label: $ProjectsTable.$converterlabel.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])),
      translations: $ProjectsTable.$convertertranslations.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}translations'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      disabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}disabled']),
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?> $converterlabel =
      const NullAwareMapConverter();
  static TypeConverter<List<Translation>, String> $convertertranslations =
      const TranslationConverter();
}

class Project extends DataClass implements Insertable<Project> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final String? displayName;
  final Map<String, dynamic>? label;
  final List<Translation> translations;
  final String name;
  final String? code;
  final bool? disabled;
  const Project(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      this.displayName,
      this.label,
      required this.translations,
      required this.name,
      this.code,
      this.disabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || label != null) {
      map['label'] =
          Variable<String>($ProjectsTable.$converterlabel.toSql(label));
    }
    {
      map['translations'] = Variable<String>(
          $ProjectsTable.$convertertranslations.toSql(translations));
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || disabled != null) {
      map['disabled'] = Variable<bool>(disabled);
    }
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
      translations: Value(translations),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      disabled: disabled == null && nullToAbsent
          ? const Value.absent()
          : Value(disabled),
    );
  }

  factory Project.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      label: serializer.fromJson<Map<String, dynamic>?>(json['label']),
      translations:
          serializer.fromJson<List<Translation>>(json['translations']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      disabled: serializer.fromJson<bool?>(json['disabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'displayName': serializer.toJson<String?>(displayName),
      'label': serializer.toJson<Map<String, dynamic>?>(label),
      'translations': serializer.toJson<List<Translation>>(translations),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'disabled': serializer.toJson<bool?>(disabled),
    };
  }

  Project copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          Value<String?> displayName = const Value.absent(),
          Value<Map<String, dynamic>?> label = const Value.absent(),
          List<Translation>? translations,
          String? name,
          Value<String?> code = const Value.absent(),
          Value<bool?> disabled = const Value.absent()}) =>
      Project(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        displayName: displayName.present ? displayName.value : this.displayName,
        label: label.present ? label.value : this.label,
        translations: translations ?? this.translations,
        name: name ?? this.name,
        code: code.present ? code.value : this.code,
        disabled: disabled.present ? disabled.value : this.disabled,
      );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      label: data.label.present ? data.label.value : this.label,
      translations: data.translations.present
          ? data.translations.value
          : this.translations,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      disabled: data.disabled.present ? data.disabled.value : this.disabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('disabled: $disabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastModifiedDate, createdDate,
      displayName, label, translations, name, code, disabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.displayName == this.displayName &&
          other.label == this.label &&
          other.translations == this.translations &&
          other.name == this.name &&
          other.code == this.code &&
          other.disabled == this.disabled);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<String?> displayName;
  final Value<Map<String, dynamic>?> label;
  final Value<List<Translation>> translations;
  final Value<String> name;
  final Value<String?> code;
  final Value<bool?> disabled;
  final Value<int> rowid;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.disabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectsCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    required String name,
    this.code = const Value.absent(),
    this.disabled = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Project> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? displayName,
    Expression<String>? label,
    Expression<String>? translations,
    Expression<String>? name,
    Expression<String>? code,
    Expression<bool>? disabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (displayName != null) 'display_name': displayName,
      if (label != null) 'label': label,
      if (translations != null) 'translations': translations,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (disabled != null) 'disabled': disabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<String?>? displayName,
      Value<Map<String, dynamic>?>? label,
      Value<List<Translation>>? translations,
      Value<String>? name,
      Value<String?>? code,
      Value<bool?>? disabled,
      Value<int>? rowid}) {
    return ProjectsCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      displayName: displayName ?? this.displayName,
      label: label ?? this.label,
      translations: translations ?? this.translations,
      name: name ?? this.name,
      code: code ?? this.code,
      disabled: disabled ?? this.disabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (label.present) {
      map['label'] =
          Variable<String>($ProjectsTable.$converterlabel.toSql(label.value));
    }
    if (translations.present) {
      map['translations'] = Variable<String>(
          $ProjectsTable.$convertertranslations.toSql(translations.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (disabled.present) {
      map['disabled'] = Variable<bool>(disabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('disabled: $disabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivitiesTable extends Activities
    with TableInfo<$ActivitiesTable, Activity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      label = GeneratedColumn<String>('label', aliasedName, true,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '{}')
          .withConverter<Map<String, dynamic>?>(
              $ActivitiesTable.$converterlabel);
  @override
  late final GeneratedColumnWithTypeConverter<List<Translation>, String>
      translations = GeneratedColumn<String>('translations', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '[]')
          .withConverter<List<Translation>>(
              $ActivitiesTable.$convertertranslations);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _projectMeta =
      const VerificationMeta('project');
  @override
  late final GeneratedColumn<String> project = GeneratedColumn<String>(
      'project', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES projects (id)'));
  static const VerificationMeta _disabledMeta =
      const VerificationMeta('disabled');
  @override
  late final GeneratedColumn<bool> disabled = GeneratedColumn<bool>(
      'disabled', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("disabled" IN (0, 1))'));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lastModifiedDate,
        createdDate,
        displayName,
        label,
        translations,
        name,
        code,
        project,
        disabled,
        startDate,
        endDate,
        description
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activities';
  @override
  VerificationContext validateIntegrity(Insertable<Activity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('project')) {
      context.handle(_projectMeta,
          project.isAcceptableOrUnknown(data['project']!, _projectMeta));
    } else if (isInserting) {
      context.missing(_projectMeta);
    }
    if (data.containsKey('disabled')) {
      context.handle(_disabledMeta,
          disabled.isAcceptableOrUnknown(data['disabled']!, _disabledMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Activity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Activity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name']),
      label: $ActivitiesTable.$converterlabel.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])),
      translations: $ActivitiesTable.$convertertranslations.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}translations'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      project: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project'])!,
      disabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}disabled']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  $ActivitiesTable createAlias(String alias) {
    return $ActivitiesTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?> $converterlabel =
      const NullAwareMapConverter();
  static TypeConverter<List<Translation>, String> $convertertranslations =
      const TranslationConverter();
}

class Activity extends DataClass implements Insertable<Activity> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final String? displayName;
  final Map<String, dynamic>? label;
  final List<Translation> translations;
  final String name;
  final String? code;
  final String project;
  final bool? disabled;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? description;
  const Activity(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      this.displayName,
      this.label,
      required this.translations,
      required this.name,
      this.code,
      required this.project,
      this.disabled,
      this.startDate,
      this.endDate,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || label != null) {
      map['label'] =
          Variable<String>($ActivitiesTable.$converterlabel.toSql(label));
    }
    {
      map['translations'] = Variable<String>(
          $ActivitiesTable.$convertertranslations.toSql(translations));
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['project'] = Variable<String>(project);
    if (!nullToAbsent || disabled != null) {
      map['disabled'] = Variable<bool>(disabled);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  ActivitiesCompanion toCompanion(bool nullToAbsent) {
    return ActivitiesCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
      translations: Value(translations),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      project: Value(project),
      disabled: disabled == null && nullToAbsent
          ? const Value.absent()
          : Value(disabled),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Activity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Activity(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      label: serializer.fromJson<Map<String, dynamic>?>(json['label']),
      translations:
          serializer.fromJson<List<Translation>>(json['translations']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      project: serializer.fromJson<String>(json['project']),
      disabled: serializer.fromJson<bool?>(json['disabled']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'displayName': serializer.toJson<String?>(displayName),
      'label': serializer.toJson<Map<String, dynamic>?>(label),
      'translations': serializer.toJson<List<Translation>>(translations),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'project': serializer.toJson<String>(project),
      'disabled': serializer.toJson<bool?>(disabled),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'description': serializer.toJson<String?>(description),
    };
  }

  Activity copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          Value<String?> displayName = const Value.absent(),
          Value<Map<String, dynamic>?> label = const Value.absent(),
          List<Translation>? translations,
          String? name,
          Value<String?> code = const Value.absent(),
          String? project,
          Value<bool?> disabled = const Value.absent(),
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> endDate = const Value.absent(),
          Value<String?> description = const Value.absent()}) =>
      Activity(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        displayName: displayName.present ? displayName.value : this.displayName,
        label: label.present ? label.value : this.label,
        translations: translations ?? this.translations,
        name: name ?? this.name,
        code: code.present ? code.value : this.code,
        project: project ?? this.project,
        disabled: disabled.present ? disabled.value : this.disabled,
        startDate: startDate.present ? startDate.value : this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        description: description.present ? description.value : this.description,
      );
  Activity copyWithCompanion(ActivitiesCompanion data) {
    return Activity(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      label: data.label.present ? data.label.value : this.label,
      translations: data.translations.present
          ? data.translations.value
          : this.translations,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      project: data.project.present ? data.project.value : this.project,
      disabled: data.disabled.present ? data.disabled.value : this.disabled,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Activity(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('project: $project, ')
          ..write('disabled: $disabled, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      lastModifiedDate,
      createdDate,
      displayName,
      label,
      translations,
      name,
      code,
      project,
      disabled,
      startDate,
      endDate,
      description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Activity &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.displayName == this.displayName &&
          other.label == this.label &&
          other.translations == this.translations &&
          other.name == this.name &&
          other.code == this.code &&
          other.project == this.project &&
          other.disabled == this.disabled &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.description == this.description);
}

class ActivitiesCompanion extends UpdateCompanion<Activity> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<String?> displayName;
  final Value<Map<String, dynamic>?> label;
  final Value<List<Translation>> translations;
  final Value<String> name;
  final Value<String?> code;
  final Value<String> project;
  final Value<bool?> disabled;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<String?> description;
  final Value<int> rowid;
  const ActivitiesCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.project = const Value.absent(),
    this.disabled = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivitiesCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    required String name,
    this.code = const Value.absent(),
    required String project,
    this.disabled = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        project = Value(project);
  static Insertable<Activity> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? displayName,
    Expression<String>? label,
    Expression<String>? translations,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? project,
    Expression<bool>? disabled,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (displayName != null) 'display_name': displayName,
      if (label != null) 'label': label,
      if (translations != null) 'translations': translations,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (project != null) 'project': project,
      if (disabled != null) 'disabled': disabled,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivitiesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<String?>? displayName,
      Value<Map<String, dynamic>?>? label,
      Value<List<Translation>>? translations,
      Value<String>? name,
      Value<String?>? code,
      Value<String>? project,
      Value<bool?>? disabled,
      Value<DateTime?>? startDate,
      Value<DateTime?>? endDate,
      Value<String?>? description,
      Value<int>? rowid}) {
    return ActivitiesCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      displayName: displayName ?? this.displayName,
      label: label ?? this.label,
      translations: translations ?? this.translations,
      name: name ?? this.name,
      code: code ?? this.code,
      project: project ?? this.project,
      disabled: disabled ?? this.disabled,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (label.present) {
      map['label'] =
          Variable<String>($ActivitiesTable.$converterlabel.toSql(label.value));
    }
    if (translations.present) {
      map['translations'] = Variable<String>(
          $ActivitiesTable.$convertertranslations.toSql(translations.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (project.present) {
      map['project'] = Variable<String>(project.value);
    }
    if (disabled.present) {
      map['disabled'] = Variable<bool>(disabled.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('project: $project, ')
          ..write('disabled: $disabled, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TeamsTable extends Teams with TableInfo<$TeamsTable, Team> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _disabledMeta =
      const VerificationMeta('disabled');
  @override
  late final GeneratedColumn<bool> disabled = GeneratedColumn<bool>(
      'disabled', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("disabled" IN (0, 1))'));
  static const VerificationMeta _activityMeta =
      const VerificationMeta('activity');
  @override
  late final GeneratedColumn<String> activity = GeneratedColumn<String>(
      'activity', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES activities (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, lastModifiedDate, createdDate, code, disabled, activity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teams';
  @override
  VerificationContext validateIntegrity(Insertable<Team> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('disabled')) {
      context.handle(_disabledMeta,
          disabled.isAcceptableOrUnknown(data['disabled']!, _disabledMeta));
    }
    if (data.containsKey('activity')) {
      context.handle(_activityMeta,
          activity.isAcceptableOrUnknown(data['activity']!, _activityMeta));
    } else if (isInserting) {
      context.missing(_activityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Team map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Team(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      disabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}disabled']),
      activity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity'])!,
    );
  }

  @override
  $TeamsTable createAlias(String alias) {
    return $TeamsTable(attachedDatabase, alias);
  }
}

class Team extends DataClass implements Insertable<Team> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final String? code;
  final bool? disabled;
  final String activity;
  const Team(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      this.code,
      this.disabled,
      required this.activity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || disabled != null) {
      map['disabled'] = Variable<bool>(disabled);
    }
    map['activity'] = Variable<String>(activity);
    return map;
  }

  TeamsCompanion toCompanion(bool nullToAbsent) {
    return TeamsCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      disabled: disabled == null && nullToAbsent
          ? const Value.absent()
          : Value(disabled),
      activity: Value(activity),
    );
  }

  factory Team.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Team(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      code: serializer.fromJson<String?>(json['code']),
      disabled: serializer.fromJson<bool?>(json['disabled']),
      activity: serializer.fromJson<String>(json['activity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'code': serializer.toJson<String?>(code),
      'disabled': serializer.toJson<bool?>(disabled),
      'activity': serializer.toJson<String>(activity),
    };
  }

  Team copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          Value<String?> code = const Value.absent(),
          Value<bool?> disabled = const Value.absent(),
          String? activity}) =>
      Team(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        code: code.present ? code.value : this.code,
        disabled: disabled.present ? disabled.value : this.disabled,
        activity: activity ?? this.activity,
      );
  Team copyWithCompanion(TeamsCompanion data) {
    return Team(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      code: data.code.present ? data.code.value : this.code,
      disabled: data.disabled.present ? data.disabled.value : this.disabled,
      activity: data.activity.present ? data.activity.value : this.activity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Team(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('code: $code, ')
          ..write('disabled: $disabled, ')
          ..write('activity: $activity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, lastModifiedDate, createdDate, code, disabled, activity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Team &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.code == this.code &&
          other.disabled == this.disabled &&
          other.activity == this.activity);
}

class TeamsCompanion extends UpdateCompanion<Team> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<String?> code;
  final Value<bool?> disabled;
  final Value<String> activity;
  final Value<int> rowid;
  const TeamsCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.code = const Value.absent(),
    this.disabled = const Value.absent(),
    this.activity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeamsCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.code = const Value.absent(),
    this.disabled = const Value.absent(),
    required String activity,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        activity = Value(activity);
  static Insertable<Team> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? code,
    Expression<bool>? disabled,
    Expression<String>? activity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (code != null) 'code': code,
      if (disabled != null) 'disabled': disabled,
      if (activity != null) 'activity': activity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeamsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<String?>? code,
      Value<bool?>? disabled,
      Value<String>? activity,
      Value<int>? rowid}) {
    return TeamsCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      code: code ?? this.code,
      disabled: disabled ?? this.disabled,
      activity: activity ?? this.activity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (disabled.present) {
      map['disabled'] = Variable<bool>(disabled.value);
    }
    if (activity.present) {
      map['activity'] = Variable<String>(activity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamsCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('code: $code, ')
          ..write('disabled: $disabled, ')
          ..write('activity: $activity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ManagedTeamsTable extends ManagedTeams
    with TableInfo<$ManagedTeamsTable, ManagedTeam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ManagedTeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activityMeta =
      const VerificationMeta('activity');
  @override
  late final GeneratedColumn<String> activity = GeneratedColumn<String>(
      'activity', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES activities (id)'));
  static const VerificationMeta _managedByMeta =
      const VerificationMeta('managedBy');
  @override
  late final GeneratedColumn<String> managedBy = GeneratedColumn<String>(
      'managed_by', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES teams (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, lastModifiedDate, createdDate, code, activity, managedBy];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'managed_teams';
  @override
  VerificationContext validateIntegrity(Insertable<ManagedTeam> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('activity')) {
      context.handle(_activityMeta,
          activity.isAcceptableOrUnknown(data['activity']!, _activityMeta));
    } else if (isInserting) {
      context.missing(_activityMeta);
    }
    if (data.containsKey('managed_by')) {
      context.handle(_managedByMeta,
          managedBy.isAcceptableOrUnknown(data['managed_by']!, _managedByMeta));
    } else if (isInserting) {
      context.missing(_managedByMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ManagedTeam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ManagedTeam(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      activity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity'])!,
      managedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}managed_by'])!,
    );
  }

  @override
  $ManagedTeamsTable createAlias(String alias) {
    return $ManagedTeamsTable(attachedDatabase, alias);
  }
}

class ManagedTeam extends DataClass implements Insertable<ManagedTeam> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final String? code;
  final String activity;
  final String managedBy;
  const ManagedTeam(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      this.code,
      required this.activity,
      required this.managedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['activity'] = Variable<String>(activity);
    map['managed_by'] = Variable<String>(managedBy);
    return map;
  }

  ManagedTeamsCompanion toCompanion(bool nullToAbsent) {
    return ManagedTeamsCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      activity: Value(activity),
      managedBy: Value(managedBy),
    );
  }

  factory ManagedTeam.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ManagedTeam(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      code: serializer.fromJson<String?>(json['code']),
      activity: serializer.fromJson<String>(json['activity']),
      managedBy: serializer.fromJson<String>(json['managedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'code': serializer.toJson<String?>(code),
      'activity': serializer.toJson<String>(activity),
      'managedBy': serializer.toJson<String>(managedBy),
    };
  }

  ManagedTeam copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          Value<String?> code = const Value.absent(),
          String? activity,
          String? managedBy}) =>
      ManagedTeam(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        code: code.present ? code.value : this.code,
        activity: activity ?? this.activity,
        managedBy: managedBy ?? this.managedBy,
      );
  ManagedTeam copyWithCompanion(ManagedTeamsCompanion data) {
    return ManagedTeam(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      code: data.code.present ? data.code.value : this.code,
      activity: data.activity.present ? data.activity.value : this.activity,
      managedBy: data.managedBy.present ? data.managedBy.value : this.managedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ManagedTeam(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('code: $code, ')
          ..write('activity: $activity, ')
          ..write('managedBy: $managedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, lastModifiedDate, createdDate, code, activity, managedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ManagedTeam &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.code == this.code &&
          other.activity == this.activity &&
          other.managedBy == this.managedBy);
}

class ManagedTeamsCompanion extends UpdateCompanion<ManagedTeam> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<String?> code;
  final Value<String> activity;
  final Value<String> managedBy;
  final Value<int> rowid;
  const ManagedTeamsCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.code = const Value.absent(),
    this.activity = const Value.absent(),
    this.managedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ManagedTeamsCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.code = const Value.absent(),
    required String activity,
    required String managedBy,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        activity = Value(activity),
        managedBy = Value(managedBy);
  static Insertable<ManagedTeam> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? code,
    Expression<String>? activity,
    Expression<String>? managedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (code != null) 'code': code,
      if (activity != null) 'activity': activity,
      if (managedBy != null) 'managed_by': managedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ManagedTeamsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<String?>? code,
      Value<String>? activity,
      Value<String>? managedBy,
      Value<int>? rowid}) {
    return ManagedTeamsCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      code: code ?? this.code,
      activity: activity ?? this.activity,
      managedBy: managedBy ?? this.managedBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (activity.present) {
      map['activity'] = Variable<String>(activity.value);
    }
    if (managedBy.present) {
      map['managed_by'] = Variable<String>(managedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ManagedTeamsCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('code: $code, ')
          ..write('activity: $activity, ')
          ..write('managedBy: $managedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssignmentsTable extends Assignments
    with TableInfo<$AssignmentsTable, Assignment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _activityMeta =
      const VerificationMeta('activity');
  @override
  late final GeneratedColumn<String> activity = GeneratedColumn<String>(
      'activity', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES activities (id)'));
  static const VerificationMeta _teamMeta = const VerificationMeta('team');
  @override
  late final GeneratedColumn<String> team = GeneratedColumn<String>(
      'team', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES teams (id)'));
  static const VerificationMeta _orgUnitMeta =
      const VerificationMeta('orgUnit');
  @override
  late final GeneratedColumn<String> orgUnit = GeneratedColumn<String>(
      'org_unit', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES org_units (id)'));
  static const VerificationMeta _instanceDateMeta =
      const VerificationMeta('instanceDate');
  @override
  late final GeneratedColumn<DateTime> instanceDate = GeneratedColumn<DateTime>(
      'instance_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<InstanceSyncStatus, String>
      syncState = GeneratedColumn<String>('sync_state', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<InstanceSyncStatus>(
              $AssignmentsTable.$convertersyncState);
  @override
  late final GeneratedColumnWithTypeConverter<AssignmentStatus?, String>
      status = GeneratedColumn<String>('status', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<AssignmentStatus?>(
              $AssignmentsTable.$converterstatusn);
  static const VerificationMeta _completedDateMeta =
      const VerificationMeta('completedDate');
  @override
  late final GeneratedColumn<DateTime> completedDate =
      GeneratedColumn<DateTime>('completed_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtClientMeta =
      const VerificationMeta('updatedAtClient');
  @override
  late final GeneratedColumn<DateTime> updatedAtClient =
      GeneratedColumn<DateTime>('updated_at_client', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _disabledMeta =
      const VerificationMeta('disabled');
  @override
  late final GeneratedColumn<bool> disabled = GeneratedColumn<bool>(
      'disabled', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("disabled" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lastModifiedDate,
        createdDate,
        activity,
        team,
        orgUnit,
        instanceDate,
        syncState,
        status,
        completedDate,
        updatedAtClient,
        disabled
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assignments';
  @override
  VerificationContext validateIntegrity(Insertable<Assignment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('activity')) {
      context.handle(_activityMeta,
          activity.isAcceptableOrUnknown(data['activity']!, _activityMeta));
    } else if (isInserting) {
      context.missing(_activityMeta);
    }
    if (data.containsKey('team')) {
      context.handle(
          _teamMeta, team.isAcceptableOrUnknown(data['team']!, _teamMeta));
    } else if (isInserting) {
      context.missing(_teamMeta);
    }
    if (data.containsKey('org_unit')) {
      context.handle(_orgUnitMeta,
          orgUnit.isAcceptableOrUnknown(data['org_unit']!, _orgUnitMeta));
    } else if (isInserting) {
      context.missing(_orgUnitMeta);
    }
    if (data.containsKey('instance_date')) {
      context.handle(
          _instanceDateMeta,
          instanceDate.isAcceptableOrUnknown(
              data['instance_date']!, _instanceDateMeta));
    }
    if (data.containsKey('completed_date')) {
      context.handle(
          _completedDateMeta,
          completedDate.isAcceptableOrUnknown(
              data['completed_date']!, _completedDateMeta));
    }
    if (data.containsKey('updated_at_client')) {
      context.handle(
          _updatedAtClientMeta,
          updatedAtClient.isAcceptableOrUnknown(
              data['updated_at_client']!, _updatedAtClientMeta));
    }
    if (data.containsKey('disabled')) {
      context.handle(_disabledMeta,
          disabled.isAcceptableOrUnknown(data['disabled']!, _disabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Assignment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Assignment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      activity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity'])!,
      team: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}team'])!,
      orgUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}org_unit'])!,
      instanceDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}instance_date']),
      syncState: $AssignmentsTable.$convertersyncState.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!),
      status: $AssignmentsTable.$converterstatusn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])),
      completedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}completed_date']),
      updatedAtClient: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}updated_at_client']),
      disabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}disabled']),
    );
  }

  @override
  $AssignmentsTable createAlias(String alias) {
    return $AssignmentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<InstanceSyncStatus, String, String>
      $convertersyncState = const EnumNameConverter(InstanceSyncStatus.values);
  static JsonTypeConverter2<AssignmentStatus, String, String> $converterstatus =
      const EnumNameConverter(AssignmentStatus.values);
  static JsonTypeConverter2<AssignmentStatus?, String?, String?>
      $converterstatusn = JsonTypeConverter2.asNullable($converterstatus);
}

class Assignment extends DataClass implements Insertable<Assignment> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final String activity;
  final String team;
  final String orgUnit;
  final DateTime? instanceDate;
  final InstanceSyncStatus syncState;
  final AssignmentStatus? status;
  final DateTime? completedDate;
  final DateTime? updatedAtClient;
  final bool? disabled;
  const Assignment(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      required this.activity,
      required this.team,
      required this.orgUnit,
      this.instanceDate,
      required this.syncState,
      this.status,
      this.completedDate,
      this.updatedAtClient,
      this.disabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    map['activity'] = Variable<String>(activity);
    map['team'] = Variable<String>(team);
    map['org_unit'] = Variable<String>(orgUnit);
    if (!nullToAbsent || instanceDate != null) {
      map['instance_date'] = Variable<DateTime>(instanceDate);
    }
    {
      map['sync_state'] = Variable<String>(
          $AssignmentsTable.$convertersyncState.toSql(syncState));
    }
    if (!nullToAbsent || status != null) {
      map['status'] =
          Variable<String>($AssignmentsTable.$converterstatusn.toSql(status));
    }
    if (!nullToAbsent || completedDate != null) {
      map['completed_date'] = Variable<DateTime>(completedDate);
    }
    if (!nullToAbsent || updatedAtClient != null) {
      map['updated_at_client'] = Variable<DateTime>(updatedAtClient);
    }
    if (!nullToAbsent || disabled != null) {
      map['disabled'] = Variable<bool>(disabled);
    }
    return map;
  }

  AssignmentsCompanion toCompanion(bool nullToAbsent) {
    return AssignmentsCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      activity: Value(activity),
      team: Value(team),
      orgUnit: Value(orgUnit),
      instanceDate: instanceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(instanceDate),
      syncState: Value(syncState),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      completedDate: completedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(completedDate),
      updatedAtClient: updatedAtClient == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAtClient),
      disabled: disabled == null && nullToAbsent
          ? const Value.absent()
          : Value(disabled),
    );
  }

  factory Assignment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Assignment(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      activity: serializer.fromJson<String>(json['activity']),
      team: serializer.fromJson<String>(json['team']),
      orgUnit: serializer.fromJson<String>(json['orgUnit']),
      instanceDate: serializer.fromJson<DateTime?>(json['instanceDate']),
      syncState: $AssignmentsTable.$convertersyncState
          .fromJson(serializer.fromJson<String>(json['syncState'])),
      status: $AssignmentsTable.$converterstatusn
          .fromJson(serializer.fromJson<String?>(json['status'])),
      completedDate: serializer.fromJson<DateTime?>(json['completedDate']),
      updatedAtClient: serializer.fromJson<DateTime?>(json['updatedAtClient']),
      disabled: serializer.fromJson<bool?>(json['disabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'activity': serializer.toJson<String>(activity),
      'team': serializer.toJson<String>(team),
      'orgUnit': serializer.toJson<String>(orgUnit),
      'instanceDate': serializer.toJson<DateTime?>(instanceDate),
      'syncState': serializer.toJson<String>(
          $AssignmentsTable.$convertersyncState.toJson(syncState)),
      'status': serializer
          .toJson<String?>($AssignmentsTable.$converterstatusn.toJson(status)),
      'completedDate': serializer.toJson<DateTime?>(completedDate),
      'updatedAtClient': serializer.toJson<DateTime?>(updatedAtClient),
      'disabled': serializer.toJson<bool?>(disabled),
    };
  }

  Assignment copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          String? activity,
          String? team,
          String? orgUnit,
          Value<DateTime?> instanceDate = const Value.absent(),
          InstanceSyncStatus? syncState,
          Value<AssignmentStatus?> status = const Value.absent(),
          Value<DateTime?> completedDate = const Value.absent(),
          Value<DateTime?> updatedAtClient = const Value.absent(),
          Value<bool?> disabled = const Value.absent()}) =>
      Assignment(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        activity: activity ?? this.activity,
        team: team ?? this.team,
        orgUnit: orgUnit ?? this.orgUnit,
        instanceDate:
            instanceDate.present ? instanceDate.value : this.instanceDate,
        syncState: syncState ?? this.syncState,
        status: status.present ? status.value : this.status,
        completedDate:
            completedDate.present ? completedDate.value : this.completedDate,
        updatedAtClient: updatedAtClient.present
            ? updatedAtClient.value
            : this.updatedAtClient,
        disabled: disabled.present ? disabled.value : this.disabled,
      );
  Assignment copyWithCompanion(AssignmentsCompanion data) {
    return Assignment(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      activity: data.activity.present ? data.activity.value : this.activity,
      team: data.team.present ? data.team.value : this.team,
      orgUnit: data.orgUnit.present ? data.orgUnit.value : this.orgUnit,
      instanceDate: data.instanceDate.present
          ? data.instanceDate.value
          : this.instanceDate,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      status: data.status.present ? data.status.value : this.status,
      completedDate: data.completedDate.present
          ? data.completedDate.value
          : this.completedDate,
      updatedAtClient: data.updatedAtClient.present
          ? data.updatedAtClient.value
          : this.updatedAtClient,
      disabled: data.disabled.present ? data.disabled.value : this.disabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Assignment(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('activity: $activity, ')
          ..write('team: $team, ')
          ..write('orgUnit: $orgUnit, ')
          ..write('instanceDate: $instanceDate, ')
          ..write('syncState: $syncState, ')
          ..write('status: $status, ')
          ..write('completedDate: $completedDate, ')
          ..write('updatedAtClient: $updatedAtClient, ')
          ..write('disabled: $disabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      lastModifiedDate,
      createdDate,
      activity,
      team,
      orgUnit,
      instanceDate,
      syncState,
      status,
      completedDate,
      updatedAtClient,
      disabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Assignment &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.activity == this.activity &&
          other.team == this.team &&
          other.orgUnit == this.orgUnit &&
          other.instanceDate == this.instanceDate &&
          other.syncState == this.syncState &&
          other.status == this.status &&
          other.completedDate == this.completedDate &&
          other.updatedAtClient == this.updatedAtClient &&
          other.disabled == this.disabled);
}

class AssignmentsCompanion extends UpdateCompanion<Assignment> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<String> activity;
  final Value<String> team;
  final Value<String> orgUnit;
  final Value<DateTime?> instanceDate;
  final Value<InstanceSyncStatus> syncState;
  final Value<AssignmentStatus?> status;
  final Value<DateTime?> completedDate;
  final Value<DateTime?> updatedAtClient;
  final Value<bool?> disabled;
  final Value<int> rowid;
  const AssignmentsCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.activity = const Value.absent(),
    this.team = const Value.absent(),
    this.orgUnit = const Value.absent(),
    this.instanceDate = const Value.absent(),
    this.syncState = const Value.absent(),
    this.status = const Value.absent(),
    this.completedDate = const Value.absent(),
    this.updatedAtClient = const Value.absent(),
    this.disabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssignmentsCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    required String activity,
    required String team,
    required String orgUnit,
    this.instanceDate = const Value.absent(),
    required InstanceSyncStatus syncState,
    this.status = const Value.absent(),
    this.completedDate = const Value.absent(),
    this.updatedAtClient = const Value.absent(),
    this.disabled = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        activity = Value(activity),
        team = Value(team),
        orgUnit = Value(orgUnit),
        syncState = Value(syncState);
  static Insertable<Assignment> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? activity,
    Expression<String>? team,
    Expression<String>? orgUnit,
    Expression<DateTime>? instanceDate,
    Expression<String>? syncState,
    Expression<String>? status,
    Expression<DateTime>? completedDate,
    Expression<DateTime>? updatedAtClient,
    Expression<bool>? disabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (activity != null) 'activity': activity,
      if (team != null) 'team': team,
      if (orgUnit != null) 'org_unit': orgUnit,
      if (instanceDate != null) 'instance_date': instanceDate,
      if (syncState != null) 'sync_state': syncState,
      if (status != null) 'status': status,
      if (completedDate != null) 'completed_date': completedDate,
      if (updatedAtClient != null) 'updated_at_client': updatedAtClient,
      if (disabled != null) 'disabled': disabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssignmentsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<String>? activity,
      Value<String>? team,
      Value<String>? orgUnit,
      Value<DateTime?>? instanceDate,
      Value<InstanceSyncStatus>? syncState,
      Value<AssignmentStatus?>? status,
      Value<DateTime?>? completedDate,
      Value<DateTime?>? updatedAtClient,
      Value<bool?>? disabled,
      Value<int>? rowid}) {
    return AssignmentsCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      activity: activity ?? this.activity,
      team: team ?? this.team,
      orgUnit: orgUnit ?? this.orgUnit,
      instanceDate: instanceDate ?? this.instanceDate,
      syncState: syncState ?? this.syncState,
      status: status ?? this.status,
      completedDate: completedDate ?? this.completedDate,
      updatedAtClient: updatedAtClient ?? this.updatedAtClient,
      disabled: disabled ?? this.disabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (activity.present) {
      map['activity'] = Variable<String>(activity.value);
    }
    if (team.present) {
      map['team'] = Variable<String>(team.value);
    }
    if (orgUnit.present) {
      map['org_unit'] = Variable<String>(orgUnit.value);
    }
    if (instanceDate.present) {
      map['instance_date'] = Variable<DateTime>(instanceDate.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(
          $AssignmentsTable.$convertersyncState.toSql(syncState.value));
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $AssignmentsTable.$converterstatusn.toSql(status.value));
    }
    if (completedDate.present) {
      map['completed_date'] = Variable<DateTime>(completedDate.value);
    }
    if (updatedAtClient.present) {
      map['updated_at_client'] = Variable<DateTime>(updatedAtClient.value);
    }
    if (disabled.present) {
      map['disabled'] = Variable<bool>(disabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssignmentsCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('activity: $activity, ')
          ..write('team: $team, ')
          ..write('orgUnit: $orgUnit, ')
          ..write('instanceDate: $instanceDate, ')
          ..write('syncState: $syncState, ')
          ..write('status: $status, ')
          ..write('completedDate: $completedDate, ')
          ..write('updatedAtClient: $updatedAtClient, ')
          ..write('disabled: $disabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FormTemplatesTable extends FormTemplates
    with TableInfo<$FormTemplatesTable, FormTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FormTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _versionUidMeta =
      const VerificationMeta('versionUid');
  @override
  late final GeneratedColumn<String> versionUid = GeneratedColumn<String>(
      'version_uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _versionNumberMeta =
      const VerificationMeta('versionNumber');
  @override
  late final GeneratedColumn<int> versionNumber = GeneratedColumn<int>(
      'version_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      label = GeneratedColumn<String>('label', aliasedName, true,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '{}')
          .withConverter<Map<String, dynamic>?>(
              $FormTemplatesTable.$converterlabel);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _disabledMeta =
      const VerificationMeta('disabled');
  @override
  late final GeneratedColumn<bool> disabled = GeneratedColumn<bool>(
      'disabled', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("disabled" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, versionUid, versionNumber, name, label, description, disabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'form_templates';
  @override
  VerificationContext validateIntegrity(Insertable<FormTemplate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('version_uid')) {
      context.handle(
          _versionUidMeta,
          versionUid.isAcceptableOrUnknown(
              data['version_uid']!, _versionUidMeta));
    } else if (isInserting) {
      context.missing(_versionUidMeta);
    }
    if (data.containsKey('version_number')) {
      context.handle(
          _versionNumberMeta,
          versionNumber.isAcceptableOrUnknown(
              data['version_number']!, _versionNumberMeta));
    } else if (isInserting) {
      context.missing(_versionNumberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('disabled')) {
      context.handle(_disabledMeta,
          disabled.isAcceptableOrUnknown(data['disabled']!, _disabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FormTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FormTemplate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      versionUid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}version_uid'])!,
      versionNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version_number'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      label: $FormTemplatesTable.$converterlabel.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      disabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}disabled']),
    );
  }

  @override
  $FormTemplatesTable createAlias(String alias) {
    return $FormTemplatesTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?> $converterlabel =
      const NullAwareMapConverter();
}

class FormTemplate extends DataClass implements Insertable<FormTemplate> {
  final String id;

  /// current form version uid
  final String versionUid;

  /// current form version number
  final int versionNumber;
  final String name;
  final Map<String, dynamic>? label;
  final String? description;
  final bool? disabled;
  const FormTemplate(
      {required this.id,
      required this.versionUid,
      required this.versionNumber,
      required this.name,
      this.label,
      this.description,
      this.disabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['version_uid'] = Variable<String>(versionUid);
    map['version_number'] = Variable<int>(versionNumber);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || label != null) {
      map['label'] =
          Variable<String>($FormTemplatesTable.$converterlabel.toSql(label));
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || disabled != null) {
      map['disabled'] = Variable<bool>(disabled);
    }
    return map;
  }

  FormTemplatesCompanion toCompanion(bool nullToAbsent) {
    return FormTemplatesCompanion(
      id: Value(id),
      versionUid: Value(versionUid),
      versionNumber: Value(versionNumber),
      name: Value(name),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      disabled: disabled == null && nullToAbsent
          ? const Value.absent()
          : Value(disabled),
    );
  }

  factory FormTemplate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FormTemplate(
      id: serializer.fromJson<String>(json['id']),
      versionUid: serializer.fromJson<String>(json['versionUid']),
      versionNumber: serializer.fromJson<int>(json['versionNumber']),
      name: serializer.fromJson<String>(json['name']),
      label: serializer.fromJson<Map<String, dynamic>?>(json['label']),
      description: serializer.fromJson<String?>(json['description']),
      disabled: serializer.fromJson<bool?>(json['disabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'versionUid': serializer.toJson<String>(versionUid),
      'versionNumber': serializer.toJson<int>(versionNumber),
      'name': serializer.toJson<String>(name),
      'label': serializer.toJson<Map<String, dynamic>?>(label),
      'description': serializer.toJson<String?>(description),
      'disabled': serializer.toJson<bool?>(disabled),
    };
  }

  FormTemplate copyWith(
          {String? id,
          String? versionUid,
          int? versionNumber,
          String? name,
          Value<Map<String, dynamic>?> label = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<bool?> disabled = const Value.absent()}) =>
      FormTemplate(
        id: id ?? this.id,
        versionUid: versionUid ?? this.versionUid,
        versionNumber: versionNumber ?? this.versionNumber,
        name: name ?? this.name,
        label: label.present ? label.value : this.label,
        description: description.present ? description.value : this.description,
        disabled: disabled.present ? disabled.value : this.disabled,
      );
  FormTemplate copyWithCompanion(FormTemplatesCompanion data) {
    return FormTemplate(
      id: data.id.present ? data.id.value : this.id,
      versionUid:
          data.versionUid.present ? data.versionUid.value : this.versionUid,
      versionNumber: data.versionNumber.present
          ? data.versionNumber.value
          : this.versionNumber,
      name: data.name.present ? data.name.value : this.name,
      label: data.label.present ? data.label.value : this.label,
      description:
          data.description.present ? data.description.value : this.description,
      disabled: data.disabled.present ? data.disabled.value : this.disabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FormTemplate(')
          ..write('id: $id, ')
          ..write('versionUid: $versionUid, ')
          ..write('versionNumber: $versionNumber, ')
          ..write('name: $name, ')
          ..write('label: $label, ')
          ..write('description: $description, ')
          ..write('disabled: $disabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, versionUid, versionNumber, name, label, description, disabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FormTemplate &&
          other.id == this.id &&
          other.versionUid == this.versionUid &&
          other.versionNumber == this.versionNumber &&
          other.name == this.name &&
          other.label == this.label &&
          other.description == this.description &&
          other.disabled == this.disabled);
}

class FormTemplatesCompanion extends UpdateCompanion<FormTemplate> {
  final Value<String> id;
  final Value<String> versionUid;
  final Value<int> versionNumber;
  final Value<String> name;
  final Value<Map<String, dynamic>?> label;
  final Value<String?> description;
  final Value<bool?> disabled;
  final Value<int> rowid;
  const FormTemplatesCompanion({
    this.id = const Value.absent(),
    this.versionUid = const Value.absent(),
    this.versionNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.label = const Value.absent(),
    this.description = const Value.absent(),
    this.disabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FormTemplatesCompanion.insert({
    required String id,
    required String versionUid,
    required int versionNumber,
    required String name,
    this.label = const Value.absent(),
    this.description = const Value.absent(),
    this.disabled = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        versionUid = Value(versionUid),
        versionNumber = Value(versionNumber),
        name = Value(name);
  static Insertable<FormTemplate> custom({
    Expression<String>? id,
    Expression<String>? versionUid,
    Expression<int>? versionNumber,
    Expression<String>? name,
    Expression<String>? label,
    Expression<String>? description,
    Expression<bool>? disabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (versionUid != null) 'version_uid': versionUid,
      if (versionNumber != null) 'version_number': versionNumber,
      if (name != null) 'name': name,
      if (label != null) 'label': label,
      if (description != null) 'description': description,
      if (disabled != null) 'disabled': disabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FormTemplatesCompanion copyWith(
      {Value<String>? id,
      Value<String>? versionUid,
      Value<int>? versionNumber,
      Value<String>? name,
      Value<Map<String, dynamic>?>? label,
      Value<String?>? description,
      Value<bool?>? disabled,
      Value<int>? rowid}) {
    return FormTemplatesCompanion(
      id: id ?? this.id,
      versionUid: versionUid ?? this.versionUid,
      versionNumber: versionNumber ?? this.versionNumber,
      name: name ?? this.name,
      label: label ?? this.label,
      description: description ?? this.description,
      disabled: disabled ?? this.disabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (versionUid.present) {
      map['version_uid'] = Variable<String>(versionUid.value);
    }
    if (versionNumber.present) {
      map['version_number'] = Variable<int>(versionNumber.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(
          $FormTemplatesTable.$converterlabel.toSql(label.value));
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (disabled.present) {
      map['disabled'] = Variable<bool>(disabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FormTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('versionUid: $versionUid, ')
          ..write('versionNumber: $versionNumber, ')
          ..write('name: $name, ')
          ..write('label: $label, ')
          ..write('description: $description, ')
          ..write('disabled: $disabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssignmentFormsTable extends AssignmentForms
    with TableInfo<$AssignmentFormsTable, AssignmentForm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssignmentFormsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _assignmentMeta =
      const VerificationMeta('assignment');
  @override
  late final GeneratedColumn<String> assignment = GeneratedColumn<String>(
      'assignment', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES assignments (id) ON UPDATE CASCADE'));
  static const VerificationMeta _formMeta = const VerificationMeta('form');
  @override
  late final GeneratedColumn<String> form = GeneratedColumn<String>(
      'form', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES form_templates (id)'));
  static const VerificationMeta _canAddSubmissionsMeta =
      const VerificationMeta('canAddSubmissions');
  @override
  late final GeneratedColumn<bool> canAddSubmissions = GeneratedColumn<bool>(
      'can_add_submissions', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_add_submissions" IN (0, 1))'),
      clientDefault: () => false);
  static const VerificationMeta _canViewSubmissionsMeta =
      const VerificationMeta('canViewSubmissions');
  @override
  late final GeneratedColumn<bool> canViewSubmissions = GeneratedColumn<bool>(
      'can_view_submissions', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_view_submissions" IN (0, 1))'),
      clientDefault: () => false);
  static const VerificationMeta _canEditSubmissionsMeta =
      const VerificationMeta('canEditSubmissions');
  @override
  late final GeneratedColumn<bool> canEditSubmissions = GeneratedColumn<bool>(
      'can_edit_submissions', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_edit_submissions" IN (0, 1))'),
      clientDefault: () => false);
  static const VerificationMeta _canDeleteSubmissionsMeta =
      const VerificationMeta('canDeleteSubmissions');
  @override
  late final GeneratedColumn<bool> canDeleteSubmissions = GeneratedColumn<bool>(
      'can_delete_submissions', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_delete_submissions" IN (0, 1))'),
      clientDefault: () => false);
  @override
  List<GeneratedColumn> get $columns => [
        assignment,
        form,
        canAddSubmissions,
        canViewSubmissions,
        canEditSubmissions,
        canDeleteSubmissions
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assignment_forms';
  @override
  VerificationContext validateIntegrity(Insertable<AssignmentForm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('assignment')) {
      context.handle(
          _assignmentMeta,
          assignment.isAcceptableOrUnknown(
              data['assignment']!, _assignmentMeta));
    } else if (isInserting) {
      context.missing(_assignmentMeta);
    }
    if (data.containsKey('form')) {
      context.handle(
          _formMeta, form.isAcceptableOrUnknown(data['form']!, _formMeta));
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('can_add_submissions')) {
      context.handle(
          _canAddSubmissionsMeta,
          canAddSubmissions.isAcceptableOrUnknown(
              data['can_add_submissions']!, _canAddSubmissionsMeta));
    }
    if (data.containsKey('can_view_submissions')) {
      context.handle(
          _canViewSubmissionsMeta,
          canViewSubmissions.isAcceptableOrUnknown(
              data['can_view_submissions']!, _canViewSubmissionsMeta));
    }
    if (data.containsKey('can_edit_submissions')) {
      context.handle(
          _canEditSubmissionsMeta,
          canEditSubmissions.isAcceptableOrUnknown(
              data['can_edit_submissions']!, _canEditSubmissionsMeta));
    }
    if (data.containsKey('can_delete_submissions')) {
      context.handle(
          _canDeleteSubmissionsMeta,
          canDeleteSubmissions.isAcceptableOrUnknown(
              data['can_delete_submissions']!, _canDeleteSubmissionsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {assignment, form};
  @override
  AssignmentForm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssignmentForm(
      assignment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}assignment'])!,
      form: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}form'])!,
      canAddSubmissions: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}can_add_submissions']),
      canViewSubmissions: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}can_view_submissions']),
      canEditSubmissions: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}can_edit_submissions']),
      canDeleteSubmissions: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}can_delete_submissions']),
    );
  }

  @override
  $AssignmentFormsTable createAlias(String alias) {
    return $AssignmentFormsTable(attachedDatabase, alias);
  }
}

class AssignmentForm extends DataClass implements Insertable<AssignmentForm> {
  final String assignment;
  final String form;
  final bool? canAddSubmissions;
  final bool? canViewSubmissions;
  final bool? canEditSubmissions;
  final bool? canDeleteSubmissions;
  const AssignmentForm(
      {required this.assignment,
      required this.form,
      this.canAddSubmissions,
      this.canViewSubmissions,
      this.canEditSubmissions,
      this.canDeleteSubmissions});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['assignment'] = Variable<String>(assignment);
    map['form'] = Variable<String>(form);
    if (!nullToAbsent || canAddSubmissions != null) {
      map['can_add_submissions'] = Variable<bool>(canAddSubmissions);
    }
    if (!nullToAbsent || canViewSubmissions != null) {
      map['can_view_submissions'] = Variable<bool>(canViewSubmissions);
    }
    if (!nullToAbsent || canEditSubmissions != null) {
      map['can_edit_submissions'] = Variable<bool>(canEditSubmissions);
    }
    if (!nullToAbsent || canDeleteSubmissions != null) {
      map['can_delete_submissions'] = Variable<bool>(canDeleteSubmissions);
    }
    return map;
  }

  AssignmentFormsCompanion toCompanion(bool nullToAbsent) {
    return AssignmentFormsCompanion(
      assignment: Value(assignment),
      form: Value(form),
      canAddSubmissions: canAddSubmissions == null && nullToAbsent
          ? const Value.absent()
          : Value(canAddSubmissions),
      canViewSubmissions: canViewSubmissions == null && nullToAbsent
          ? const Value.absent()
          : Value(canViewSubmissions),
      canEditSubmissions: canEditSubmissions == null && nullToAbsent
          ? const Value.absent()
          : Value(canEditSubmissions),
      canDeleteSubmissions: canDeleteSubmissions == null && nullToAbsent
          ? const Value.absent()
          : Value(canDeleteSubmissions),
    );
  }

  factory AssignmentForm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssignmentForm(
      assignment: serializer.fromJson<String>(json['assignment']),
      form: serializer.fromJson<String>(json['form']),
      canAddSubmissions: serializer.fromJson<bool?>(json['canAddSubmissions']),
      canViewSubmissions:
          serializer.fromJson<bool?>(json['canViewSubmissions']),
      canEditSubmissions:
          serializer.fromJson<bool?>(json['canEditSubmissions']),
      canDeleteSubmissions:
          serializer.fromJson<bool?>(json['canDeleteSubmissions']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'assignment': serializer.toJson<String>(assignment),
      'form': serializer.toJson<String>(form),
      'canAddSubmissions': serializer.toJson<bool?>(canAddSubmissions),
      'canViewSubmissions': serializer.toJson<bool?>(canViewSubmissions),
      'canEditSubmissions': serializer.toJson<bool?>(canEditSubmissions),
      'canDeleteSubmissions': serializer.toJson<bool?>(canDeleteSubmissions),
    };
  }

  AssignmentForm copyWith(
          {String? assignment,
          String? form,
          Value<bool?> canAddSubmissions = const Value.absent(),
          Value<bool?> canViewSubmissions = const Value.absent(),
          Value<bool?> canEditSubmissions = const Value.absent(),
          Value<bool?> canDeleteSubmissions = const Value.absent()}) =>
      AssignmentForm(
        assignment: assignment ?? this.assignment,
        form: form ?? this.form,
        canAddSubmissions: canAddSubmissions.present
            ? canAddSubmissions.value
            : this.canAddSubmissions,
        canViewSubmissions: canViewSubmissions.present
            ? canViewSubmissions.value
            : this.canViewSubmissions,
        canEditSubmissions: canEditSubmissions.present
            ? canEditSubmissions.value
            : this.canEditSubmissions,
        canDeleteSubmissions: canDeleteSubmissions.present
            ? canDeleteSubmissions.value
            : this.canDeleteSubmissions,
      );
  AssignmentForm copyWithCompanion(AssignmentFormsCompanion data) {
    return AssignmentForm(
      assignment:
          data.assignment.present ? data.assignment.value : this.assignment,
      form: data.form.present ? data.form.value : this.form,
      canAddSubmissions: data.canAddSubmissions.present
          ? data.canAddSubmissions.value
          : this.canAddSubmissions,
      canViewSubmissions: data.canViewSubmissions.present
          ? data.canViewSubmissions.value
          : this.canViewSubmissions,
      canEditSubmissions: data.canEditSubmissions.present
          ? data.canEditSubmissions.value
          : this.canEditSubmissions,
      canDeleteSubmissions: data.canDeleteSubmissions.present
          ? data.canDeleteSubmissions.value
          : this.canDeleteSubmissions,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssignmentForm(')
          ..write('assignment: $assignment, ')
          ..write('form: $form, ')
          ..write('canAddSubmissions: $canAddSubmissions, ')
          ..write('canViewSubmissions: $canViewSubmissions, ')
          ..write('canEditSubmissions: $canEditSubmissions, ')
          ..write('canDeleteSubmissions: $canDeleteSubmissions')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(assignment, form, canAddSubmissions,
      canViewSubmissions, canEditSubmissions, canDeleteSubmissions);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssignmentForm &&
          other.assignment == this.assignment &&
          other.form == this.form &&
          other.canAddSubmissions == this.canAddSubmissions &&
          other.canViewSubmissions == this.canViewSubmissions &&
          other.canEditSubmissions == this.canEditSubmissions &&
          other.canDeleteSubmissions == this.canDeleteSubmissions);
}

class AssignmentFormsCompanion extends UpdateCompanion<AssignmentForm> {
  final Value<String> assignment;
  final Value<String> form;
  final Value<bool?> canAddSubmissions;
  final Value<bool?> canViewSubmissions;
  final Value<bool?> canEditSubmissions;
  final Value<bool?> canDeleteSubmissions;
  final Value<int> rowid;
  const AssignmentFormsCompanion({
    this.assignment = const Value.absent(),
    this.form = const Value.absent(),
    this.canAddSubmissions = const Value.absent(),
    this.canViewSubmissions = const Value.absent(),
    this.canEditSubmissions = const Value.absent(),
    this.canDeleteSubmissions = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssignmentFormsCompanion.insert({
    required String assignment,
    required String form,
    this.canAddSubmissions = const Value.absent(),
    this.canViewSubmissions = const Value.absent(),
    this.canEditSubmissions = const Value.absent(),
    this.canDeleteSubmissions = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : assignment = Value(assignment),
        form = Value(form);
  static Insertable<AssignmentForm> custom({
    Expression<String>? assignment,
    Expression<String>? form,
    Expression<bool>? canAddSubmissions,
    Expression<bool>? canViewSubmissions,
    Expression<bool>? canEditSubmissions,
    Expression<bool>? canDeleteSubmissions,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (assignment != null) 'assignment': assignment,
      if (form != null) 'form': form,
      if (canAddSubmissions != null) 'can_add_submissions': canAddSubmissions,
      if (canViewSubmissions != null)
        'can_view_submissions': canViewSubmissions,
      if (canEditSubmissions != null)
        'can_edit_submissions': canEditSubmissions,
      if (canDeleteSubmissions != null)
        'can_delete_submissions': canDeleteSubmissions,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssignmentFormsCompanion copyWith(
      {Value<String>? assignment,
      Value<String>? form,
      Value<bool?>? canAddSubmissions,
      Value<bool?>? canViewSubmissions,
      Value<bool?>? canEditSubmissions,
      Value<bool?>? canDeleteSubmissions,
      Value<int>? rowid}) {
    return AssignmentFormsCompanion(
      assignment: assignment ?? this.assignment,
      form: form ?? this.form,
      canAddSubmissions: canAddSubmissions ?? this.canAddSubmissions,
      canViewSubmissions: canViewSubmissions ?? this.canViewSubmissions,
      canEditSubmissions: canEditSubmissions ?? this.canEditSubmissions,
      canDeleteSubmissions: canDeleteSubmissions ?? this.canDeleteSubmissions,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (assignment.present) {
      map['assignment'] = Variable<String>(assignment.value);
    }
    if (form.present) {
      map['form'] = Variable<String>(form.value);
    }
    if (canAddSubmissions.present) {
      map['can_add_submissions'] = Variable<bool>(canAddSubmissions.value);
    }
    if (canViewSubmissions.present) {
      map['can_view_submissions'] = Variable<bool>(canViewSubmissions.value);
    }
    if (canEditSubmissions.present) {
      map['can_edit_submissions'] = Variable<bool>(canEditSubmissions.value);
    }
    if (canDeleteSubmissions.present) {
      map['can_delete_submissions'] =
          Variable<bool>(canDeleteSubmissions.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssignmentFormsCompanion(')
          ..write('assignment: $assignment, ')
          ..write('form: $form, ')
          ..write('canAddSubmissions: $canAddSubmissions, ')
          ..write('canViewSubmissions: $canViewSubmissions, ')
          ..write('canEditSubmissions: $canEditSubmissions, ')
          ..write('canDeleteSubmissions: $canDeleteSubmissions, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FormTemplateVersionsTable extends FormTemplateVersions
    with TableInfo<$FormTemplateVersionsTable, FormTemplateVersion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FormTemplateVersionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _templateMeta =
      const VerificationMeta('template');
  @override
  late final GeneratedColumn<String> template = GeneratedColumn<String>(
      'template', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES form_templates (id)'));
  static const VerificationMeta _versionNumberMeta =
      const VerificationMeta('versionNumber');
  @override
  late final GeneratedColumn<int> versionNumber = GeneratedColumn<int>(
      'version_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<List<Template>, String> fields =
      GeneratedColumn<String>('fields', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<Template>>(
              $FormTemplateVersionsTable.$converterfields);
  @override
  late final GeneratedColumnWithTypeConverter<List<Template>, String> sections =
      GeneratedColumn<String>('sections', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<Template>>(
              $FormTemplateVersionsTable.$convertersections);
  @override
  List<GeneratedColumn> get $columns =>
      [id, template, versionNumber, fields, sections];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'form_template_versions';
  @override
  VerificationContext validateIntegrity(
      Insertable<FormTemplateVersion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('template')) {
      context.handle(_templateMeta,
          template.isAcceptableOrUnknown(data['template']!, _templateMeta));
    } else if (isInserting) {
      context.missing(_templateMeta);
    }
    if (data.containsKey('version_number')) {
      context.handle(
          _versionNumberMeta,
          versionNumber.isAcceptableOrUnknown(
              data['version_number']!, _versionNumberMeta));
    } else if (isInserting) {
      context.missing(_versionNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FormTemplateVersion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FormTemplateVersion(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      template: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}template'])!,
      versionNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version_number'])!,
      fields: $FormTemplateVersionsTable.$converterfields.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}fields'])!),
      sections: $FormTemplateVersionsTable.$convertersections.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}sections'])!),
    );
  }

  @override
  $FormTemplateVersionsTable createAlias(String alias) {
    return $FormTemplateVersionsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<Template>, String> $converterfields =
      const TemplateListConverter();
  static TypeConverter<List<Template>, String> $convertersections =
      const TemplateListConverter();
}

class FormTemplateVersion extends DataClass
    implements Insertable<FormTemplateVersion> {
  final String id;
  final String template;
  final int versionNumber;
  final List<Template> fields;
  final List<Template> sections;
  const FormTemplateVersion(
      {required this.id,
      required this.template,
      required this.versionNumber,
      required this.fields,
      required this.sections});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['template'] = Variable<String>(template);
    map['version_number'] = Variable<int>(versionNumber);
    {
      map['fields'] = Variable<String>(
          $FormTemplateVersionsTable.$converterfields.toSql(fields));
    }
    {
      map['sections'] = Variable<String>(
          $FormTemplateVersionsTable.$convertersections.toSql(sections));
    }
    return map;
  }

  FormTemplateVersionsCompanion toCompanion(bool nullToAbsent) {
    return FormTemplateVersionsCompanion(
      id: Value(id),
      template: Value(template),
      versionNumber: Value(versionNumber),
      fields: Value(fields),
      sections: Value(sections),
    );
  }

  factory FormTemplateVersion.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FormTemplateVersion(
      id: serializer.fromJson<String>(json['id']),
      template: serializer.fromJson<String>(json['template']),
      versionNumber: serializer.fromJson<int>(json['versionNumber']),
      fields: serializer.fromJson<List<Template>>(json['fields']),
      sections: serializer.fromJson<List<Template>>(json['sections']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'template': serializer.toJson<String>(template),
      'versionNumber': serializer.toJson<int>(versionNumber),
      'fields': serializer.toJson<List<Template>>(fields),
      'sections': serializer.toJson<List<Template>>(sections),
    };
  }

  FormTemplateVersion copyWith(
          {String? id,
          String? template,
          int? versionNumber,
          List<Template>? fields,
          List<Template>? sections}) =>
      FormTemplateVersion(
        id: id ?? this.id,
        template: template ?? this.template,
        versionNumber: versionNumber ?? this.versionNumber,
        fields: fields ?? this.fields,
        sections: sections ?? this.sections,
      );
  FormTemplateVersion copyWithCompanion(FormTemplateVersionsCompanion data) {
    return FormTemplateVersion(
      id: data.id.present ? data.id.value : this.id,
      template: data.template.present ? data.template.value : this.template,
      versionNumber: data.versionNumber.present
          ? data.versionNumber.value
          : this.versionNumber,
      fields: data.fields.present ? data.fields.value : this.fields,
      sections: data.sections.present ? data.sections.value : this.sections,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FormTemplateVersion(')
          ..write('id: $id, ')
          ..write('template: $template, ')
          ..write('versionNumber: $versionNumber, ')
          ..write('fields: $fields, ')
          ..write('sections: $sections')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, template, versionNumber, fields, sections);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FormTemplateVersion &&
          other.id == this.id &&
          other.template == this.template &&
          other.versionNumber == this.versionNumber &&
          other.fields == this.fields &&
          other.sections == this.sections);
}

class FormTemplateVersionsCompanion
    extends UpdateCompanion<FormTemplateVersion> {
  final Value<String> id;
  final Value<String> template;
  final Value<int> versionNumber;
  final Value<List<Template>> fields;
  final Value<List<Template>> sections;
  final Value<int> rowid;
  const FormTemplateVersionsCompanion({
    this.id = const Value.absent(),
    this.template = const Value.absent(),
    this.versionNumber = const Value.absent(),
    this.fields = const Value.absent(),
    this.sections = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FormTemplateVersionsCompanion.insert({
    required String id,
    required String template,
    required int versionNumber,
    required List<Template> fields,
    required List<Template> sections,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        template = Value(template),
        versionNumber = Value(versionNumber),
        fields = Value(fields),
        sections = Value(sections);
  static Insertable<FormTemplateVersion> custom({
    Expression<String>? id,
    Expression<String>? template,
    Expression<int>? versionNumber,
    Expression<String>? fields,
    Expression<String>? sections,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (template != null) 'template': template,
      if (versionNumber != null) 'version_number': versionNumber,
      if (fields != null) 'fields': fields,
      if (sections != null) 'sections': sections,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FormTemplateVersionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? template,
      Value<int>? versionNumber,
      Value<List<Template>>? fields,
      Value<List<Template>>? sections,
      Value<int>? rowid}) {
    return FormTemplateVersionsCompanion(
      id: id ?? this.id,
      template: template ?? this.template,
      versionNumber: versionNumber ?? this.versionNumber,
      fields: fields ?? this.fields,
      sections: sections ?? this.sections,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (template.present) {
      map['template'] = Variable<String>(template.value);
    }
    if (versionNumber.present) {
      map['version_number'] = Variable<int>(versionNumber.value);
    }
    if (fields.present) {
      map['fields'] = Variable<String>(
          $FormTemplateVersionsTable.$converterfields.toSql(fields.value));
    }
    if (sections.present) {
      map['sections'] = Variable<String>(
          $FormTemplateVersionsTable.$convertersections.toSql(sections.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FormTemplateVersionsCompanion(')
          ..write('id: $id, ')
          ..write('template: $template, ')
          ..write('versionNumber: $versionNumber, ')
          ..write('fields: $fields, ')
          ..write('sections: $sections, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MetadataSubmissionsTable extends MetadataSubmissions
    with TableInfo<$MetadataSubmissionsTable, MetadataSubmission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetadataSubmissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  @override
  late final GeneratedColumnWithTypeConverter<MetadataResourceType, String>
      resourceType = GeneratedColumn<String>(
              'resource_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MetadataResourceType>(
              $MetadataSubmissionsTable.$converterresourceType);
  static const VerificationMeta _metadataSchemaMeta =
      const VerificationMeta('metadataSchema');
  @override
  late final GeneratedColumn<String> metadataSchema = GeneratedColumn<String>(
      'metadata_schema', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _serialNumberMeta =
      const VerificationMeta('serialNumber');
  @override
  late final GeneratedColumn<int> serialNumber = GeneratedColumn<int>(
      'serial_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _resourceIdMeta =
      const VerificationMeta('resourceId');
  @override
  late final GeneratedColumn<String> resourceId = GeneratedColumn<String>(
      'resource_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      formData = GeneratedColumn<String>('form_data', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>(
              $MetadataSubmissionsTable.$converterformData);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastModifiedByMeta =
      const VerificationMeta('lastModifiedBy');
  @override
  late final GeneratedColumn<String> lastModifiedBy = GeneratedColumn<String>(
      'last_modified_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lastModifiedDate,
        createdDate,
        resourceType,
        metadataSchema,
        serialNumber,
        version,
        resourceId,
        formData,
        createdBy,
        lastModifiedBy
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'metadata_submissions';
  @override
  VerificationContext validateIntegrity(Insertable<MetadataSubmission> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('metadata_schema')) {
      context.handle(
          _metadataSchemaMeta,
          metadataSchema.isAcceptableOrUnknown(
              data['metadata_schema']!, _metadataSchemaMeta));
    } else if (isInserting) {
      context.missing(_metadataSchemaMeta);
    }
    if (data.containsKey('serial_number')) {
      context.handle(
          _serialNumberMeta,
          serialNumber.isAcceptableOrUnknown(
              data['serial_number']!, _serialNumberMeta));
    } else if (isInserting) {
      context.missing(_serialNumberMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('resource_id')) {
      context.handle(
          _resourceIdMeta,
          resourceId.isAcceptableOrUnknown(
              data['resource_id']!, _resourceIdMeta));
    } else if (isInserting) {
      context.missing(_resourceIdMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    if (data.containsKey('last_modified_by')) {
      context.handle(
          _lastModifiedByMeta,
          lastModifiedBy.isAcceptableOrUnknown(
              data['last_modified_by']!, _lastModifiedByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MetadataSubmission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetadataSubmission(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      resourceType: $MetadataSubmissionsTable.$converterresourceType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}resource_type'])!),
      metadataSchema: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}metadata_schema'])!,
      serialNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}serial_number'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
      resourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resource_id'])!,
      formData: $MetadataSubmissionsTable.$converterformData.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}form_data'])),
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
      lastModifiedBy: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_modified_by']),
    );
  }

  @override
  $MetadataSubmissionsTable createAlias(String alias) {
    return $MetadataSubmissionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MetadataResourceType, String, String>
      $converterresourceType =
      const EnumNameConverter(MetadataResourceType.values);
  static TypeConverter<Map<String, dynamic>?, String?> $converterformData =
      const NullAwareMapConverter();
}

class MetadataSubmission extends DataClass
    implements Insertable<MetadataSubmission> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final MetadataResourceType resourceType;
  final String metadataSchema;
  final int serialNumber;
  final int version;
  final String resourceId;
  final Map<String, dynamic>? formData;
  final String? createdBy;
  final String? lastModifiedBy;
  const MetadataSubmission(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      required this.resourceType,
      required this.metadataSchema,
      required this.serialNumber,
      required this.version,
      required this.resourceId,
      this.formData,
      this.createdBy,
      this.lastModifiedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    {
      map['resource_type'] = Variable<String>(
          $MetadataSubmissionsTable.$converterresourceType.toSql(resourceType));
    }
    map['metadata_schema'] = Variable<String>(metadataSchema);
    map['serial_number'] = Variable<int>(serialNumber);
    map['version'] = Variable<int>(version);
    map['resource_id'] = Variable<String>(resourceId);
    if (!nullToAbsent || formData != null) {
      map['form_data'] = Variable<String>(
          $MetadataSubmissionsTable.$converterformData.toSql(formData));
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || lastModifiedBy != null) {
      map['last_modified_by'] = Variable<String>(lastModifiedBy);
    }
    return map;
  }

  MetadataSubmissionsCompanion toCompanion(bool nullToAbsent) {
    return MetadataSubmissionsCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      resourceType: Value(resourceType),
      metadataSchema: Value(metadataSchema),
      serialNumber: Value(serialNumber),
      version: Value(version),
      resourceId: Value(resourceId),
      formData: formData == null && nullToAbsent
          ? const Value.absent()
          : Value(formData),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      lastModifiedBy: lastModifiedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedBy),
    );
  }

  factory MetadataSubmission.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetadataSubmission(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      resourceType: $MetadataSubmissionsTable.$converterresourceType
          .fromJson(serializer.fromJson<String>(json['resourceType'])),
      metadataSchema: serializer.fromJson<String>(json['metadataSchema']),
      serialNumber: serializer.fromJson<int>(json['serialNumber']),
      version: serializer.fromJson<int>(json['version']),
      resourceId: serializer.fromJson<String>(json['resourceId']),
      formData: serializer.fromJson<Map<String, dynamic>?>(json['formData']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      lastModifiedBy: serializer.fromJson<String?>(json['lastModifiedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'resourceType': serializer.toJson<String>($MetadataSubmissionsTable
          .$converterresourceType
          .toJson(resourceType)),
      'metadataSchema': serializer.toJson<String>(metadataSchema),
      'serialNumber': serializer.toJson<int>(serialNumber),
      'version': serializer.toJson<int>(version),
      'resourceId': serializer.toJson<String>(resourceId),
      'formData': serializer.toJson<Map<String, dynamic>?>(formData),
      'createdBy': serializer.toJson<String?>(createdBy),
      'lastModifiedBy': serializer.toJson<String?>(lastModifiedBy),
    };
  }

  MetadataSubmission copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          MetadataResourceType? resourceType,
          String? metadataSchema,
          int? serialNumber,
          int? version,
          String? resourceId,
          Value<Map<String, dynamic>?> formData = const Value.absent(),
          Value<String?> createdBy = const Value.absent(),
          Value<String?> lastModifiedBy = const Value.absent()}) =>
      MetadataSubmission(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        resourceType: resourceType ?? this.resourceType,
        metadataSchema: metadataSchema ?? this.metadataSchema,
        serialNumber: serialNumber ?? this.serialNumber,
        version: version ?? this.version,
        resourceId: resourceId ?? this.resourceId,
        formData: formData.present ? formData.value : this.formData,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
        lastModifiedBy:
            lastModifiedBy.present ? lastModifiedBy.value : this.lastModifiedBy,
      );
  MetadataSubmission copyWithCompanion(MetadataSubmissionsCompanion data) {
    return MetadataSubmission(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      resourceType: data.resourceType.present
          ? data.resourceType.value
          : this.resourceType,
      metadataSchema: data.metadataSchema.present
          ? data.metadataSchema.value
          : this.metadataSchema,
      serialNumber: data.serialNumber.present
          ? data.serialNumber.value
          : this.serialNumber,
      version: data.version.present ? data.version.value : this.version,
      resourceId:
          data.resourceId.present ? data.resourceId.value : this.resourceId,
      formData: data.formData.present ? data.formData.value : this.formData,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      lastModifiedBy: data.lastModifiedBy.present
          ? data.lastModifiedBy.value
          : this.lastModifiedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetadataSubmission(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('resourceType: $resourceType, ')
          ..write('metadataSchema: $metadataSchema, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('version: $version, ')
          ..write('resourceId: $resourceId, ')
          ..write('formData: $formData, ')
          ..write('createdBy: $createdBy, ')
          ..write('lastModifiedBy: $lastModifiedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      lastModifiedDate,
      createdDate,
      resourceType,
      metadataSchema,
      serialNumber,
      version,
      resourceId,
      formData,
      createdBy,
      lastModifiedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetadataSubmission &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.resourceType == this.resourceType &&
          other.metadataSchema == this.metadataSchema &&
          other.serialNumber == this.serialNumber &&
          other.version == this.version &&
          other.resourceId == this.resourceId &&
          other.formData == this.formData &&
          other.createdBy == this.createdBy &&
          other.lastModifiedBy == this.lastModifiedBy);
}

class MetadataSubmissionsCompanion extends UpdateCompanion<MetadataSubmission> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<MetadataResourceType> resourceType;
  final Value<String> metadataSchema;
  final Value<int> serialNumber;
  final Value<int> version;
  final Value<String> resourceId;
  final Value<Map<String, dynamic>?> formData;
  final Value<String?> createdBy;
  final Value<String?> lastModifiedBy;
  final Value<int> rowid;
  const MetadataSubmissionsCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.resourceType = const Value.absent(),
    this.metadataSchema = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.version = const Value.absent(),
    this.resourceId = const Value.absent(),
    this.formData = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.lastModifiedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MetadataSubmissionsCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    required MetadataResourceType resourceType,
    required String metadataSchema,
    required int serialNumber,
    required int version,
    required String resourceId,
    this.formData = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.lastModifiedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        resourceType = Value(resourceType),
        metadataSchema = Value(metadataSchema),
        serialNumber = Value(serialNumber),
        version = Value(version),
        resourceId = Value(resourceId);
  static Insertable<MetadataSubmission> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? resourceType,
    Expression<String>? metadataSchema,
    Expression<int>? serialNumber,
    Expression<int>? version,
    Expression<String>? resourceId,
    Expression<String>? formData,
    Expression<String>? createdBy,
    Expression<String>? lastModifiedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (resourceType != null) 'resource_type': resourceType,
      if (metadataSchema != null) 'metadata_schema': metadataSchema,
      if (serialNumber != null) 'serial_number': serialNumber,
      if (version != null) 'version': version,
      if (resourceId != null) 'resource_id': resourceId,
      if (formData != null) 'form_data': formData,
      if (createdBy != null) 'created_by': createdBy,
      if (lastModifiedBy != null) 'last_modified_by': lastModifiedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MetadataSubmissionsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<MetadataResourceType>? resourceType,
      Value<String>? metadataSchema,
      Value<int>? serialNumber,
      Value<int>? version,
      Value<String>? resourceId,
      Value<Map<String, dynamic>?>? formData,
      Value<String?>? createdBy,
      Value<String?>? lastModifiedBy,
      Value<int>? rowid}) {
    return MetadataSubmissionsCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      resourceType: resourceType ?? this.resourceType,
      metadataSchema: metadataSchema ?? this.metadataSchema,
      serialNumber: serialNumber ?? this.serialNumber,
      version: version ?? this.version,
      resourceId: resourceId ?? this.resourceId,
      formData: formData ?? this.formData,
      createdBy: createdBy ?? this.createdBy,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (resourceType.present) {
      map['resource_type'] = Variable<String>($MetadataSubmissionsTable
          .$converterresourceType
          .toSql(resourceType.value));
    }
    if (metadataSchema.present) {
      map['metadata_schema'] = Variable<String>(metadataSchema.value);
    }
    if (serialNumber.present) {
      map['serial_number'] = Variable<int>(serialNumber.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (resourceId.present) {
      map['resource_id'] = Variable<String>(resourceId.value);
    }
    if (formData.present) {
      map['form_data'] = Variable<String>(
          $MetadataSubmissionsTable.$converterformData.toSql(formData.value));
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (lastModifiedBy.present) {
      map['last_modified_by'] = Variable<String>(lastModifiedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetadataSubmissionsCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('resourceType: $resourceType, ')
          ..write('metadataSchema: $metadataSchema, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('version: $version, ')
          ..write('resourceId: $resourceId, ')
          ..write('formData: $formData, ')
          ..write('createdBy: $createdBy, ')
          ..write('lastModifiedBy: $lastModifiedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DataInstancesTable extends DataInstances
    with TableInfo<$DataInstancesTable, DataInstance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DataInstancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _deletedMeta =
      const VerificationMeta('deleted');
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
      'deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("deleted" IN (0, 1))'),
      clientDefault: () => false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _formTemplateMeta =
      const VerificationMeta('formTemplate');
  @override
  late final GeneratedColumn<String> formTemplate = GeneratedColumn<String>(
      'form_template', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES form_templates (id)'));
  static const VerificationMeta _templateVersionMeta =
      const VerificationMeta('templateVersion');
  @override
  late final GeneratedColumn<String> templateVersion = GeneratedColumn<String>(
      'template_version', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES form_template_versions (id)'));
  static const VerificationMeta _assignmentMeta =
      const VerificationMeta('assignment');
  @override
  late final GeneratedColumn<String> assignment = GeneratedColumn<String>(
      'assignment', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES assignments (id)'));
  static const VerificationMeta _startEntryTimeMeta =
      const VerificationMeta('startEntryTime');
  @override
  late final GeneratedColumn<DateTime> startEntryTime =
      GeneratedColumn<DateTime>('start_entry_time', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _finishedEntryTimeMeta =
      const VerificationMeta('finishedEntryTime');
  @override
  late final GeneratedColumn<DateTime> finishedEntryTime =
      GeneratedColumn<DateTime>('finished_entry_time', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      formData = GeneratedColumn<String>('form_data', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>(
              $DataInstancesTable.$converterformData);
  static const VerificationMeta _updatedAtClientMeta =
      const VerificationMeta('updatedAtClient');
  @override
  late final GeneratedColumn<DateTime> updatedAtClient =
      GeneratedColumn<DateTime>('updated_at_client', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<InstanceSyncStatus, String>
      syncState = GeneratedColumn<String>('sync_state', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<InstanceSyncStatus>(
              $DataInstancesTable.$convertersyncState);
  static const VerificationMeta _lastSyncDateMeta =
      const VerificationMeta('lastSyncDate');
  @override
  late final GeneratedColumn<DateTime> lastSyncDate = GeneratedColumn<DateTime>(
      'last_sync_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastSyncMessageMeta =
      const VerificationMeta('lastSyncMessage');
  @override
  late final GeneratedColumn<String> lastSyncMessage = GeneratedColumn<String>(
      'last_sync_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isToUpdateMeta =
      const VerificationMeta('isToUpdate');
  @override
  late final GeneratedColumn<bool> isToUpdate = GeneratedColumn<bool>(
      'is_to_update', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_to_update" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lastModifiedDate,
        createdDate,
        deleted,
        deletedAt,
        formTemplate,
        templateVersion,
        assignment,
        startEntryTime,
        finishedEntryTime,
        formData,
        updatedAtClient,
        syncState,
        lastSyncDate,
        lastSyncMessage,
        isToUpdate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'data_instances';
  @override
  VerificationContext validateIntegrity(Insertable<DataInstance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('deleted')) {
      context.handle(_deletedMeta,
          deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('form_template')) {
      context.handle(
          _formTemplateMeta,
          formTemplate.isAcceptableOrUnknown(
              data['form_template']!, _formTemplateMeta));
    } else if (isInserting) {
      context.missing(_formTemplateMeta);
    }
    if (data.containsKey('template_version')) {
      context.handle(
          _templateVersionMeta,
          templateVersion.isAcceptableOrUnknown(
              data['template_version']!, _templateVersionMeta));
    } else if (isInserting) {
      context.missing(_templateVersionMeta);
    }
    if (data.containsKey('assignment')) {
      context.handle(
          _assignmentMeta,
          assignment.isAcceptableOrUnknown(
              data['assignment']!, _assignmentMeta));
    }
    if (data.containsKey('start_entry_time')) {
      context.handle(
          _startEntryTimeMeta,
          startEntryTime.isAcceptableOrUnknown(
              data['start_entry_time']!, _startEntryTimeMeta));
    }
    if (data.containsKey('finished_entry_time')) {
      context.handle(
          _finishedEntryTimeMeta,
          finishedEntryTime.isAcceptableOrUnknown(
              data['finished_entry_time']!, _finishedEntryTimeMeta));
    }
    if (data.containsKey('updated_at_client')) {
      context.handle(
          _updatedAtClientMeta,
          updatedAtClient.isAcceptableOrUnknown(
              data['updated_at_client']!, _updatedAtClientMeta));
    }
    if (data.containsKey('last_sync_date')) {
      context.handle(
          _lastSyncDateMeta,
          lastSyncDate.isAcceptableOrUnknown(
              data['last_sync_date']!, _lastSyncDateMeta));
    }
    if (data.containsKey('last_sync_message')) {
      context.handle(
          _lastSyncMessageMeta,
          lastSyncMessage.isAcceptableOrUnknown(
              data['last_sync_message']!, _lastSyncMessageMeta));
    }
    if (data.containsKey('is_to_update')) {
      context.handle(
          _isToUpdateMeta,
          isToUpdate.isAcceptableOrUnknown(
              data['is_to_update']!, _isToUpdateMeta));
    } else if (isInserting) {
      context.missing(_isToUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DataInstance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DataInstance(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      deleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}deleted'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      formTemplate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}form_template'])!,
      templateVersion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}template_version'])!,
      assignment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}assignment']),
      startEntryTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}start_entry_time'])!,
      finishedEntryTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}finished_entry_time']),
      formData: $DataInstancesTable.$converterformData.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}form_data'])),
      updatedAtClient: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}updated_at_client']),
      syncState: $DataInstancesTable.$convertersyncState.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}sync_state'])!),
      lastSyncDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_sync_date']),
      lastSyncMessage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_sync_message']),
      isToUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_to_update'])!,
    );
  }

  @override
  $DataInstancesTable createAlias(String alias) {
    return $DataInstancesTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?> $converterformData =
      const NullAwareMapConverter();
  static JsonTypeConverter2<InstanceSyncStatus, String, String>
      $convertersyncState = const EnumNameConverter(InstanceSyncStatus.values);
}

class DataInstance extends DataClass implements Insertable<DataInstance> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final bool deleted;
  final DateTime? deletedAt;

  /// analogous to program
  final String formTemplate;
  final String templateVersion;

  /// analogous to enrollment
  final String? assignment;
  final DateTime startEntryTime;
  final DateTime? finishedEntryTime;
  final Map<String, dynamic>? formData;
  final DateTime? updatedAtClient;
  final InstanceSyncStatus syncState;
  final DateTime? lastSyncDate;
  final String? lastSyncMessage;

  /// is already synced to server
  final bool isToUpdate;
  const DataInstance(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      required this.deleted,
      this.deletedAt,
      required this.formTemplate,
      required this.templateVersion,
      this.assignment,
      required this.startEntryTime,
      this.finishedEntryTime,
      this.formData,
      this.updatedAtClient,
      required this.syncState,
      this.lastSyncDate,
      this.lastSyncMessage,
      required this.isToUpdate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    map['deleted'] = Variable<bool>(deleted);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['form_template'] = Variable<String>(formTemplate);
    map['template_version'] = Variable<String>(templateVersion);
    if (!nullToAbsent || assignment != null) {
      map['assignment'] = Variable<String>(assignment);
    }
    map['start_entry_time'] = Variable<DateTime>(startEntryTime);
    if (!nullToAbsent || finishedEntryTime != null) {
      map['finished_entry_time'] = Variable<DateTime>(finishedEntryTime);
    }
    if (!nullToAbsent || formData != null) {
      map['form_data'] = Variable<String>(
          $DataInstancesTable.$converterformData.toSql(formData));
    }
    if (!nullToAbsent || updatedAtClient != null) {
      map['updated_at_client'] = Variable<DateTime>(updatedAtClient);
    }
    {
      map['sync_state'] = Variable<String>(
          $DataInstancesTable.$convertersyncState.toSql(syncState));
    }
    if (!nullToAbsent || lastSyncDate != null) {
      map['last_sync_date'] = Variable<DateTime>(lastSyncDate);
    }
    if (!nullToAbsent || lastSyncMessage != null) {
      map['last_sync_message'] = Variable<String>(lastSyncMessage);
    }
    map['is_to_update'] = Variable<bool>(isToUpdate);
    return map;
  }

  DataInstancesCompanion toCompanion(bool nullToAbsent) {
    return DataInstancesCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      deleted: Value(deleted),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      formTemplate: Value(formTemplate),
      templateVersion: Value(templateVersion),
      assignment: assignment == null && nullToAbsent
          ? const Value.absent()
          : Value(assignment),
      startEntryTime: Value(startEntryTime),
      finishedEntryTime: finishedEntryTime == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedEntryTime),
      formData: formData == null && nullToAbsent
          ? const Value.absent()
          : Value(formData),
      updatedAtClient: updatedAtClient == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAtClient),
      syncState: Value(syncState),
      lastSyncDate: lastSyncDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncDate),
      lastSyncMessage: lastSyncMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncMessage),
      isToUpdate: Value(isToUpdate),
    );
  }

  factory DataInstance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DataInstance(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      formTemplate: serializer.fromJson<String>(json['formTemplate']),
      templateVersion: serializer.fromJson<String>(json['templateVersion']),
      assignment: serializer.fromJson<String?>(json['assignment']),
      startEntryTime: serializer.fromJson<DateTime>(json['startEntryTime']),
      finishedEntryTime:
          serializer.fromJson<DateTime?>(json['finishedEntryTime']),
      formData: serializer.fromJson<Map<String, dynamic>?>(json['formData']),
      updatedAtClient: serializer.fromJson<DateTime?>(json['updatedAtClient']),
      syncState: $DataInstancesTable.$convertersyncState
          .fromJson(serializer.fromJson<String>(json['syncState'])),
      lastSyncDate: serializer.fromJson<DateTime?>(json['lastSyncDate']),
      lastSyncMessage: serializer.fromJson<String?>(json['lastSyncMessage']),
      isToUpdate: serializer.fromJson<bool>(json['isToUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'deleted': serializer.toJson<bool>(deleted),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'formTemplate': serializer.toJson<String>(formTemplate),
      'templateVersion': serializer.toJson<String>(templateVersion),
      'assignment': serializer.toJson<String?>(assignment),
      'startEntryTime': serializer.toJson<DateTime>(startEntryTime),
      'finishedEntryTime': serializer.toJson<DateTime?>(finishedEntryTime),
      'formData': serializer.toJson<Map<String, dynamic>?>(formData),
      'updatedAtClient': serializer.toJson<DateTime?>(updatedAtClient),
      'syncState': serializer.toJson<String>(
          $DataInstancesTable.$convertersyncState.toJson(syncState)),
      'lastSyncDate': serializer.toJson<DateTime?>(lastSyncDate),
      'lastSyncMessage': serializer.toJson<String?>(lastSyncMessage),
      'isToUpdate': serializer.toJson<bool>(isToUpdate),
    };
  }

  DataInstance copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          bool? deleted,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? formTemplate,
          String? templateVersion,
          Value<String?> assignment = const Value.absent(),
          DateTime? startEntryTime,
          Value<DateTime?> finishedEntryTime = const Value.absent(),
          Value<Map<String, dynamic>?> formData = const Value.absent(),
          Value<DateTime?> updatedAtClient = const Value.absent(),
          InstanceSyncStatus? syncState,
          Value<DateTime?> lastSyncDate = const Value.absent(),
          Value<String?> lastSyncMessage = const Value.absent(),
          bool? isToUpdate}) =>
      DataInstance(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        deleted: deleted ?? this.deleted,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        formTemplate: formTemplate ?? this.formTemplate,
        templateVersion: templateVersion ?? this.templateVersion,
        assignment: assignment.present ? assignment.value : this.assignment,
        startEntryTime: startEntryTime ?? this.startEntryTime,
        finishedEntryTime: finishedEntryTime.present
            ? finishedEntryTime.value
            : this.finishedEntryTime,
        formData: formData.present ? formData.value : this.formData,
        updatedAtClient: updatedAtClient.present
            ? updatedAtClient.value
            : this.updatedAtClient,
        syncState: syncState ?? this.syncState,
        lastSyncDate:
            lastSyncDate.present ? lastSyncDate.value : this.lastSyncDate,
        lastSyncMessage: lastSyncMessage.present
            ? lastSyncMessage.value
            : this.lastSyncMessage,
        isToUpdate: isToUpdate ?? this.isToUpdate,
      );
  DataInstance copyWithCompanion(DataInstancesCompanion data) {
    return DataInstance(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      formTemplate: data.formTemplate.present
          ? data.formTemplate.value
          : this.formTemplate,
      templateVersion: data.templateVersion.present
          ? data.templateVersion.value
          : this.templateVersion,
      assignment:
          data.assignment.present ? data.assignment.value : this.assignment,
      startEntryTime: data.startEntryTime.present
          ? data.startEntryTime.value
          : this.startEntryTime,
      finishedEntryTime: data.finishedEntryTime.present
          ? data.finishedEntryTime.value
          : this.finishedEntryTime,
      formData: data.formData.present ? data.formData.value : this.formData,
      updatedAtClient: data.updatedAtClient.present
          ? data.updatedAtClient.value
          : this.updatedAtClient,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      lastSyncDate: data.lastSyncDate.present
          ? data.lastSyncDate.value
          : this.lastSyncDate,
      lastSyncMessage: data.lastSyncMessage.present
          ? data.lastSyncMessage.value
          : this.lastSyncMessage,
      isToUpdate:
          data.isToUpdate.present ? data.isToUpdate.value : this.isToUpdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DataInstance(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('deleted: $deleted, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('formTemplate: $formTemplate, ')
          ..write('templateVersion: $templateVersion, ')
          ..write('assignment: $assignment, ')
          ..write('startEntryTime: $startEntryTime, ')
          ..write('finishedEntryTime: $finishedEntryTime, ')
          ..write('formData: $formData, ')
          ..write('updatedAtClient: $updatedAtClient, ')
          ..write('syncState: $syncState, ')
          ..write('lastSyncDate: $lastSyncDate, ')
          ..write('lastSyncMessage: $lastSyncMessage, ')
          ..write('isToUpdate: $isToUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      lastModifiedDate,
      createdDate,
      deleted,
      deletedAt,
      formTemplate,
      templateVersion,
      assignment,
      startEntryTime,
      finishedEntryTime,
      formData,
      updatedAtClient,
      syncState,
      lastSyncDate,
      lastSyncMessage,
      isToUpdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DataInstance &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.deleted == this.deleted &&
          other.deletedAt == this.deletedAt &&
          other.formTemplate == this.formTemplate &&
          other.templateVersion == this.templateVersion &&
          other.assignment == this.assignment &&
          other.startEntryTime == this.startEntryTime &&
          other.finishedEntryTime == this.finishedEntryTime &&
          other.formData == this.formData &&
          other.updatedAtClient == this.updatedAtClient &&
          other.syncState == this.syncState &&
          other.lastSyncDate == this.lastSyncDate &&
          other.lastSyncMessage == this.lastSyncMessage &&
          other.isToUpdate == this.isToUpdate);
}

class DataInstancesCompanion extends UpdateCompanion<DataInstance> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<bool> deleted;
  final Value<DateTime?> deletedAt;
  final Value<String> formTemplate;
  final Value<String> templateVersion;
  final Value<String?> assignment;
  final Value<DateTime> startEntryTime;
  final Value<DateTime?> finishedEntryTime;
  final Value<Map<String, dynamic>?> formData;
  final Value<DateTime?> updatedAtClient;
  final Value<InstanceSyncStatus> syncState;
  final Value<DateTime?> lastSyncDate;
  final Value<String?> lastSyncMessage;
  final Value<bool> isToUpdate;
  final Value<int> rowid;
  const DataInstancesCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.deleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.formTemplate = const Value.absent(),
    this.templateVersion = const Value.absent(),
    this.assignment = const Value.absent(),
    this.startEntryTime = const Value.absent(),
    this.finishedEntryTime = const Value.absent(),
    this.formData = const Value.absent(),
    this.updatedAtClient = const Value.absent(),
    this.syncState = const Value.absent(),
    this.lastSyncDate = const Value.absent(),
    this.lastSyncMessage = const Value.absent(),
    this.isToUpdate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DataInstancesCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.deleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String formTemplate,
    required String templateVersion,
    this.assignment = const Value.absent(),
    this.startEntryTime = const Value.absent(),
    this.finishedEntryTime = const Value.absent(),
    this.formData = const Value.absent(),
    this.updatedAtClient = const Value.absent(),
    required InstanceSyncStatus syncState,
    this.lastSyncDate = const Value.absent(),
    this.lastSyncMessage = const Value.absent(),
    required bool isToUpdate,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        formTemplate = Value(formTemplate),
        templateVersion = Value(templateVersion),
        syncState = Value(syncState),
        isToUpdate = Value(isToUpdate);
  static Insertable<DataInstance> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<bool>? deleted,
    Expression<DateTime>? deletedAt,
    Expression<String>? formTemplate,
    Expression<String>? templateVersion,
    Expression<String>? assignment,
    Expression<DateTime>? startEntryTime,
    Expression<DateTime>? finishedEntryTime,
    Expression<String>? formData,
    Expression<DateTime>? updatedAtClient,
    Expression<String>? syncState,
    Expression<DateTime>? lastSyncDate,
    Expression<String>? lastSyncMessage,
    Expression<bool>? isToUpdate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (deleted != null) 'deleted': deleted,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (formTemplate != null) 'form_template': formTemplate,
      if (templateVersion != null) 'template_version': templateVersion,
      if (assignment != null) 'assignment': assignment,
      if (startEntryTime != null) 'start_entry_time': startEntryTime,
      if (finishedEntryTime != null) 'finished_entry_time': finishedEntryTime,
      if (formData != null) 'form_data': formData,
      if (updatedAtClient != null) 'updated_at_client': updatedAtClient,
      if (syncState != null) 'sync_state': syncState,
      if (lastSyncDate != null) 'last_sync_date': lastSyncDate,
      if (lastSyncMessage != null) 'last_sync_message': lastSyncMessage,
      if (isToUpdate != null) 'is_to_update': isToUpdate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DataInstancesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<bool>? deleted,
      Value<DateTime?>? deletedAt,
      Value<String>? formTemplate,
      Value<String>? templateVersion,
      Value<String?>? assignment,
      Value<DateTime>? startEntryTime,
      Value<DateTime?>? finishedEntryTime,
      Value<Map<String, dynamic>?>? formData,
      Value<DateTime?>? updatedAtClient,
      Value<InstanceSyncStatus>? syncState,
      Value<DateTime?>? lastSyncDate,
      Value<String?>? lastSyncMessage,
      Value<bool>? isToUpdate,
      Value<int>? rowid}) {
    return DataInstancesCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      deleted: deleted ?? this.deleted,
      deletedAt: deletedAt ?? this.deletedAt,
      formTemplate: formTemplate ?? this.formTemplate,
      templateVersion: templateVersion ?? this.templateVersion,
      assignment: assignment ?? this.assignment,
      startEntryTime: startEntryTime ?? this.startEntryTime,
      finishedEntryTime: finishedEntryTime ?? this.finishedEntryTime,
      formData: formData ?? this.formData,
      updatedAtClient: updatedAtClient ?? this.updatedAtClient,
      syncState: syncState ?? this.syncState,
      lastSyncDate: lastSyncDate ?? this.lastSyncDate,
      lastSyncMessage: lastSyncMessage ?? this.lastSyncMessage,
      isToUpdate: isToUpdate ?? this.isToUpdate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (formTemplate.present) {
      map['form_template'] = Variable<String>(formTemplate.value);
    }
    if (templateVersion.present) {
      map['template_version'] = Variable<String>(templateVersion.value);
    }
    if (assignment.present) {
      map['assignment'] = Variable<String>(assignment.value);
    }
    if (startEntryTime.present) {
      map['start_entry_time'] = Variable<DateTime>(startEntryTime.value);
    }
    if (finishedEntryTime.present) {
      map['finished_entry_time'] = Variable<DateTime>(finishedEntryTime.value);
    }
    if (formData.present) {
      map['form_data'] = Variable<String>(
          $DataInstancesTable.$converterformData.toSql(formData.value));
    }
    if (updatedAtClient.present) {
      map['updated_at_client'] = Variable<DateTime>(updatedAtClient.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(
          $DataInstancesTable.$convertersyncState.toSql(syncState.value));
    }
    if (lastSyncDate.present) {
      map['last_sync_date'] = Variable<DateTime>(lastSyncDate.value);
    }
    if (lastSyncMessage.present) {
      map['last_sync_message'] = Variable<String>(lastSyncMessage.value);
    }
    if (isToUpdate.present) {
      map['is_to_update'] = Variable<bool>(isToUpdate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DataInstancesCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('deleted: $deleted, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('formTemplate: $formTemplate, ')
          ..write('templateVersion: $templateVersion, ')
          ..write('assignment: $assignment, ')
          ..write('startEntryTime: $startEntryTime, ')
          ..write('finishedEntryTime: $finishedEntryTime, ')
          ..write('formData: $formData, ')
          ..write('updatedAtClient: $updatedAtClient, ')
          ..write('syncState: $syncState, ')
          ..write('lastSyncDate: $lastSyncDate, ')
          ..write('lastSyncMessage: $lastSyncMessage, ')
          ..write('isToUpdate: $isToUpdate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RepeatInstancesTable extends RepeatInstances
    with TableInfo<$RepeatInstancesTable, RepeatInstance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepeatInstancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _templatePathMeta =
      const VerificationMeta('templatePath');
  @override
  late final GeneratedColumn<String> repeatPath = GeneratedColumn<String>(
      'template_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _submissionMeta =
      const VerificationMeta('submission');
  @override
  late final GeneratedColumn<String> submission = GeneratedColumn<String>(
      'submission', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES data_instances (id)'));
  static const VerificationMeta _parentMeta = const VerificationMeta('parent');
  @override
  late final GeneratedColumn<String> parent = GeneratedColumn<String>(
      'parent', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES repeat_instances (id)'));
  static const VerificationMeta _repeatIndexMeta =
      const VerificationMeta('repeatIndex');
  @override
  late final GeneratedColumn<int> repeatIndex = GeneratedColumn<int>(
      'repeat_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lastModifiedDate,
        createdDate,
        repeatPath,
        submission,
        parent,
        repeatIndex
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repeat_instances';
  @override
  VerificationContext validateIntegrity(Insertable<RepeatInstance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('template_path')) {
      context.handle(
          _templatePathMeta,
          repeatPath.isAcceptableOrUnknown(
              data['template_path']!, _templatePathMeta));
    } else if (isInserting) {
      context.missing(_templatePathMeta);
    }
    if (data.containsKey('submission')) {
      context.handle(
          _submissionMeta,
          submission.isAcceptableOrUnknown(
              data['submission']!, _submissionMeta));
    } else if (isInserting) {
      context.missing(_submissionMeta);
    }
    if (data.containsKey('parent')) {
      context.handle(_parentMeta,
          parent.isAcceptableOrUnknown(data['parent']!, _parentMeta));
    }
    if (data.containsKey('repeat_index')) {
      context.handle(
          _repeatIndexMeta,
          repeatIndex.isAcceptableOrUnknown(
              data['repeat_index']!, _repeatIndexMeta));
    } else if (isInserting) {
      context.missing(_repeatIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepeatInstance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepeatInstance(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      templatePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}template_path'])!,
      submission: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}submission'])!,
      parent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent']),
      repeatIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}repeat_index'])!,
    );
  }

  @override
  $RepeatInstancesTable createAlias(String alias) {
    return $RepeatInstancesTable(attachedDatabase, alias);
  }
}

class RepeatInstance extends DataClass implements Insertable<RepeatInstance> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;

  /// Path of the Repeat in the FormTemplate (non-null)
  final String templatePath;
  final String submission;

  /// reference to nearest parent RepeatInstance (nullable)
  final String? parent;

  /// Repeat index for order and identity (non-null)
  final int repeatIndex;
  const RepeatInstance(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      required this.templatePath,
      required this.submission,
      this.parent,
      required this.repeatIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    map['template_path'] = Variable<String>(templatePath);
    map['submission'] = Variable<String>(submission);
    if (!nullToAbsent || parent != null) {
      map['parent'] = Variable<String>(parent);
    }
    map['repeat_index'] = Variable<int>(repeatIndex);
    return map;
  }

  RepeatInstancesCompanion toCompanion(bool nullToAbsent) {
    return RepeatInstancesCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      templatePath: Value(templatePath),
      submission: Value(submission),
      parent:
          parent == null && nullToAbsent ? const Value.absent() : Value(parent),
      repeatIndex: Value(repeatIndex),
    );
  }

  factory RepeatInstance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepeatInstance(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      templatePath: serializer.fromJson<String>(json['templatePath']),
      submission: serializer.fromJson<String>(json['submission']),
      parent: serializer.fromJson<String?>(json['parent']),
      repeatIndex: serializer.fromJson<int>(json['repeatIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'templatePath': serializer.toJson<String>(templatePath),
      'submission': serializer.toJson<String>(submission),
      'parent': serializer.toJson<String?>(parent),
      'repeatIndex': serializer.toJson<int>(repeatIndex),
    };
  }

  RepeatInstance copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          String? templatePath,
          String? submission,
          Value<String?> parent = const Value.absent(),
          int? repeatIndex}) =>
      RepeatInstance(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        templatePath: templatePath ?? this.templatePath,
        submission: submission ?? this.submission,
        parent: parent.present ? parent.value : this.parent,
        repeatIndex: repeatIndex ?? this.repeatIndex,
      );
  RepeatInstance copyWithCompanion(RepeatInstancesCompanion data) {
    return RepeatInstance(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      templatePath: data.templatePath.present
          ? data.templatePath.value
          : this.templatePath,
      submission:
          data.submission.present ? data.submission.value : this.submission,
      parent: data.parent.present ? data.parent.value : this.parent,
      repeatIndex:
          data.repeatIndex.present ? data.repeatIndex.value : this.repeatIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepeatInstance(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('templatePath: $templatePath, ')
          ..write('submission: $submission, ')
          ..write('parent: $parent, ')
          ..write('repeatIndex: $repeatIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastModifiedDate, createdDate,
      templatePath, submission, parent, repeatIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepeatInstance &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.templatePath == this.templatePath &&
          other.submission == this.submission &&
          other.parent == this.parent &&
          other.repeatIndex == this.repeatIndex);
}

class RepeatInstancesCompanion extends UpdateCompanion<RepeatInstance> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<String> templatePath;
  final Value<String> submission;
  final Value<String?> parent;
  final Value<int> repeatIndex;
  final Value<int> rowid;
  const RepeatInstancesCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.templatePath = const Value.absent(),
    this.submission = const Value.absent(),
    this.parent = const Value.absent(),
    this.repeatIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RepeatInstancesCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    required String templatePath,
    required String submission,
    this.parent = const Value.absent(),
    required int repeatIndex,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        templatePath = Value(templatePath),
        submission = Value(submission),
        repeatIndex = Value(repeatIndex);
  static Insertable<RepeatInstance> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? templatePath,
    Expression<String>? submission,
    Expression<String>? parent,
    Expression<int>? repeatIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (templatePath != null) 'template_path': templatePath,
      if (submission != null) 'submission': submission,
      if (parent != null) 'parent': parent,
      if (repeatIndex != null) 'repeat_index': repeatIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RepeatInstancesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<String>? templatePath,
      Value<String>? submission,
      Value<String?>? parent,
      Value<int>? repeatIndex,
      Value<int>? rowid}) {
    return RepeatInstancesCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      templatePath: templatePath ?? this.templatePath,
      submission: submission ?? this.submission,
      parent: parent ?? this.parent,
      repeatIndex: repeatIndex ?? this.repeatIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (templatePath.present) {
      map['template_path'] = Variable<String>(templatePath.value);
    }
    if (submission.present) {
      map['submission'] = Variable<String>(submission.value);
    }
    if (parent.present) {
      map['parent'] = Variable<String>(parent.value);
    }
    if (repeatIndex.present) {
      map['repeat_index'] = Variable<int>(repeatIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepeatInstancesCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('templatePath: $templatePath, ')
          ..write('submission: $submission, ')
          ..write('parent: $parent, ')
          ..write('repeatIndex: $repeatIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DataOptionSetsTable extends DataOptionSets
    with TableInfo<$DataOptionSetsTable, DataOptionSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DataOptionSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      label = GeneratedColumn<String>('label', aliasedName, true,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '{}')
          .withConverter<Map<String, dynamic>?>(
              $DataOptionSetsTable.$converterlabel);
  @override
  late final GeneratedColumnWithTypeConverter<List<Translation>, String>
      translations = GeneratedColumn<String>('translations', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '[]')
          .withConverter<List<Translation>>(
              $DataOptionSetsTable.$convertertranslations);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lastModifiedDate,
        createdDate,
        displayName,
        label,
        translations,
        name,
        code
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'data_option_sets';
  @override
  VerificationContext validateIntegrity(Insertable<DataOptionSet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DataOptionSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DataOptionSet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name']),
      label: $DataOptionSetsTable.$converterlabel.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])),
      translations: $DataOptionSetsTable.$convertertranslations.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}translations'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
    );
  }

  @override
  $DataOptionSetsTable createAlias(String alias) {
    return $DataOptionSetsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?> $converterlabel =
      const NullAwareMapConverter();
  static TypeConverter<List<Translation>, String> $convertertranslations =
      const TranslationConverter();
}

class DataOptionSet extends DataClass implements Insertable<DataOptionSet> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final String? displayName;
  final Map<String, dynamic>? label;
  final List<Translation> translations;
  final String name;
  final String? code;
  const DataOptionSet(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      this.displayName,
      this.label,
      required this.translations,
      required this.name,
      this.code});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || label != null) {
      map['label'] =
          Variable<String>($DataOptionSetsTable.$converterlabel.toSql(label));
    }
    {
      map['translations'] = Variable<String>(
          $DataOptionSetsTable.$convertertranslations.toSql(translations));
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    return map;
  }

  DataOptionSetsCompanion toCompanion(bool nullToAbsent) {
    return DataOptionSetsCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
      translations: Value(translations),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
    );
  }

  factory DataOptionSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DataOptionSet(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      label: serializer.fromJson<Map<String, dynamic>?>(json['label']),
      translations:
          serializer.fromJson<List<Translation>>(json['translations']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'displayName': serializer.toJson<String?>(displayName),
      'label': serializer.toJson<Map<String, dynamic>?>(label),
      'translations': serializer.toJson<List<Translation>>(translations),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
    };
  }

  DataOptionSet copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          Value<String?> displayName = const Value.absent(),
          Value<Map<String, dynamic>?> label = const Value.absent(),
          List<Translation>? translations,
          String? name,
          Value<String?> code = const Value.absent()}) =>
      DataOptionSet(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        displayName: displayName.present ? displayName.value : this.displayName,
        label: label.present ? label.value : this.label,
        translations: translations ?? this.translations,
        name: name ?? this.name,
        code: code.present ? code.value : this.code,
      );
  DataOptionSet copyWithCompanion(DataOptionSetsCompanion data) {
    return DataOptionSet(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      label: data.label.present ? data.label.value : this.label,
      translations: data.translations.present
          ? data.translations.value
          : this.translations,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DataOptionSet(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastModifiedDate, createdDate,
      displayName, label, translations, name, code);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DataOptionSet &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.displayName == this.displayName &&
          other.label == this.label &&
          other.translations == this.translations &&
          other.name == this.name &&
          other.code == this.code);
}

class DataOptionSetsCompanion extends UpdateCompanion<DataOptionSet> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<String?> displayName;
  final Value<Map<String, dynamic>?> label;
  final Value<List<Translation>> translations;
  final Value<String> name;
  final Value<String?> code;
  final Value<int> rowid;
  const DataOptionSetsCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DataOptionSetsCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    required String name,
    this.code = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<DataOptionSet> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? displayName,
    Expression<String>? label,
    Expression<String>? translations,
    Expression<String>? name,
    Expression<String>? code,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (displayName != null) 'display_name': displayName,
      if (label != null) 'label': label,
      if (translations != null) 'translations': translations,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DataOptionSetsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<String?>? displayName,
      Value<Map<String, dynamic>?>? label,
      Value<List<Translation>>? translations,
      Value<String>? name,
      Value<String?>? code,
      Value<int>? rowid}) {
    return DataOptionSetsCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      displayName: displayName ?? this.displayName,
      label: label ?? this.label,
      translations: translations ?? this.translations,
      name: name ?? this.name,
      code: code ?? this.code,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(
          $DataOptionSetsTable.$converterlabel.toSql(label.value));
    }
    if (translations.present) {
      map['translations'] = Variable<String>($DataOptionSetsTable
          .$convertertranslations
          .toSql(translations.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DataOptionSetsCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DataElementsTable extends DataElements
    with TableInfo<$DataElementsTable, DataElement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DataElementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      label = GeneratedColumn<String>('label', aliasedName, true,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '{}')
          .withConverter<Map<String, dynamic>?>(
              $DataElementsTable.$converterlabel);
  @override
  late final GeneratedColumnWithTypeConverter<List<Translation>, String>
      translations = GeneratedColumn<String>('translations', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '[]')
          .withConverter<List<Translation>>(
              $DataElementsTable.$convertertranslations);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<ValueType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ValueType>($DataElementsTable.$convertertype);
  static const VerificationMeta _optionSetMeta =
      const VerificationMeta('optionSet');
  @override
  late final GeneratedColumn<String> optionSet = GeneratedColumn<String>(
      'option_set', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES data_option_sets (id)'));
  static const VerificationMeta _mandatoryMeta =
      const VerificationMeta('mandatory');
  @override
  late final GeneratedColumn<bool> mandatory = GeneratedColumn<bool>(
      'mandatory', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("mandatory" IN (0, 1))'));
  static const VerificationMeta _defaultValueMeta =
      const VerificationMeta('defaultValue');
  @override
  late final GeneratedColumn<String> defaultValue = GeneratedColumn<String>(
      'default_value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<ScannedCodeProperties?, String>
      scannedCodeProperties = GeneratedColumn<String>(
              'scanned_code_properties', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ScannedCodeProperties?>(
              $DataElementsTable.$converterscannedCodeProperties);
  static const VerificationMeta _gs1EnabledMeta =
      const VerificationMeta('gs1Enabled');
  @override
  late final GeneratedColumn<bool> gs1Enabled = GeneratedColumn<bool>(
      'gs1_enabled', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("gs1_enabled" IN (0, 1))'));
  @override
  late final GeneratedColumnWithTypeConverter<MetadataResourceType?, String>
      resourceType = GeneratedColumn<String>('resource_type', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<MetadataResourceType?>(
              $DataElementsTable.$converterresourceTypen);
  static const VerificationMeta _resourceMetadataSchemaMeta =
      const VerificationMeta('resourceMetadataSchema');
  @override
  late final GeneratedColumn<String> resourceMetadataSchema =
      GeneratedColumn<String>('resource_metadata_schema', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lastModifiedDate,
        createdDate,
        displayName,
        label,
        translations,
        name,
        code,
        description,
        type,
        optionSet,
        mandatory,
        defaultValue,
        scannedCodeProperties,
        gs1Enabled,
        resourceType,
        resourceMetadataSchema
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'data_elements';
  @override
  VerificationContext validateIntegrity(Insertable<DataElement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('option_set')) {
      context.handle(_optionSetMeta,
          optionSet.isAcceptableOrUnknown(data['option_set']!, _optionSetMeta));
    }
    if (data.containsKey('mandatory')) {
      context.handle(_mandatoryMeta,
          mandatory.isAcceptableOrUnknown(data['mandatory']!, _mandatoryMeta));
    }
    if (data.containsKey('default_value')) {
      context.handle(
          _defaultValueMeta,
          defaultValue.isAcceptableOrUnknown(
              data['default_value']!, _defaultValueMeta));
    }
    if (data.containsKey('gs1_enabled')) {
      context.handle(
          _gs1EnabledMeta,
          gs1Enabled.isAcceptableOrUnknown(
              data['gs1_enabled']!, _gs1EnabledMeta));
    }
    if (data.containsKey('resource_metadata_schema')) {
      context.handle(
          _resourceMetadataSchemaMeta,
          resourceMetadataSchema.isAcceptableOrUnknown(
              data['resource_metadata_schema']!, _resourceMetadataSchemaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DataElement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DataElement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name']),
      label: $DataElementsTable.$converterlabel.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])),
      translations: $DataElementsTable.$convertertranslations.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}translations'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      type: $DataElementsTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      optionSet: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}option_set']),
      mandatory: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}mandatory']),
      defaultValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}default_value']),
      scannedCodeProperties: $DataElementsTable.$converterscannedCodeProperties
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}scanned_code_properties'])),
      gs1Enabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}gs1_enabled']),
      resourceType: $DataElementsTable.$converterresourceTypen.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}resource_type'])),
      resourceMetadataSchema: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}resource_metadata_schema']),
    );
  }

  @override
  $DataElementsTable createAlias(String alias) {
    return $DataElementsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?> $converterlabel =
      const NullAwareMapConverter();
  static TypeConverter<List<Translation>, String> $convertertranslations =
      const TranslationConverter();
  static JsonTypeConverter2<ValueType, String, String> $convertertype =
      const EnumNameConverter(ValueType.values);
  static JsonTypeConverter2<ScannedCodeProperties?, String?,
          Map<String, Object?>?> $converterscannedCodeProperties =
      const ScannedCodePropertiesConverter();
  static JsonTypeConverter2<MetadataResourceType, String, String>
      $converterresourceType =
      const EnumNameConverter(MetadataResourceType.values);
  static JsonTypeConverter2<MetadataResourceType?, String?, String?>
      $converterresourceTypen =
      JsonTypeConverter2.asNullable($converterresourceType);
}

class DataElement extends DataClass implements Insertable<DataElement> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final String? displayName;
  final Map<String, dynamic>? label;
  final List<Translation> translations;
  final String name;
  final String? code;
  final String? description;
  final ValueType type;
  final String? optionSet;
  final bool? mandatory;
  final String? defaultValue;
  final ScannedCodeProperties? scannedCodeProperties;
  final bool? gs1Enabled;
  final MetadataResourceType? resourceType;
  final String? resourceMetadataSchema;
  const DataElement(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      this.displayName,
      this.label,
      required this.translations,
      required this.name,
      this.code,
      this.description,
      required this.type,
      this.optionSet,
      this.mandatory,
      this.defaultValue,
      this.scannedCodeProperties,
      this.gs1Enabled,
      this.resourceType,
      this.resourceMetadataSchema});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || label != null) {
      map['label'] =
          Variable<String>($DataElementsTable.$converterlabel.toSql(label));
    }
    {
      map['translations'] = Variable<String>(
          $DataElementsTable.$convertertranslations.toSql(translations));
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    {
      map['type'] =
          Variable<String>($DataElementsTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || optionSet != null) {
      map['option_set'] = Variable<String>(optionSet);
    }
    if (!nullToAbsent || mandatory != null) {
      map['mandatory'] = Variable<bool>(mandatory);
    }
    if (!nullToAbsent || defaultValue != null) {
      map['default_value'] = Variable<String>(defaultValue);
    }
    if (!nullToAbsent || scannedCodeProperties != null) {
      map['scanned_code_properties'] = Variable<String>($DataElementsTable
          .$converterscannedCodeProperties
          .toSql(scannedCodeProperties));
    }
    if (!nullToAbsent || gs1Enabled != null) {
      map['gs1_enabled'] = Variable<bool>(gs1Enabled);
    }
    if (!nullToAbsent || resourceType != null) {
      map['resource_type'] = Variable<String>(
          $DataElementsTable.$converterresourceTypen.toSql(resourceType));
    }
    if (!nullToAbsent || resourceMetadataSchema != null) {
      map['resource_metadata_schema'] =
          Variable<String>(resourceMetadataSchema);
    }
    return map;
  }

  DataElementsCompanion toCompanion(bool nullToAbsent) {
    return DataElementsCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
      translations: Value(translations),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: Value(type),
      optionSet: optionSet == null && nullToAbsent
          ? const Value.absent()
          : Value(optionSet),
      mandatory: mandatory == null && nullToAbsent
          ? const Value.absent()
          : Value(mandatory),
      defaultValue: defaultValue == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultValue),
      scannedCodeProperties: scannedCodeProperties == null && nullToAbsent
          ? const Value.absent()
          : Value(scannedCodeProperties),
      gs1Enabled: gs1Enabled == null && nullToAbsent
          ? const Value.absent()
          : Value(gs1Enabled),
      resourceType: resourceType == null && nullToAbsent
          ? const Value.absent()
          : Value(resourceType),
      resourceMetadataSchema: resourceMetadataSchema == null && nullToAbsent
          ? const Value.absent()
          : Value(resourceMetadataSchema),
    );
  }

  factory DataElement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DataElement(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      label: serializer.fromJson<Map<String, dynamic>?>(json['label']),
      translations:
          serializer.fromJson<List<Translation>>(json['translations']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      description: serializer.fromJson<String?>(json['description']),
      type: $DataElementsTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      optionSet: serializer.fromJson<String?>(json['optionSet']),
      mandatory: serializer.fromJson<bool?>(json['mandatory']),
      defaultValue: serializer.fromJson<String?>(json['defaultValue']),
      scannedCodeProperties: $DataElementsTable.$converterscannedCodeProperties
          .fromJson(serializer
              .fromJson<Map<String, Object?>?>(json['scannedCodeProperties'])),
      gs1Enabled: serializer.fromJson<bool?>(json['gs1Enabled']),
      resourceType: $DataElementsTable.$converterresourceTypen
          .fromJson(serializer.fromJson<String?>(json['resourceType'])),
      resourceMetadataSchema:
          serializer.fromJson<String?>(json['resourceMetadataSchema']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'displayName': serializer.toJson<String?>(displayName),
      'label': serializer.toJson<Map<String, dynamic>?>(label),
      'translations': serializer.toJson<List<Translation>>(translations),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'description': serializer.toJson<String?>(description),
      'type': serializer
          .toJson<String>($DataElementsTable.$convertertype.toJson(type)),
      'optionSet': serializer.toJson<String?>(optionSet),
      'mandatory': serializer.toJson<bool?>(mandatory),
      'defaultValue': serializer.toJson<String?>(defaultValue),
      'scannedCodeProperties': serializer.toJson<Map<String, Object?>?>(
          $DataElementsTable.$converterscannedCodeProperties
              .toJson(scannedCodeProperties)),
      'gs1Enabled': serializer.toJson<bool?>(gs1Enabled),
      'resourceType': serializer.toJson<String?>(
          $DataElementsTable.$converterresourceTypen.toJson(resourceType)),
      'resourceMetadataSchema':
          serializer.toJson<String?>(resourceMetadataSchema),
    };
  }

  DataElement copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          Value<String?> displayName = const Value.absent(),
          Value<Map<String, dynamic>?> label = const Value.absent(),
          List<Translation>? translations,
          String? name,
          Value<String?> code = const Value.absent(),
          Value<String?> description = const Value.absent(),
          ValueType? type,
          Value<String?> optionSet = const Value.absent(),
          Value<bool?> mandatory = const Value.absent(),
          Value<String?> defaultValue = const Value.absent(),
          Value<ScannedCodeProperties?> scannedCodeProperties =
              const Value.absent(),
          Value<bool?> gs1Enabled = const Value.absent(),
          Value<MetadataResourceType?> resourceType = const Value.absent(),
          Value<String?> resourceMetadataSchema = const Value.absent()}) =>
      DataElement(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        displayName: displayName.present ? displayName.value : this.displayName,
        label: label.present ? label.value : this.label,
        translations: translations ?? this.translations,
        name: name ?? this.name,
        code: code.present ? code.value : this.code,
        description: description.present ? description.value : this.description,
        type: type ?? this.type,
        optionSet: optionSet.present ? optionSet.value : this.optionSet,
        mandatory: mandatory.present ? mandatory.value : this.mandatory,
        defaultValue:
            defaultValue.present ? defaultValue.value : this.defaultValue,
        scannedCodeProperties: scannedCodeProperties.present
            ? scannedCodeProperties.value
            : this.scannedCodeProperties,
        gs1Enabled: gs1Enabled.present ? gs1Enabled.value : this.gs1Enabled,
        resourceType:
            resourceType.present ? resourceType.value : this.resourceType,
        resourceMetadataSchema: resourceMetadataSchema.present
            ? resourceMetadataSchema.value
            : this.resourceMetadataSchema,
      );
  DataElement copyWithCompanion(DataElementsCompanion data) {
    return DataElement(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      label: data.label.present ? data.label.value : this.label,
      translations: data.translations.present
          ? data.translations.value
          : this.translations,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      description:
          data.description.present ? data.description.value : this.description,
      type: data.type.present ? data.type.value : this.type,
      optionSet: data.optionSet.present ? data.optionSet.value : this.optionSet,
      mandatory: data.mandatory.present ? data.mandatory.value : this.mandatory,
      defaultValue: data.defaultValue.present
          ? data.defaultValue.value
          : this.defaultValue,
      scannedCodeProperties: data.scannedCodeProperties.present
          ? data.scannedCodeProperties.value
          : this.scannedCodeProperties,
      gs1Enabled:
          data.gs1Enabled.present ? data.gs1Enabled.value : this.gs1Enabled,
      resourceType: data.resourceType.present
          ? data.resourceType.value
          : this.resourceType,
      resourceMetadataSchema: data.resourceMetadataSchema.present
          ? data.resourceMetadataSchema.value
          : this.resourceMetadataSchema,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DataElement(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('optionSet: $optionSet, ')
          ..write('mandatory: $mandatory, ')
          ..write('defaultValue: $defaultValue, ')
          ..write('scannedCodeProperties: $scannedCodeProperties, ')
          ..write('gs1Enabled: $gs1Enabled, ')
          ..write('resourceType: $resourceType, ')
          ..write('resourceMetadataSchema: $resourceMetadataSchema')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      lastModifiedDate,
      createdDate,
      displayName,
      label,
      translations,
      name,
      code,
      description,
      type,
      optionSet,
      mandatory,
      defaultValue,
      scannedCodeProperties,
      gs1Enabled,
      resourceType,
      resourceMetadataSchema);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DataElement &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.displayName == this.displayName &&
          other.label == this.label &&
          other.translations == this.translations &&
          other.name == this.name &&
          other.code == this.code &&
          other.description == this.description &&
          other.type == this.type &&
          other.optionSet == this.optionSet &&
          other.mandatory == this.mandatory &&
          other.defaultValue == this.defaultValue &&
          other.scannedCodeProperties == this.scannedCodeProperties &&
          other.gs1Enabled == this.gs1Enabled &&
          other.resourceType == this.resourceType &&
          other.resourceMetadataSchema == this.resourceMetadataSchema);
}

class DataElementsCompanion extends UpdateCompanion<DataElement> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<String?> displayName;
  final Value<Map<String, dynamic>?> label;
  final Value<List<Translation>> translations;
  final Value<String> name;
  final Value<String?> code;
  final Value<String?> description;
  final Value<ValueType> type;
  final Value<String?> optionSet;
  final Value<bool?> mandatory;
  final Value<String?> defaultValue;
  final Value<ScannedCodeProperties?> scannedCodeProperties;
  final Value<bool?> gs1Enabled;
  final Value<MetadataResourceType?> resourceType;
  final Value<String?> resourceMetadataSchema;
  final Value<int> rowid;
  const DataElementsCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.optionSet = const Value.absent(),
    this.mandatory = const Value.absent(),
    this.defaultValue = const Value.absent(),
    this.scannedCodeProperties = const Value.absent(),
    this.gs1Enabled = const Value.absent(),
    this.resourceType = const Value.absent(),
    this.resourceMetadataSchema = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DataElementsCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    required String name,
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    required ValueType type,
    this.optionSet = const Value.absent(),
    this.mandatory = const Value.absent(),
    this.defaultValue = const Value.absent(),
    this.scannedCodeProperties = const Value.absent(),
    this.gs1Enabled = const Value.absent(),
    this.resourceType = const Value.absent(),
    this.resourceMetadataSchema = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type);
  static Insertable<DataElement> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? displayName,
    Expression<String>? label,
    Expression<String>? translations,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? description,
    Expression<String>? type,
    Expression<String>? optionSet,
    Expression<bool>? mandatory,
    Expression<String>? defaultValue,
    Expression<String>? scannedCodeProperties,
    Expression<bool>? gs1Enabled,
    Expression<String>? resourceType,
    Expression<String>? resourceMetadataSchema,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (displayName != null) 'display_name': displayName,
      if (label != null) 'label': label,
      if (translations != null) 'translations': translations,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (optionSet != null) 'option_set': optionSet,
      if (mandatory != null) 'mandatory': mandatory,
      if (defaultValue != null) 'default_value': defaultValue,
      if (scannedCodeProperties != null)
        'scanned_code_properties': scannedCodeProperties,
      if (gs1Enabled != null) 'gs1_enabled': gs1Enabled,
      if (resourceType != null) 'resource_type': resourceType,
      if (resourceMetadataSchema != null)
        'resource_metadata_schema': resourceMetadataSchema,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DataElementsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<String?>? displayName,
      Value<Map<String, dynamic>?>? label,
      Value<List<Translation>>? translations,
      Value<String>? name,
      Value<String?>? code,
      Value<String?>? description,
      Value<ValueType>? type,
      Value<String?>? optionSet,
      Value<bool?>? mandatory,
      Value<String?>? defaultValue,
      Value<ScannedCodeProperties?>? scannedCodeProperties,
      Value<bool?>? gs1Enabled,
      Value<MetadataResourceType?>? resourceType,
      Value<String?>? resourceMetadataSchema,
      Value<int>? rowid}) {
    return DataElementsCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      displayName: displayName ?? this.displayName,
      label: label ?? this.label,
      translations: translations ?? this.translations,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      type: type ?? this.type,
      optionSet: optionSet ?? this.optionSet,
      mandatory: mandatory ?? this.mandatory,
      defaultValue: defaultValue ?? this.defaultValue,
      scannedCodeProperties:
          scannedCodeProperties ?? this.scannedCodeProperties,
      gs1Enabled: gs1Enabled ?? this.gs1Enabled,
      resourceType: resourceType ?? this.resourceType,
      resourceMetadataSchema:
          resourceMetadataSchema ?? this.resourceMetadataSchema,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(
          $DataElementsTable.$converterlabel.toSql(label.value));
    }
    if (translations.present) {
      map['translations'] = Variable<String>(
          $DataElementsTable.$convertertranslations.toSql(translations.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] =
          Variable<String>($DataElementsTable.$convertertype.toSql(type.value));
    }
    if (optionSet.present) {
      map['option_set'] = Variable<String>(optionSet.value);
    }
    if (mandatory.present) {
      map['mandatory'] = Variable<bool>(mandatory.value);
    }
    if (defaultValue.present) {
      map['default_value'] = Variable<String>(defaultValue.value);
    }
    if (scannedCodeProperties.present) {
      map['scanned_code_properties'] = Variable<String>($DataElementsTable
          .$converterscannedCodeProperties
          .toSql(scannedCodeProperties.value));
    }
    if (gs1Enabled.present) {
      map['gs1_enabled'] = Variable<bool>(gs1Enabled.value);
    }
    if (resourceType.present) {
      map['resource_type'] = Variable<String>(
          $DataElementsTable.$converterresourceTypen.toSql(resourceType.value));
    }
    if (resourceMetadataSchema.present) {
      map['resource_metadata_schema'] =
          Variable<String>(resourceMetadataSchema.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DataElementsCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('optionSet: $optionSet, ')
          ..write('mandatory: $mandatory, ')
          ..write('defaultValue: $defaultValue, ')
          ..write('scannedCodeProperties: $scannedCodeProperties, ')
          ..write('gs1Enabled: $gs1Enabled, ')
          ..write('resourceType: $resourceType, ')
          ..write('resourceMetadataSchema: $resourceMetadataSchema, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DataValuesTable extends DataValues
    with TableInfo<$DataValuesTable, DataValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DataValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _dataElementMeta =
      const VerificationMeta('dataElement');
  @override
  late final GeneratedColumn<String> dataElement = GeneratedColumn<String>(
      'data_element', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES data_elements (id)'));
  static const VerificationMeta _dataInstanceMeta =
      const VerificationMeta('dataInstance');
  @override
  late final GeneratedColumn<String> dataInstance = GeneratedColumn<String>(
      'data_instance', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES data_instances (id)'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _commentMeta =
      const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
      'comment', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lastModifiedDate,
        createdDate,
        dataElement,
        dataInstance,
        value,
        comment
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'data_values';
  @override
  VerificationContext validateIntegrity(Insertable<DataValue> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('data_element')) {
      context.handle(
          _dataElementMeta,
          dataElement.isAcceptableOrUnknown(
              data['data_element']!, _dataElementMeta));
    } else if (isInserting) {
      context.missing(_dataElementMeta);
    }
    if (data.containsKey('data_instance')) {
      context.handle(
          _dataInstanceMeta,
          dataInstance.isAcceptableOrUnknown(
              data['data_instance']!, _dataInstanceMeta));
    } else if (isInserting) {
      context.missing(_dataInstanceMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DataValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DataValue(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      dataElement: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data_element'])!,
      dataInstance: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data_instance'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value']),
      comment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment']),
    );
  }

  @override
  $DataValuesTable createAlias(String alias) {
    return $DataValuesTable(attachedDatabase, alias);
  }
}

class DataValue extends DataClass implements Insertable<DataValue> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final String dataElement;
  final String dataInstance;
  final String? value;
  final String? comment;
  const DataValue(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      required this.dataElement,
      required this.dataInstance,
      this.value,
      this.comment});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    map['data_element'] = Variable<String>(dataElement);
    map['data_instance'] = Variable<String>(dataInstance);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    return map;
  }

  DataValuesCompanion toCompanion(bool nullToAbsent) {
    return DataValuesCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      dataElement: Value(dataElement),
      dataInstance: Value(dataInstance),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
    );
  }

  factory DataValue.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DataValue(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      dataElement: serializer.fromJson<String>(json['dataElement']),
      dataInstance: serializer.fromJson<String>(json['dataInstance']),
      value: serializer.fromJson<String?>(json['value']),
      comment: serializer.fromJson<String?>(json['comment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'dataElement': serializer.toJson<String>(dataElement),
      'dataInstance': serializer.toJson<String>(dataInstance),
      'value': serializer.toJson<String?>(value),
      'comment': serializer.toJson<String?>(comment),
    };
  }

  DataValue copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          String? dataElement,
          String? dataInstance,
          Value<String?> value = const Value.absent(),
          Value<String?> comment = const Value.absent()}) =>
      DataValue(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        dataElement: dataElement ?? this.dataElement,
        dataInstance: dataInstance ?? this.dataInstance,
        value: value.present ? value.value : this.value,
        comment: comment.present ? comment.value : this.comment,
      );
  DataValue copyWithCompanion(DataValuesCompanion data) {
    return DataValue(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      dataElement:
          data.dataElement.present ? data.dataElement.value : this.dataElement,
      dataInstance: data.dataInstance.present
          ? data.dataInstance.value
          : this.dataInstance,
      value: data.value.present ? data.value.value : this.value,
      comment: data.comment.present ? data.comment.value : this.comment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DataValue(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('dataElement: $dataElement, ')
          ..write('dataInstance: $dataInstance, ')
          ..write('value: $value, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastModifiedDate, createdDate,
      dataElement, dataInstance, value, comment);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DataValue &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.dataElement == this.dataElement &&
          other.dataInstance == this.dataInstance &&
          other.value == this.value &&
          other.comment == this.comment);
}

class DataValuesCompanion extends UpdateCompanion<DataValue> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<String> dataElement;
  final Value<String> dataInstance;
  final Value<String?> value;
  final Value<String?> comment;
  final Value<int> rowid;
  const DataValuesCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.dataElement = const Value.absent(),
    this.dataInstance = const Value.absent(),
    this.value = const Value.absent(),
    this.comment = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DataValuesCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    required String dataElement,
    required String dataInstance,
    this.value = const Value.absent(),
    this.comment = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        dataElement = Value(dataElement),
        dataInstance = Value(dataInstance);
  static Insertable<DataValue> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? dataElement,
    Expression<String>? dataInstance,
    Expression<String>? value,
    Expression<String>? comment,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (dataElement != null) 'data_element': dataElement,
      if (dataInstance != null) 'data_instance': dataInstance,
      if (value != null) 'value': value,
      if (comment != null) 'comment': comment,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DataValuesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<String>? dataElement,
      Value<String>? dataInstance,
      Value<String?>? value,
      Value<String?>? comment,
      Value<int>? rowid}) {
    return DataValuesCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      dataElement: dataElement ?? this.dataElement,
      dataInstance: dataInstance ?? this.dataInstance,
      value: value ?? this.value,
      comment: comment ?? this.comment,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (dataElement.present) {
      map['data_element'] = Variable<String>(dataElement.value);
    }
    if (dataInstance.present) {
      map['data_instance'] = Variable<String>(dataInstance.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DataValuesCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('dataElement: $dataElement, ')
          ..write('dataInstance: $dataInstance, ')
          ..write('value: $value, ')
          ..write('comment: $comment, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DataOptionsTable extends DataOptions
    with TableInfo<$DataOptionsTable, DataOption> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DataOptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedDateMeta =
      const VerificationMeta('lastModifiedDate');
  @override
  late final GeneratedColumn<DateTime> lastModifiedDate =
      GeneratedColumn<DateTime>('last_modified_date', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      label = GeneratedColumn<String>('label', aliasedName, true,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '{}')
          .withConverter<Map<String, dynamic>?>(
              $DataOptionsTable.$converterlabel);
  @override
  late final GeneratedColumnWithTypeConverter<List<Translation>, String>
      translations = GeneratedColumn<String>('translations', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              clientDefault: () => '[]')
          .withConverter<List<Translation>>(
              $DataOptionsTable.$convertertranslations);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _optionSetMeta =
      const VerificationMeta('optionSet');
  @override
  late final GeneratedColumn<String> optionSet = GeneratedColumn<String>(
      'option_set', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES data_option_sets (id) ON UPDATE CASCADE ON DELETE CASCADE'));
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      clientDefault: () => 0);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lastModifiedDate,
        createdDate,
        displayName,
        label,
        translations,
        name,
        code,
        optionSet,
        order
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'data_options';
  @override
  VerificationContext validateIntegrity(Insertable<DataOption> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_modified_date')) {
      context.handle(
          _lastModifiedDateMeta,
          lastModifiedDate.isAcceptableOrUnknown(
              data['last_modified_date']!, _lastModifiedDateMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('option_set')) {
      context.handle(_optionSetMeta,
          optionSet.isAcceptableOrUnknown(data['option_set']!, _optionSetMeta));
    } else if (isInserting) {
      context.missing(_optionSetMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {optionSet, id},
        {optionSet, code},
      ];
  @override
  DataOption map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DataOption(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lastModifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_date']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date']),
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name']),
      label: $DataOptionsTable.$converterlabel.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])),
      translations: $DataOptionsTable.$convertertranslations.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}translations'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      optionSet: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}option_set'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
    );
  }

  @override
  $DataOptionsTable createAlias(String alias) {
    return $DataOptionsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?> $converterlabel =
      const NullAwareMapConverter();
  static TypeConverter<List<Translation>, String> $convertertranslations =
      const TranslationConverter();
}

class DataOption extends DataClass implements Insertable<DataOption> {
  final String id;
  final DateTime? lastModifiedDate;
  final DateTime? createdDate;
  final String? displayName;
  final Map<String, dynamic>? label;
  final List<Translation> translations;
  final String name;
  final String code;
  final String optionSet;
  final int order;
  const DataOption(
      {required this.id,
      this.lastModifiedDate,
      this.createdDate,
      this.displayName,
      this.label,
      required this.translations,
      required this.name,
      required this.code,
      required this.optionSet,
      required this.order});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastModifiedDate != null) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || label != null) {
      map['label'] =
          Variable<String>($DataOptionsTable.$converterlabel.toSql(label));
    }
    {
      map['translations'] = Variable<String>(
          $DataOptionsTable.$convertertranslations.toSql(translations));
    }
    map['name'] = Variable<String>(name);
    map['code'] = Variable<String>(code);
    map['option_set'] = Variable<String>(optionSet);
    map['order'] = Variable<int>(order);
    return map;
  }

  DataOptionsCompanion toCompanion(bool nullToAbsent) {
    return DataOptionsCompanion(
      id: Value(id),
      lastModifiedDate: lastModifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModifiedDate),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
      translations: Value(translations),
      name: Value(name),
      code: Value(code),
      optionSet: Value(optionSet),
      order: Value(order),
    );
  }

  factory DataOption.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DataOption(
      id: serializer.fromJson<String>(json['id']),
      lastModifiedDate:
          serializer.fromJson<DateTime?>(json['lastModifiedDate']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      label: serializer.fromJson<Map<String, dynamic>?>(json['label']),
      translations:
          serializer.fromJson<List<Translation>>(json['translations']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String>(json['code']),
      optionSet: serializer.fromJson<String>(json['optionSet']),
      order: serializer.fromJson<int>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastModifiedDate': serializer.toJson<DateTime?>(lastModifiedDate),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'displayName': serializer.toJson<String?>(displayName),
      'label': serializer.toJson<Map<String, dynamic>?>(label),
      'translations': serializer.toJson<List<Translation>>(translations),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String>(code),
      'optionSet': serializer.toJson<String>(optionSet),
      'order': serializer.toJson<int>(order),
    };
  }

  DataOption copyWith(
          {String? id,
          Value<DateTime?> lastModifiedDate = const Value.absent(),
          Value<DateTime?> createdDate = const Value.absent(),
          Value<String?> displayName = const Value.absent(),
          Value<Map<String, dynamic>?> label = const Value.absent(),
          List<Translation>? translations,
          String? name,
          String? code,
          String? optionSet,
          int? order}) =>
      DataOption(
        id: id ?? this.id,
        lastModifiedDate: lastModifiedDate.present
            ? lastModifiedDate.value
            : this.lastModifiedDate,
        createdDate: createdDate.present ? createdDate.value : this.createdDate,
        displayName: displayName.present ? displayName.value : this.displayName,
        label: label.present ? label.value : this.label,
        translations: translations ?? this.translations,
        name: name ?? this.name,
        code: code ?? this.code,
        optionSet: optionSet ?? this.optionSet,
        order: order ?? this.order,
      );
  DataOption copyWithCompanion(DataOptionsCompanion data) {
    return DataOption(
      id: data.id.present ? data.id.value : this.id,
      lastModifiedDate: data.lastModifiedDate.present
          ? data.lastModifiedDate.value
          : this.lastModifiedDate,
      createdDate:
          data.createdDate.present ? data.createdDate.value : this.createdDate,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      label: data.label.present ? data.label.value : this.label,
      translations: data.translations.present
          ? data.translations.value
          : this.translations,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      optionSet: data.optionSet.present ? data.optionSet.value : this.optionSet,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DataOption(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('optionSet: $optionSet, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastModifiedDate, createdDate,
      displayName, label, translations, name, code, optionSet, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DataOption &&
          other.id == this.id &&
          other.lastModifiedDate == this.lastModifiedDate &&
          other.createdDate == this.createdDate &&
          other.displayName == this.displayName &&
          other.label == this.label &&
          other.translations == this.translations &&
          other.name == this.name &&
          other.code == this.code &&
          other.optionSet == this.optionSet &&
          other.order == this.order);
}

class DataOptionsCompanion extends UpdateCompanion<DataOption> {
  final Value<String> id;
  final Value<DateTime?> lastModifiedDate;
  final Value<DateTime?> createdDate;
  final Value<String?> displayName;
  final Value<Map<String, dynamic>?> label;
  final Value<List<Translation>> translations;
  final Value<String> name;
  final Value<String> code;
  final Value<String> optionSet;
  final Value<int> order;
  final Value<int> rowid;
  const DataOptionsCompanion({
    this.id = const Value.absent(),
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.optionSet = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DataOptionsCompanion.insert({
    required String id,
    this.lastModifiedDate = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.displayName = const Value.absent(),
    this.label = const Value.absent(),
    this.translations = const Value.absent(),
    required String name,
    required String code,
    required String optionSet,
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        code = Value(code),
        optionSet = Value(optionSet);
  static Insertable<DataOption> custom({
    Expression<String>? id,
    Expression<DateTime>? lastModifiedDate,
    Expression<DateTime>? createdDate,
    Expression<String>? displayName,
    Expression<String>? label,
    Expression<String>? translations,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? optionSet,
    Expression<int>? order,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastModifiedDate != null) 'last_modified_date': lastModifiedDate,
      if (createdDate != null) 'created_date': createdDate,
      if (displayName != null) 'display_name': displayName,
      if (label != null) 'label': label,
      if (translations != null) 'translations': translations,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (optionSet != null) 'option_set': optionSet,
      if (order != null) 'order': order,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DataOptionsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? lastModifiedDate,
      Value<DateTime?>? createdDate,
      Value<String?>? displayName,
      Value<Map<String, dynamic>?>? label,
      Value<List<Translation>>? translations,
      Value<String>? name,
      Value<String>? code,
      Value<String>? optionSet,
      Value<int>? order,
      Value<int>? rowid}) {
    return DataOptionsCompanion(
      id: id ?? this.id,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      displayName: displayName ?? this.displayName,
      label: label ?? this.label,
      translations: translations ?? this.translations,
      name: name ?? this.name,
      code: code ?? this.code,
      optionSet: optionSet ?? this.optionSet,
      order: order ?? this.order,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastModifiedDate.present) {
      map['last_modified_date'] = Variable<DateTime>(lastModifiedDate.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(
          $DataOptionsTable.$converterlabel.toSql(label.value));
    }
    if (translations.present) {
      map['translations'] = Variable<String>(
          $DataOptionsTable.$convertertranslations.toSql(translations.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (optionSet.present) {
      map['option_set'] = Variable<String>(optionSet.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DataOptionsCompanion(')
          ..write('id: $id, ')
          ..write('lastModifiedDate: $lastModifiedDate, ')
          ..write('createdDate: $createdDate, ')
          ..write('displayName: $displayName, ')
          ..write('label: $label, ')
          ..write('translations: $translations, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('optionSet: $optionSet, ')
          ..write('order: $order, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserFormPermissionsTable extends UserFormPermissions
    with TableInfo<$UserFormPermissionsTable, UserFormPermission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserFormPermissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _teamMeta = const VerificationMeta('team');
  @override
  late final GeneratedColumn<String> team = GeneratedColumn<String>(
      'team', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES teams (id)'));
  static const VerificationMeta _formMeta = const VerificationMeta('form');
  @override
  late final GeneratedColumn<String> form = GeneratedColumn<String>(
      'form', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES form_templates (id)'));
  static const VerificationMeta _validFromMeta =
      const VerificationMeta('validFrom');
  @override
  late final GeneratedColumn<DateTime> validFrom = GeneratedColumn<DateTime>(
      'valid_from', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _validToMeta =
      const VerificationMeta('validTo');
  @override
  late final GeneratedColumn<DateTime> validTo = GeneratedColumn<DateTime>(
      'valid_to', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<List<FormPermission>, String>
      permissions = GeneratedColumn<String>('permissions', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<FormPermission>>(
              $UserFormPermissionsTable.$converterpermissions);
  @override
  List<GeneratedColumn> get $columns =>
      [team, form, validFrom, validTo, permissions];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_form_permissions';
  @override
  VerificationContext validateIntegrity(Insertable<UserFormPermission> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('team')) {
      context.handle(
          _teamMeta, team.isAcceptableOrUnknown(data['team']!, _teamMeta));
    } else if (isInserting) {
      context.missing(_teamMeta);
    }
    if (data.containsKey('form')) {
      context.handle(
          _formMeta, form.isAcceptableOrUnknown(data['form']!, _formMeta));
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('valid_from')) {
      context.handle(_validFromMeta,
          validFrom.isAcceptableOrUnknown(data['valid_from']!, _validFromMeta));
    }
    if (data.containsKey('valid_to')) {
      context.handle(_validToMeta,
          validTo.isAcceptableOrUnknown(data['valid_to']!, _validToMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {team, form};
  @override
  UserFormPermission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserFormPermission(
      team: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}team'])!,
      form: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}form'])!,
      validFrom: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}valid_from']),
      validTo: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}valid_to']),
      permissions: $UserFormPermissionsTable.$converterpermissions.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}permissions'])!),
    );
  }

  @override
  $UserFormPermissionsTable createAlias(String alias) {
    return $UserFormPermissionsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<FormPermission>, String> $converterpermissions =
      const FormPermissionsConverter();
}

class UserFormPermission extends DataClass
    implements Insertable<UserFormPermission> {
  final String team;
  final String form;
  final DateTime? validFrom;
  final DateTime? validTo;
  final List<FormPermission> permissions;
  const UserFormPermission(
      {required this.team,
      required this.form,
      this.validFrom,
      this.validTo,
      required this.permissions});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['team'] = Variable<String>(team);
    map['form'] = Variable<String>(form);
    if (!nullToAbsent || validFrom != null) {
      map['valid_from'] = Variable<DateTime>(validFrom);
    }
    if (!nullToAbsent || validTo != null) {
      map['valid_to'] = Variable<DateTime>(validTo);
    }
    {
      map['permissions'] = Variable<String>(
          $UserFormPermissionsTable.$converterpermissions.toSql(permissions));
    }
    return map;
  }

  UserFormPermissionsCompanion toCompanion(bool nullToAbsent) {
    return UserFormPermissionsCompanion(
      team: Value(team),
      form: Value(form),
      validFrom: validFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(validFrom),
      validTo: validTo == null && nullToAbsent
          ? const Value.absent()
          : Value(validTo),
      permissions: Value(permissions),
    );
  }

  factory UserFormPermission.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserFormPermission(
      team: serializer.fromJson<String>(json['team']),
      form: serializer.fromJson<String>(json['form']),
      validFrom: serializer.fromJson<DateTime?>(json['validFrom']),
      validTo: serializer.fromJson<DateTime?>(json['validTo']),
      permissions:
          serializer.fromJson<List<FormPermission>>(json['permissions']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'team': serializer.toJson<String>(team),
      'form': serializer.toJson<String>(form),
      'validFrom': serializer.toJson<DateTime?>(validFrom),
      'validTo': serializer.toJson<DateTime?>(validTo),
      'permissions': serializer.toJson<List<FormPermission>>(permissions),
    };
  }

  UserFormPermission copyWith(
          {String? team,
          String? form,
          Value<DateTime?> validFrom = const Value.absent(),
          Value<DateTime?> validTo = const Value.absent(),
          List<FormPermission>? permissions}) =>
      UserFormPermission(
        team: team ?? this.team,
        form: form ?? this.form,
        validFrom: validFrom.present ? validFrom.value : this.validFrom,
        validTo: validTo.present ? validTo.value : this.validTo,
        permissions: permissions ?? this.permissions,
      );
  UserFormPermission copyWithCompanion(UserFormPermissionsCompanion data) {
    return UserFormPermission(
      team: data.team.present ? data.team.value : this.team,
      form: data.form.present ? data.form.value : this.form,
      validFrom: data.validFrom.present ? data.validFrom.value : this.validFrom,
      validTo: data.validTo.present ? data.validTo.value : this.validTo,
      permissions:
          data.permissions.present ? data.permissions.value : this.permissions,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserFormPermission(')
          ..write('team: $team, ')
          ..write('form: $form, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo, ')
          ..write('permissions: $permissions')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(team, form, validFrom, validTo, permissions);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserFormPermission &&
          other.team == this.team &&
          other.form == this.form &&
          other.validFrom == this.validFrom &&
          other.validTo == this.validTo &&
          other.permissions == this.permissions);
}

class UserFormPermissionsCompanion extends UpdateCompanion<UserFormPermission> {
  final Value<String> team;
  final Value<String> form;
  final Value<DateTime?> validFrom;
  final Value<DateTime?> validTo;
  final Value<List<FormPermission>> permissions;
  final Value<int> rowid;
  const UserFormPermissionsCompanion({
    this.team = const Value.absent(),
    this.form = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.validTo = const Value.absent(),
    this.permissions = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserFormPermissionsCompanion.insert({
    required String team,
    required String form,
    this.validFrom = const Value.absent(),
    this.validTo = const Value.absent(),
    required List<FormPermission> permissions,
    this.rowid = const Value.absent(),
  })  : team = Value(team),
        form = Value(form),
        permissions = Value(permissions);
  static Insertable<UserFormPermission> custom({
    Expression<String>? team,
    Expression<String>? form,
    Expression<DateTime>? validFrom,
    Expression<DateTime>? validTo,
    Expression<String>? permissions,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (team != null) 'team': team,
      if (form != null) 'form': form,
      if (validFrom != null) 'valid_from': validFrom,
      if (validTo != null) 'valid_to': validTo,
      if (permissions != null) 'permissions': permissions,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserFormPermissionsCompanion copyWith(
      {Value<String>? team,
      Value<String>? form,
      Value<DateTime?>? validFrom,
      Value<DateTime?>? validTo,
      Value<List<FormPermission>>? permissions,
      Value<int>? rowid}) {
    return UserFormPermissionsCompanion(
      team: team ?? this.team,
      form: form ?? this.form,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      permissions: permissions ?? this.permissions,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (team.present) {
      map['team'] = Variable<String>(team.value);
    }
    if (form.present) {
      map['form'] = Variable<String>(form.value);
    }
    if (validFrom.present) {
      map['valid_from'] = Variable<DateTime>(validFrom.value);
    }
    if (validTo.present) {
      map['valid_to'] = Variable<DateTime>(validTo.value);
    }
    if (permissions.present) {
      map['permissions'] = Variable<String>($UserFormPermissionsTable
          .$converterpermissions
          .toSql(permissions.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserFormPermissionsCompanion(')
          ..write('team: $team, ')
          ..write('form: $form, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo, ')
          ..write('permissions: $permissions, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncSummariesTable extends SyncSummaries
    with TableInfo<$SyncSummariesTable, SyncSummary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncSummariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
      'entity', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastSyncMeta =
      const VerificationMeta('lastSync');
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
      'last_sync', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _successCountMeta =
      const VerificationMeta('successCount');
  @override
  late final GeneratedColumn<int> successCount = GeneratedColumn<int>(
      'success_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _failureCountMeta =
      const VerificationMeta('failureCount');
  @override
  late final GeneratedColumn<int> failureCount = GeneratedColumn<int>(
      'failure_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  late final GeneratedColumnWithTypeConverter<List<SyncError>?, String> errors =
      GeneratedColumn<String>('errors', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<SyncError>?>(
              $SyncSummariesTable.$convertererrorsn);
  @override
  List<GeneratedColumn> get $columns =>
      [entity, lastSync, successCount, failureCount, errors];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_summaries';
  @override
  VerificationContext validateIntegrity(Insertable<SyncSummary> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entity')) {
      context.handle(_entityMeta,
          entity.isAcceptableOrUnknown(data['entity']!, _entityMeta));
    } else if (isInserting) {
      context.missing(_entityMeta);
    }
    if (data.containsKey('last_sync')) {
      context.handle(_lastSyncMeta,
          lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta));
    }
    if (data.containsKey('success_count')) {
      context.handle(
          _successCountMeta,
          successCount.isAcceptableOrUnknown(
              data['success_count']!, _successCountMeta));
    }
    if (data.containsKey('failure_count')) {
      context.handle(
          _failureCountMeta,
          failureCount.isAcceptableOrUnknown(
              data['failure_count']!, _failureCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entity};
  @override
  SyncSummary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncSummary(
      entity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity'])!,
      lastSync: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync'])!,
      successCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}success_count'])!,
      failureCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}failure_count'])!,
      errors: $SyncSummariesTable.$convertererrorsn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}errors'])),
    );
  }

  @override
  $SyncSummariesTable createAlias(String alias) {
    return $SyncSummariesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<SyncError>, String> $convertererrors =
      const SyncErrorListConverter();
  static TypeConverter<List<SyncError>?, String?> $convertererrorsn =
      NullAwareTypeConverter.wrap($convertererrors);
}

class SyncSummary extends DataClass implements Insertable<SyncSummary> {
  /// e.g. "activities", "teams"
  final String entity;
  final DateTime lastSync;
  final int successCount;
  final int failureCount;

  /// JSON‑encoded list of errors
  final List<SyncError>? errors;
  const SyncSummary(
      {required this.entity,
      required this.lastSync,
      required this.successCount,
      required this.failureCount,
      this.errors});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entity'] = Variable<String>(entity);
    map['last_sync'] = Variable<DateTime>(lastSync);
    map['success_count'] = Variable<int>(successCount);
    map['failure_count'] = Variable<int>(failureCount);
    if (!nullToAbsent || errors != null) {
      map['errors'] =
          Variable<String>($SyncSummariesTable.$convertererrorsn.toSql(errors));
    }
    return map;
  }

  SyncSummariesCompanion toCompanion(bool nullToAbsent) {
    return SyncSummariesCompanion(
      entity: Value(entity),
      lastSync: Value(lastSync),
      successCount: Value(successCount),
      failureCount: Value(failureCount),
      errors:
          errors == null && nullToAbsent ? const Value.absent() : Value(errors),
    );
  }

  factory SyncSummary.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncSummary(
      entity: serializer.fromJson<String>(json['entity']),
      lastSync: serializer.fromJson<DateTime>(json['lastSync']),
      successCount: serializer.fromJson<int>(json['successCount']),
      failureCount: serializer.fromJson<int>(json['failureCount']),
      errors: serializer.fromJson<List<SyncError>?>(json['errors']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entity': serializer.toJson<String>(entity),
      'lastSync': serializer.toJson<DateTime>(lastSync),
      'successCount': serializer.toJson<int>(successCount),
      'failureCount': serializer.toJson<int>(failureCount),
      'errors': serializer.toJson<List<SyncError>?>(errors),
    };
  }

  SyncSummary copyWith(
          {String? entity,
          DateTime? lastSync,
          int? successCount,
          int? failureCount,
          Value<List<SyncError>?> errors = const Value.absent()}) =>
      SyncSummary(
        entity: entity ?? this.entity,
        lastSync: lastSync ?? this.lastSync,
        successCount: successCount ?? this.successCount,
        failureCount: failureCount ?? this.failureCount,
        errors: errors.present ? errors.value : this.errors,
      );
  SyncSummary copyWithCompanion(SyncSummariesCompanion data) {
    return SyncSummary(
      entity: data.entity.present ? data.entity.value : this.entity,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
      successCount: data.successCount.present
          ? data.successCount.value
          : this.successCount,
      failureCount: data.failureCount.present
          ? data.failureCount.value
          : this.failureCount,
      errors: data.errors.present ? data.errors.value : this.errors,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncSummary(')
          ..write('entity: $entity, ')
          ..write('lastSync: $lastSync, ')
          ..write('successCount: $successCount, ')
          ..write('failureCount: $failureCount, ')
          ..write('errors: $errors')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(entity, lastSync, successCount, failureCount, errors);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncSummary &&
          other.entity == this.entity &&
          other.lastSync == this.lastSync &&
          other.successCount == this.successCount &&
          other.failureCount == this.failureCount &&
          other.errors == this.errors);
}

class SyncSummariesCompanion extends UpdateCompanion<SyncSummary> {
  final Value<String> entity;
  final Value<DateTime> lastSync;
  final Value<int> successCount;
  final Value<int> failureCount;
  final Value<List<SyncError>?> errors;
  final Value<int> rowid;
  const SyncSummariesCompanion({
    this.entity = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.successCount = const Value.absent(),
    this.failureCount = const Value.absent(),
    this.errors = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncSummariesCompanion.insert({
    required String entity,
    this.lastSync = const Value.absent(),
    this.successCount = const Value.absent(),
    this.failureCount = const Value.absent(),
    this.errors = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : entity = Value(entity);
  static Insertable<SyncSummary> custom({
    Expression<String>? entity,
    Expression<DateTime>? lastSync,
    Expression<int>? successCount,
    Expression<int>? failureCount,
    Expression<String>? errors,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entity != null) 'entity': entity,
      if (lastSync != null) 'last_sync': lastSync,
      if (successCount != null) 'success_count': successCount,
      if (failureCount != null) 'failure_count': failureCount,
      if (errors != null) 'errors': errors,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncSummariesCompanion copyWith(
      {Value<String>? entity,
      Value<DateTime>? lastSync,
      Value<int>? successCount,
      Value<int>? failureCount,
      Value<List<SyncError>?>? errors,
      Value<int>? rowid}) {
    return SyncSummariesCompanion(
      entity: entity ?? this.entity,
      lastSync: lastSync ?? this.lastSync,
      successCount: successCount ?? this.successCount,
      failureCount: failureCount ?? this.failureCount,
      errors: errors ?? this.errors,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
    }
    if (successCount.present) {
      map['success_count'] = Variable<int>(successCount.value);
    }
    if (failureCount.present) {
      map['failure_count'] = Variable<int>(failureCount.value);
    }
    if (errors.present) {
      map['errors'] = Variable<String>(
          $SyncSummariesTable.$convertererrorsn.toSql(errors.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncSummariesCompanion(')
          ..write('entity: $entity, ')
          ..write('lastSync: $lastSync, ')
          ..write('successCount: $successCount, ')
          ..write('failureCount: $failureCount, ')
          ..write('errors: $errors, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $OrgUnitsTable orgUnits = $OrgUnitsTable(this);
  late final $OuLevelsTable ouLevels = $OuLevelsTable(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $ActivitiesTable activities = $ActivitiesTable(this);
  late final $TeamsTable teams = $TeamsTable(this);
  late final $ManagedTeamsTable managedTeams = $ManagedTeamsTable(this);
  late final $AssignmentsTable assignments = $AssignmentsTable(this);
  late final $FormTemplatesTable formTemplates = $FormTemplatesTable(this);
  late final $AssignmentFormsTable assignmentForms =
      $AssignmentFormsTable(this);
  late final $FormTemplateVersionsTable formTemplateVersions =
      $FormTemplateVersionsTable(this);
  late final $MetadataSubmissionsTable metadataSubmissions =
      $MetadataSubmissionsTable(this);
  late final $DataInstancesTable dataInstances = $DataInstancesTable(this);
  late final $RepeatInstancesTable repeatInstances =
      $RepeatInstancesTable(this);
  late final $DataOptionSetsTable dataOptionSets = $DataOptionSetsTable(this);
  late final $DataElementsTable dataElements = $DataElementsTable(this);
  late final $DataValuesTable dataValues = $DataValuesTable(this);
  late final $DataOptionsTable dataOptions = $DataOptionsTable(this);
  late final $UserFormPermissionsTable userFormPermissions =
      $UserFormPermissionsTable(this);
  late final $SyncSummariesTable syncSummaries = $SyncSummariesTable(this);
  late final Index orgNameIdx =
      Index('org_name_idx', 'CREATE INDEX org_name_idx ON org_units (name)');
  late final Index orgCodeIdx = Index(
      'org_code_idx', 'CREATE UNIQUE INDEX org_code_idx ON org_units (code)');
  late final Index orgPathIdx = Index(
      'org_path_idx', 'CREATE UNIQUE INDEX org_path_idx ON org_units (path)');
  late final Index orgLevelIdx =
      Index('org_level_idx', 'CREATE INDEX org_level_idx ON org_units (level)');
  late final Index levelNameIdx = Index(
      'level_name_idx', 'CREATE INDEX level_name_idx ON ou_levels (name)');
  late final Index activityDisabledIdx = Index('activity_disabled_idx',
      'CREATE INDEX activity_disabled_idx ON activities (disabled)');
  late final Index teamCodIdx =
      Index('team_cod_idx', 'CREATE INDEX team_cod_idx ON teams (code)');
  late final Index teamDisabledIdx = Index('team_disabled_idx',
      'CREATE INDEX team_disabled_idx ON teams (disabled)');
  late final Index managedTeamCodIdx = Index('managed_team_cod_idx',
      'CREATE INDEX managed_team_cod_idx ON managed_teams (code)');
  late final Index assignmentStatusIdx = Index('assignment_status_idx',
      'CREATE INDEX assignment_status_idx ON assignments (status)');
  late final Index templateVersionNumberIdx = Index(
      'template_version_number_idx',
      'CREATE INDEX template_version_number_idx ON form_template_versions (version_number)');
  late final Index templateVersionTemplateIdx = Index(
      'template_version_template_idx',
      'CREATE INDEX template_version_template_idx ON form_template_versions (template)');
  late final Index repeatTemplatePathIdx = Index('repeat_template_path_idx',
      'CREATE INDEX repeat_template_path_idx ON repeat_instances (template_path)');
  late final Index dataElementNameIdx = Index('data_element_name_idx',
      'CREATE INDEX data_element_name_idx ON data_elements (name)');
  late final Index optionSetNameIdx = Index('option_set_name_idx',
      'CREATE INDEX option_set_name_idx ON data_option_sets (name)');
  late final Index optionSetCodeIdx = Index('option_set_code_idx',
      'CREATE INDEX option_set_code_idx ON data_option_sets (code)');
  late final Index optionNameIdx = Index(
      'option_name_idx', 'CREATE INDEX option_name_idx ON data_options (name)');
  late final Index optionCodeIdx = Index(
      'option_code_idx', 'CREATE INDEX option_code_idx ON data_options (code)');
  late final Index dataInstanceStatusIdx = Index('data_instance_status_idx',
      'CREATE INDEX data_instance_status_idx ON data_instances (sync_state)');
  late final Index formPermissionFormIdx = Index('form_permission_form_idx',
      'CREATE INDEX form_permission_form_idx ON user_form_permissions (team, form)');
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  late final OrgUnitsDao orgUnitsDao = OrgUnitsDao(this as AppDatabase);
  late final ActivitiesDao activitiesDao = ActivitiesDao(this as AppDatabase);
  late final TeamsDao teamsDao = TeamsDao(this as AppDatabase);
  late final AssignmentsDao assignmentsDao =
      AssignmentsDao(this as AppDatabase);
  late final FormTemplatesDao formTemplatesDao =
      FormTemplatesDao(this as AppDatabase);
  late final DataElementsDao dataElementsDao =
      DataElementsDao(this as AppDatabase);
  late final FormTemplateVersionsDao formTemplateVersionsDao =
      FormTemplateVersionsDao(this as AppDatabase);
  late final DataOptionSetsDao dataOptionSetsDao =
      DataOptionSetsDao(this as AppDatabase);
  late final DataOptionsDao dataOptionsDao =
      DataOptionsDao(this as AppDatabase);
  late final DataInstancesDao dataInstancesDao =
      DataInstancesDao(this as AppDatabase);
  late final DataValuesDao dataValuesDao = DataValuesDao(this as AppDatabase);
  late final RepeatInstancesDao repeatInstancesDao =
      RepeatInstancesDao(this as AppDatabase);
  late final SyncSummariesDao syncSummariesDao =
      SyncSummariesDao(this as AppDatabase);
  late final MetadataSubmissionsDao metadataSubmissionsDao =
      MetadataSubmissionsDao(this as AppDatabase);
  late final OuLevelsDao ouLevelsDao = OuLevelsDao(this as AppDatabase);
  late final ProjectsDao projectsDao = ProjectsDao(this as AppDatabase);
  late final UserFormPermissionsDao userFormPermissionsDao =
      UserFormPermissionsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        orgUnits,
        ouLevels,
        projects,
        activities,
        teams,
        managedTeams,
        assignments,
        formTemplates,
        assignmentForms,
        formTemplateVersions,
        metadataSubmissions,
        dataInstances,
        repeatInstances,
        dataOptionSets,
        dataElements,
        dataValues,
        dataOptions,
        userFormPermissions,
        syncSummaries,
        orgNameIdx,
        orgCodeIdx,
        orgPathIdx,
        orgLevelIdx,
        levelNameIdx,
        activityDisabledIdx,
        teamCodIdx,
        teamDisabledIdx,
        managedTeamCodIdx,
        assignmentStatusIdx,
        templateVersionNumberIdx,
        templateVersionTemplateIdx,
        repeatTemplatePathIdx,
        dataElementNameIdx,
        optionSetNameIdx,
        optionSetCodeIdx,
        optionNameIdx,
        optionCodeIdx,
        dataInstanceStatusIdx,
        formPermissionFormIdx
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('assignments',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('assignment_forms', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('data_option_sets',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('data_options', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('data_option_sets',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('data_options', kind: UpdateKind.update),
            ],
          ),
        ],
      );
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  required String username,
  Value<String?> firstName,
  Value<String?> lastName,
  Value<String?> mobile,
  Value<String?> email,
  Value<String?> langKey,
  Value<bool> activated,
  Value<String?> imageUrl,
  required List<String> authorities,
  Value<int?> submissionCount,
  Value<int?> assignmentCount,
  Value<int?> orgUnitCount,
  required List<String> activityUIDs,
  required List<String> userTeamsUIDs,
  required List<String> managedTeamsUIDs,
  required List<String> userGroupsUIDs,
  required List<String> userFormsUIDs,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String> username,
  Value<String?> firstName,
  Value<String?> lastName,
  Value<String?> mobile,
  Value<String?> email,
  Value<String?> langKey,
  Value<bool> activated,
  Value<String?> imageUrl,
  Value<List<String>> authorities,
  Value<int?> submissionCount,
  Value<int?> assignmentCount,
  Value<int?> orgUnitCount,
  Value<List<String>> activityUIDs,
  Value<List<String>> userTeamsUIDs,
  Value<List<String>> managedTeamsUIDs,
  Value<List<String>> userGroupsUIDs,
  Value<List<String>> userFormsUIDs,
  Value<int> rowid,
});

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mobile => $composableBuilder(
      column: $table.mobile, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get langKey => $composableBuilder(
      column: $table.langKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get activated => $composableBuilder(
      column: $table.activated, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get authorities => $composableBuilder(
          column: $table.authorities,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get submissionCount => $composableBuilder(
      column: $table.submissionCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get assignmentCount => $composableBuilder(
      column: $table.assignmentCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orgUnitCount => $composableBuilder(
      column: $table.orgUnitCount, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get activityUIDs => $composableBuilder(
          column: $table.activityUIDs,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get userTeamsUIDs => $composableBuilder(
          column: $table.userTeamsUIDs,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get managedTeamsUIDs => $composableBuilder(
          column: $table.managedTeamsUIDs,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get userGroupsUIDs => $composableBuilder(
          column: $table.userGroupsUIDs,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get userFormsUIDs => $composableBuilder(
          column: $table.userFormsUIDs,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mobile => $composableBuilder(
      column: $table.mobile, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get langKey => $composableBuilder(
      column: $table.langKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get activated => $composableBuilder(
      column: $table.activated, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get authorities => $composableBuilder(
      column: $table.authorities, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get submissionCount => $composableBuilder(
      column: $table.submissionCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get assignmentCount => $composableBuilder(
      column: $table.assignmentCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orgUnitCount => $composableBuilder(
      column: $table.orgUnitCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get activityUIDs => $composableBuilder(
      column: $table.activityUIDs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userTeamsUIDs => $composableBuilder(
      column: $table.userTeamsUIDs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get managedTeamsUIDs => $composableBuilder(
      column: $table.managedTeamsUIDs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userGroupsUIDs => $composableBuilder(
      column: $table.userGroupsUIDs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userFormsUIDs => $composableBuilder(
      column: $table.userFormsUIDs,
      builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get mobile =>
      $composableBuilder(column: $table.mobile, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get langKey =>
      $composableBuilder(column: $table.langKey, builder: (column) => column);

  GeneratedColumn<bool> get activated =>
      $composableBuilder(column: $table.activated, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get authorities =>
      $composableBuilder(
          column: $table.authorities, builder: (column) => column);

  GeneratedColumn<int> get submissionCount => $composableBuilder(
      column: $table.submissionCount, builder: (column) => column);

  GeneratedColumn<int> get assignmentCount => $composableBuilder(
      column: $table.assignmentCount, builder: (column) => column);

  GeneratedColumn<int> get orgUnitCount => $composableBuilder(
      column: $table.orgUnitCount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get activityUIDs =>
      $composableBuilder(
          column: $table.activityUIDs, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get userTeamsUIDs =>
      $composableBuilder(
          column: $table.userTeamsUIDs, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get managedTeamsUIDs =>
      $composableBuilder(
          column: $table.managedTeamsUIDs, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get userGroupsUIDs =>
      $composableBuilder(
          column: $table.userGroupsUIDs, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get userFormsUIDs =>
      $composableBuilder(
          column: $table.userFormsUIDs, builder: (column) => column);
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String?> firstName = const Value.absent(),
            Value<String?> lastName = const Value.absent(),
            Value<String?> mobile = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> langKey = const Value.absent(),
            Value<bool> activated = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<List<String>> authorities = const Value.absent(),
            Value<int?> submissionCount = const Value.absent(),
            Value<int?> assignmentCount = const Value.absent(),
            Value<int?> orgUnitCount = const Value.absent(),
            Value<List<String>> activityUIDs = const Value.absent(),
            Value<List<String>> userTeamsUIDs = const Value.absent(),
            Value<List<String>> managedTeamsUIDs = const Value.absent(),
            Value<List<String>> userGroupsUIDs = const Value.absent(),
            Value<List<String>> userFormsUIDs = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            username: username,
            firstName: firstName,
            lastName: lastName,
            mobile: mobile,
            email: email,
            langKey: langKey,
            activated: activated,
            imageUrl: imageUrl,
            authorities: authorities,
            submissionCount: submissionCount,
            assignmentCount: assignmentCount,
            orgUnitCount: orgUnitCount,
            activityUIDs: activityUIDs,
            userTeamsUIDs: userTeamsUIDs,
            managedTeamsUIDs: managedTeamsUIDs,
            userGroupsUIDs: userGroupsUIDs,
            userFormsUIDs: userFormsUIDs,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            required String username,
            Value<String?> firstName = const Value.absent(),
            Value<String?> lastName = const Value.absent(),
            Value<String?> mobile = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> langKey = const Value.absent(),
            Value<bool> activated = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            required List<String> authorities,
            Value<int?> submissionCount = const Value.absent(),
            Value<int?> assignmentCount = const Value.absent(),
            Value<int?> orgUnitCount = const Value.absent(),
            required List<String> activityUIDs,
            required List<String> userTeamsUIDs,
            required List<String> managedTeamsUIDs,
            required List<String> userGroupsUIDs,
            required List<String> userFormsUIDs,
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            username: username,
            firstName: firstName,
            lastName: lastName,
            mobile: mobile,
            email: email,
            langKey: langKey,
            activated: activated,
            imageUrl: imageUrl,
            authorities: authorities,
            submissionCount: submissionCount,
            assignmentCount: assignmentCount,
            orgUnitCount: orgUnitCount,
            activityUIDs: activityUIDs,
            userTeamsUIDs: userTeamsUIDs,
            managedTeamsUIDs: managedTeamsUIDs,
            userGroupsUIDs: userGroupsUIDs,
            userFormsUIDs: userFormsUIDs,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()>;
typedef $$OrgUnitsTableCreateCompanionBuilder = OrgUnitsCompanion Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  required String name,
  Value<String?> code,
  required String path,
  required int level,
  Value<String?> parent,
  Value<int> rowid,
});
typedef $$OrgUnitsTableUpdateCompanionBuilder = OrgUnitsCompanion Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  Value<String> name,
  Value<String?> code,
  Value<String> path,
  Value<int> level,
  Value<String?> parent,
  Value<int> rowid,
});

final class $$OrgUnitsTableReferences
    extends BaseReferences<_$AppDatabase, $OrgUnitsTable, OrgUnit> {
  $$OrgUnitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrgUnitsTable _parentTable(_$AppDatabase db) => db.orgUnits
      .createAlias($_aliasNameGenerator(db.orgUnits.parent, db.orgUnits.id));

  $$OrgUnitsTableProcessedTableManager? get parent {
    final $_column = $_itemColumn<String>('parent');
    if ($_column == null) return null;
    final manager = $$OrgUnitsTableTableManager($_db, $_db.orgUnits)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AssignmentsTable, List<Assignment>>
      _ouAssignmentsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.assignments,
              aliasName:
                  $_aliasNameGenerator(db.orgUnits.id, db.assignments.orgUnit));

  $$AssignmentsTableProcessedTableManager get ouAssignments {
    final manager = $$AssignmentsTableTableManager($_db, $_db.assignments)
        .filter((f) => f.orgUnit.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ouAssignmentsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$OrgUnitsTableFilterComposer
    extends Composer<_$AppDatabase, $OrgUnitsTable> {
  $$OrgUnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get label => $composableBuilder(
          column: $table.label,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<Translation>, List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  $$OrgUnitsTableFilterComposer get parent {
    final $$OrgUnitsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.orgUnits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrgUnitsTableFilterComposer(
              $db: $db,
              $table: $db.orgUnits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> ouAssignments(
      Expression<bool> Function($$AssignmentsTableFilterComposer f) f) {
    final $$AssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assignments,
        getReferencedColumn: (t) => t.orgUnit,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.assignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrgUnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $OrgUnitsTable> {
  $$OrgUnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translations => $composableBuilder(
      column: $table.translations,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  $$OrgUnitsTableOrderingComposer get parent {
    final $$OrgUnitsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.orgUnits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrgUnitsTableOrderingComposer(
              $db: $db,
              $table: $db.orgUnits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OrgUnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrgUnitsTable> {
  $$OrgUnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  $$OrgUnitsTableAnnotationComposer get parent {
    final $$OrgUnitsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.orgUnits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrgUnitsTableAnnotationComposer(
              $db: $db,
              $table: $db.orgUnits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> ouAssignments<T extends Object>(
      Expression<T> Function($$AssignmentsTableAnnotationComposer a) f) {
    final $$AssignmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assignments,
        getReferencedColumn: (t) => t.orgUnit,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.assignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrgUnitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrgUnitsTable,
    OrgUnit,
    $$OrgUnitsTableFilterComposer,
    $$OrgUnitsTableOrderingComposer,
    $$OrgUnitsTableAnnotationComposer,
    $$OrgUnitsTableCreateCompanionBuilder,
    $$OrgUnitsTableUpdateCompanionBuilder,
    (OrgUnit, $$OrgUnitsTableReferences),
    OrgUnit,
    PrefetchHooks Function({bool parent, bool ouAssignments})> {
  $$OrgUnitsTableTableManager(_$AppDatabase db, $OrgUnitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrgUnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrgUnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrgUnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String?> parent = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrgUnitsCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            path: path,
            level: level,
            parent: parent,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            required String name,
            Value<String?> code = const Value.absent(),
            required String path,
            required int level,
            Value<String?> parent = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrgUnitsCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            path: path,
            level: level,
            parent: parent,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$OrgUnitsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({parent = false, ouAssignments = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ouAssignments) db.assignments],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (parent) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parent,
                    referencedTable: $$OrgUnitsTableReferences._parentTable(db),
                    referencedColumn:
                        $$OrgUnitsTableReferences._parentTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ouAssignments)
                    await $_getPrefetchedData<OrgUnit, $OrgUnitsTable,
                            Assignment>(
                        currentTable: table,
                        referencedTable:
                            $$OrgUnitsTableReferences._ouAssignmentsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$OrgUnitsTableReferences(db, table, p0)
                                .ouAssignments,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.orgUnit == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$OrgUnitsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrgUnitsTable,
    OrgUnit,
    $$OrgUnitsTableFilterComposer,
    $$OrgUnitsTableOrderingComposer,
    $$OrgUnitsTableAnnotationComposer,
    $$OrgUnitsTableCreateCompanionBuilder,
    $$OrgUnitsTableUpdateCompanionBuilder,
    (OrgUnit, $$OrgUnitsTableReferences),
    OrgUnit,
    PrefetchHooks Function({bool parent, bool ouAssignments})>;
typedef $$OuLevelsTableCreateCompanionBuilder = OuLevelsCompanion Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  required String name,
  Value<String?> code,
  required int level,
  Value<int?> offlineLevels,
  Value<int> rowid,
});
typedef $$OuLevelsTableUpdateCompanionBuilder = OuLevelsCompanion Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  Value<String> name,
  Value<String?> code,
  Value<int> level,
  Value<int?> offlineLevels,
  Value<int> rowid,
});

class $$OuLevelsTableFilterComposer
    extends Composer<_$AppDatabase, $OuLevelsTable> {
  $$OuLevelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get label => $composableBuilder(
          column: $table.label,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<Translation>, List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get offlineLevels => $composableBuilder(
      column: $table.offlineLevels, builder: (column) => ColumnFilters(column));
}

class $$OuLevelsTableOrderingComposer
    extends Composer<_$AppDatabase, $OuLevelsTable> {
  $$OuLevelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translations => $composableBuilder(
      column: $table.translations,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get offlineLevels => $composableBuilder(
      column: $table.offlineLevels,
      builder: (column) => ColumnOrderings(column));
}

class $$OuLevelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OuLevelsTable> {
  $$OuLevelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get offlineLevels => $composableBuilder(
      column: $table.offlineLevels, builder: (column) => column);
}

class $$OuLevelsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OuLevelsTable,
    OuLevel,
    $$OuLevelsTableFilterComposer,
    $$OuLevelsTableOrderingComposer,
    $$OuLevelsTableAnnotationComposer,
    $$OuLevelsTableCreateCompanionBuilder,
    $$OuLevelsTableUpdateCompanionBuilder,
    (OuLevel, BaseReferences<_$AppDatabase, $OuLevelsTable, OuLevel>),
    OuLevel,
    PrefetchHooks Function()> {
  $$OuLevelsTableTableManager(_$AppDatabase db, $OuLevelsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OuLevelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OuLevelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OuLevelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int?> offlineLevels = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OuLevelsCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            level: level,
            offlineLevels: offlineLevels,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            required String name,
            Value<String?> code = const Value.absent(),
            required int level,
            Value<int?> offlineLevels = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OuLevelsCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            level: level,
            offlineLevels: offlineLevels,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OuLevelsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OuLevelsTable,
    OuLevel,
    $$OuLevelsTableFilterComposer,
    $$OuLevelsTableOrderingComposer,
    $$OuLevelsTableAnnotationComposer,
    $$OuLevelsTableCreateCompanionBuilder,
    $$OuLevelsTableUpdateCompanionBuilder,
    (OuLevel, BaseReferences<_$AppDatabase, $OuLevelsTable, OuLevel>),
    OuLevel,
    PrefetchHooks Function()>;
typedef $$ProjectsTableCreateCompanionBuilder = ProjectsCompanion Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  required String name,
  Value<String?> code,
  Value<bool?> disabled,
  Value<int> rowid,
});
typedef $$ProjectsTableUpdateCompanionBuilder = ProjectsCompanion Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  Value<String> name,
  Value<String?> code,
  Value<bool?> disabled,
  Value<int> rowid,
});

final class $$ProjectsTableReferences
    extends BaseReferences<_$AppDatabase, $ProjectsTable, Project> {
  $$ProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ActivitiesTable, List<Activity>>
      _activitiesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.activities,
              aliasName:
                  $_aliasNameGenerator(db.projects.id, db.activities.project));

  $$ActivitiesTableProcessedTableManager get activitiesRefs {
    final manager = $$ActivitiesTableTableManager($_db, $_db.activities)
        .filter((f) => f.project.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_activitiesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get label => $composableBuilder(
          column: $table.label,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<Translation>, List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get disabled => $composableBuilder(
      column: $table.disabled, builder: (column) => ColumnFilters(column));

  Expression<bool> activitiesRefs(
      Expression<bool> Function($$ActivitiesTableFilterComposer f) f) {
    final $$ActivitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.project,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableFilterComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translations => $composableBuilder(
      column: $table.translations,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get disabled => $composableBuilder(
      column: $table.disabled, builder: (column) => ColumnOrderings(column));
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<bool> get disabled =>
      $composableBuilder(column: $table.disabled, builder: (column) => column);

  Expression<T> activitiesRefs<T extends Object>(
      Expression<T> Function($$ActivitiesTableAnnotationComposer a) f) {
    final $$ActivitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.project,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProjectsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProjectsTable,
    Project,
    $$ProjectsTableFilterComposer,
    $$ProjectsTableOrderingComposer,
    $$ProjectsTableAnnotationComposer,
    $$ProjectsTableCreateCompanionBuilder,
    $$ProjectsTableUpdateCompanionBuilder,
    (Project, $$ProjectsTableReferences),
    Project,
    PrefetchHooks Function({bool activitiesRefs})> {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<bool?> disabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProjectsCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            disabled: disabled,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            required String name,
            Value<String?> code = const Value.absent(),
            Value<bool?> disabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProjectsCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            disabled: disabled,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ProjectsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({activitiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (activitiesRefs) db.activities],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (activitiesRefs)
                    await $_getPrefetchedData<Project, $ProjectsTable,
                            Activity>(
                        currentTable: table,
                        referencedTable:
                            $$ProjectsTableReferences._activitiesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProjectsTableReferences(db, table, p0)
                                .activitiesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.project == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProjectsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProjectsTable,
    Project,
    $$ProjectsTableFilterComposer,
    $$ProjectsTableOrderingComposer,
    $$ProjectsTableAnnotationComposer,
    $$ProjectsTableCreateCompanionBuilder,
    $$ProjectsTableUpdateCompanionBuilder,
    (Project, $$ProjectsTableReferences),
    Project,
    PrefetchHooks Function({bool activitiesRefs})>;
typedef $$ActivitiesTableCreateCompanionBuilder = ActivitiesCompanion Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  required String name,
  Value<String?> code,
  required String project,
  Value<bool?> disabled,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  Value<String?> description,
  Value<int> rowid,
});
typedef $$ActivitiesTableUpdateCompanionBuilder = ActivitiesCompanion Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  Value<String> name,
  Value<String?> code,
  Value<String> project,
  Value<bool?> disabled,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  Value<String?> description,
  Value<int> rowid,
});

final class $$ActivitiesTableReferences
    extends BaseReferences<_$AppDatabase, $ActivitiesTable, Activity> {
  $$ActivitiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectTable(_$AppDatabase db) => db.projects
      .createAlias($_aliasNameGenerator(db.activities.project, db.projects.id));

  $$ProjectsTableProcessedTableManager get project {
    final $_column = $_itemColumn<String>('project')!;

    final manager = $$ProjectsTableTableManager($_db, $_db.projects)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TeamsTable, List<Team>> _assignedTeamsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.teams,
          aliasName: $_aliasNameGenerator(db.activities.id, db.teams.activity));

  $$TeamsTableProcessedTableManager get assignedTeams {
    final manager = $$TeamsTableTableManager($_db, $_db.teams)
        .filter((f) => f.activity.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_assignedTeamsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ManagedTeamsTable, List<ManagedTeam>>
      _activityManagedTeamsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.managedTeams,
              aliasName: $_aliasNameGenerator(
                  db.activities.id, db.managedTeams.activity));

  $$ManagedTeamsTableProcessedTableManager get activityManagedTeams {
    final manager = $$ManagedTeamsTableTableManager($_db, $_db.managedTeams)
        .filter((f) => f.activity.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_activityManagedTeamsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AssignmentsTable, List<Assignment>>
      _activityAssignmentsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.assignments,
              aliasName: $_aliasNameGenerator(
                  db.activities.id, db.assignments.activity));

  $$AssignmentsTableProcessedTableManager get activityAssignments {
    final manager = $$AssignmentsTableTableManager($_db, $_db.assignments)
        .filter((f) => f.activity.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_activityAssignmentsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get label => $composableBuilder(
          column: $table.label,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<Translation>, List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get disabled => $composableBuilder(
      column: $table.disabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  $$ProjectsTableFilterComposer get project {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.project,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableFilterComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> assignedTeams(
      Expression<bool> Function($$TeamsTableFilterComposer f) f) {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.activity,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableFilterComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> activityManagedTeams(
      Expression<bool> Function($$ManagedTeamsTableFilterComposer f) f) {
    final $$ManagedTeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.managedTeams,
        getReferencedColumn: (t) => t.activity,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ManagedTeamsTableFilterComposer(
              $db: $db,
              $table: $db.managedTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> activityAssignments(
      Expression<bool> Function($$AssignmentsTableFilterComposer f) f) {
    final $$AssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assignments,
        getReferencedColumn: (t) => t.activity,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.assignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translations => $composableBuilder(
      column: $table.translations,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get disabled => $composableBuilder(
      column: $table.disabled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  $$ProjectsTableOrderingComposer get project {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.project,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableOrderingComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<bool> get disabled =>
      $composableBuilder(column: $table.disabled, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get project {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.project,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> assignedTeams<T extends Object>(
      Expression<T> Function($$TeamsTableAnnotationComposer a) f) {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.activity,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> activityManagedTeams<T extends Object>(
      Expression<T> Function($$ManagedTeamsTableAnnotationComposer a) f) {
    final $$ManagedTeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.managedTeams,
        getReferencedColumn: (t) => t.activity,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ManagedTeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.managedTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> activityAssignments<T extends Object>(
      Expression<T> Function($$AssignmentsTableAnnotationComposer a) f) {
    final $$AssignmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assignments,
        getReferencedColumn: (t) => t.activity,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.assignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ActivitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ActivitiesTable,
    Activity,
    $$ActivitiesTableFilterComposer,
    $$ActivitiesTableOrderingComposer,
    $$ActivitiesTableAnnotationComposer,
    $$ActivitiesTableCreateCompanionBuilder,
    $$ActivitiesTableUpdateCompanionBuilder,
    (Activity, $$ActivitiesTableReferences),
    Activity,
    PrefetchHooks Function(
        {bool project,
        bool assignedTeams,
        bool activityManagedTeams,
        bool activityAssignments})> {
  $$ActivitiesTableTableManager(_$AppDatabase db, $ActivitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String> project = const Value.absent(),
            Value<bool?> disabled = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivitiesCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            project: project,
            disabled: disabled,
            startDate: startDate,
            endDate: endDate,
            description: description,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            required String name,
            Value<String?> code = const Value.absent(),
            required String project,
            Value<bool?> disabled = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivitiesCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            project: project,
            disabled: disabled,
            startDate: startDate,
            endDate: endDate,
            description: description,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ActivitiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {project = false,
              assignedTeams = false,
              activityManagedTeams = false,
              activityAssignments = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (assignedTeams) db.teams,
                if (activityManagedTeams) db.managedTeams,
                if (activityAssignments) db.assignments
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (project) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.project,
                    referencedTable:
                        $$ActivitiesTableReferences._projectTable(db),
                    referencedColumn:
                        $$ActivitiesTableReferences._projectTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (assignedTeams)
                    await $_getPrefetchedData<Activity, $ActivitiesTable, Team>(
                        currentTable: table,
                        referencedTable:
                            $$ActivitiesTableReferences._assignedTeamsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ActivitiesTableReferences(db, table, p0)
                                .assignedTeams,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.activity == item.id),
                        typedResults: items),
                  if (activityManagedTeams)
                    await $_getPrefetchedData<Activity, $ActivitiesTable,
                            ManagedTeam>(
                        currentTable: table,
                        referencedTable: $$ActivitiesTableReferences
                            ._activityManagedTeamsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ActivitiesTableReferences(db, table, p0)
                                .activityManagedTeams,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.activity == item.id),
                        typedResults: items),
                  if (activityAssignments)
                    await $_getPrefetchedData<Activity, $ActivitiesTable,
                            Assignment>(
                        currentTable: table,
                        referencedTable: $$ActivitiesTableReferences
                            ._activityAssignmentsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ActivitiesTableReferences(db, table, p0)
                                .activityAssignments,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.activity == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ActivitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ActivitiesTable,
    Activity,
    $$ActivitiesTableFilterComposer,
    $$ActivitiesTableOrderingComposer,
    $$ActivitiesTableAnnotationComposer,
    $$ActivitiesTableCreateCompanionBuilder,
    $$ActivitiesTableUpdateCompanionBuilder,
    (Activity, $$ActivitiesTableReferences),
    Activity,
    PrefetchHooks Function(
        {bool project,
        bool assignedTeams,
        bool activityManagedTeams,
        bool activityAssignments})>;
typedef $$TeamsTableCreateCompanionBuilder = TeamsCompanion Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> code,
  Value<bool?> disabled,
  required String activity,
  Value<int> rowid,
});
typedef $$TeamsTableUpdateCompanionBuilder = TeamsCompanion Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> code,
  Value<bool?> disabled,
  Value<String> activity,
  Value<int> rowid,
});

final class $$TeamsTableReferences
    extends BaseReferences<_$AppDatabase, $TeamsTable, Team> {
  $$TeamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ActivitiesTable _activityTable(_$AppDatabase db) => db.activities
      .createAlias($_aliasNameGenerator(db.teams.activity, db.activities.id));

  $$ActivitiesTableProcessedTableManager get activity {
    final $_column = $_itemColumn<String>('activity')!;

    final manager = $$ActivitiesTableTableManager($_db, $_db.activities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_activityTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ManagedTeamsTable, List<ManagedTeam>>
      _managedTeamsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.managedTeams,
              aliasName:
                  $_aliasNameGenerator(db.teams.id, db.managedTeams.managedBy));

  $$ManagedTeamsTableProcessedTableManager get managedTeams {
    final manager = $$ManagedTeamsTableTableManager($_db, $_db.managedTeams)
        .filter((f) => f.managedBy.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_managedTeamsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AssignmentsTable, List<Assignment>>
      _teamAssignmentsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.assignments,
          aliasName: $_aliasNameGenerator(db.teams.id, db.assignments.team));

  $$AssignmentsTableProcessedTableManager get teamAssignments {
    final manager = $$AssignmentsTableTableManager($_db, $_db.assignments)
        .filter((f) => f.team.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_teamAssignmentsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$UserFormPermissionsTable,
      List<UserFormPermission>> _teamFormPermissionsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.userFormPermissions,
          aliasName:
              $_aliasNameGenerator(db.teams.id, db.userFormPermissions.team));

  $$UserFormPermissionsTableProcessedTableManager get teamFormPermissions {
    final manager =
        $$UserFormPermissionsTableTableManager($_db, $_db.userFormPermissions)
            .filter((f) => f.team.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_teamFormPermissionsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TeamsTableFilterComposer extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get disabled => $composableBuilder(
      column: $table.disabled, builder: (column) => ColumnFilters(column));

  $$ActivitiesTableFilterComposer get activity {
    final $$ActivitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.activity,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableFilterComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> managedTeams(
      Expression<bool> Function($$ManagedTeamsTableFilterComposer f) f) {
    final $$ManagedTeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.managedTeams,
        getReferencedColumn: (t) => t.managedBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ManagedTeamsTableFilterComposer(
              $db: $db,
              $table: $db.managedTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> teamAssignments(
      Expression<bool> Function($$AssignmentsTableFilterComposer f) f) {
    final $$AssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assignments,
        getReferencedColumn: (t) => t.team,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.assignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> teamFormPermissions(
      Expression<bool> Function($$UserFormPermissionsTableFilterComposer f) f) {
    final $$UserFormPermissionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userFormPermissions,
        getReferencedColumn: (t) => t.team,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserFormPermissionsTableFilterComposer(
              $db: $db,
              $table: $db.userFormPermissions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get disabled => $composableBuilder(
      column: $table.disabled, builder: (column) => ColumnOrderings(column));

  $$ActivitiesTableOrderingComposer get activity {
    final $$ActivitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.activity,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableOrderingComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<bool> get disabled =>
      $composableBuilder(column: $table.disabled, builder: (column) => column);

  $$ActivitiesTableAnnotationComposer get activity {
    final $$ActivitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.activity,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> managedTeams<T extends Object>(
      Expression<T> Function($$ManagedTeamsTableAnnotationComposer a) f) {
    final $$ManagedTeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.managedTeams,
        getReferencedColumn: (t) => t.managedBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ManagedTeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.managedTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> teamAssignments<T extends Object>(
      Expression<T> Function($$AssignmentsTableAnnotationComposer a) f) {
    final $$AssignmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assignments,
        getReferencedColumn: (t) => t.team,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.assignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> teamFormPermissions<T extends Object>(
      Expression<T> Function($$UserFormPermissionsTableAnnotationComposer a)
          f) {
    final $$UserFormPermissionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.userFormPermissions,
            getReferencedColumn: (t) => t.team,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$UserFormPermissionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.userFormPermissions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TeamsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TeamsTable,
    Team,
    $$TeamsTableFilterComposer,
    $$TeamsTableOrderingComposer,
    $$TeamsTableAnnotationComposer,
    $$TeamsTableCreateCompanionBuilder,
    $$TeamsTableUpdateCompanionBuilder,
    (Team, $$TeamsTableReferences),
    Team,
    PrefetchHooks Function(
        {bool activity,
        bool managedTeams,
        bool teamAssignments,
        bool teamFormPermissions})> {
  $$TeamsTableTableManager(_$AppDatabase db, $TeamsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<bool?> disabled = const Value.absent(),
            Value<String> activity = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TeamsCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            code: code,
            disabled: disabled,
            activity: activity,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<bool?> disabled = const Value.absent(),
            required String activity,
            Value<int> rowid = const Value.absent(),
          }) =>
              TeamsCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            code: code,
            disabled: disabled,
            activity: activity,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TeamsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {activity = false,
              managedTeams = false,
              teamAssignments = false,
              teamFormPermissions = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (managedTeams) db.managedTeams,
                if (teamAssignments) db.assignments,
                if (teamFormPermissions) db.userFormPermissions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (activity) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.activity,
                    referencedTable: $$TeamsTableReferences._activityTable(db),
                    referencedColumn:
                        $$TeamsTableReferences._activityTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (managedTeams)
                    await $_getPrefetchedData<Team, $TeamsTable, ManagedTeam>(
                        currentTable: table,
                        referencedTable:
                            $$TeamsTableReferences._managedTeamsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TeamsTableReferences(db, table, p0).managedTeams,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.managedBy == item.id),
                        typedResults: items),
                  if (teamAssignments)
                    await $_getPrefetchedData<Team, $TeamsTable, Assignment>(
                        currentTable: table,
                        referencedTable:
                            $$TeamsTableReferences._teamAssignmentsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TeamsTableReferences(db, table, p0)
                                .teamAssignments,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.team == item.id),
                        typedResults: items),
                  if (teamFormPermissions)
                    await $_getPrefetchedData<Team, $TeamsTable,
                            UserFormPermission>(
                        currentTable: table,
                        referencedTable: $$TeamsTableReferences
                            ._teamFormPermissionsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TeamsTableReferences(db, table, p0)
                                .teamFormPermissions,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.team == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TeamsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TeamsTable,
    Team,
    $$TeamsTableFilterComposer,
    $$TeamsTableOrderingComposer,
    $$TeamsTableAnnotationComposer,
    $$TeamsTableCreateCompanionBuilder,
    $$TeamsTableUpdateCompanionBuilder,
    (Team, $$TeamsTableReferences),
    Team,
    PrefetchHooks Function(
        {bool activity,
        bool managedTeams,
        bool teamAssignments,
        bool teamFormPermissions})>;
typedef $$ManagedTeamsTableCreateCompanionBuilder = ManagedTeamsCompanion
    Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> code,
  required String activity,
  required String managedBy,
  Value<int> rowid,
});
typedef $$ManagedTeamsTableUpdateCompanionBuilder = ManagedTeamsCompanion
    Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> code,
  Value<String> activity,
  Value<String> managedBy,
  Value<int> rowid,
});

final class $$ManagedTeamsTableReferences
    extends BaseReferences<_$AppDatabase, $ManagedTeamsTable, ManagedTeam> {
  $$ManagedTeamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ActivitiesTable _activityTable(_$AppDatabase db) =>
      db.activities.createAlias(
          $_aliasNameGenerator(db.managedTeams.activity, db.activities.id));

  $$ActivitiesTableProcessedTableManager get activity {
    final $_column = $_itemColumn<String>('activity')!;

    final manager = $$ActivitiesTableTableManager($_db, $_db.activities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_activityTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TeamsTable _managedByTable(_$AppDatabase db) => db.teams.createAlias(
      $_aliasNameGenerator(db.managedTeams.managedBy, db.teams.id));

  $$TeamsTableProcessedTableManager get managedBy {
    final $_column = $_itemColumn<String>('managed_by')!;

    final manager = $$TeamsTableTableManager($_db, $_db.teams)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_managedByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ManagedTeamsTableFilterComposer
    extends Composer<_$AppDatabase, $ManagedTeamsTable> {
  $$ManagedTeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  $$ActivitiesTableFilterComposer get activity {
    final $$ActivitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.activity,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableFilterComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableFilterComposer get managedBy {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.managedBy,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableFilterComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ManagedTeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $ManagedTeamsTable> {
  $$ManagedTeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  $$ActivitiesTableOrderingComposer get activity {
    final $$ActivitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.activity,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableOrderingComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableOrderingComposer get managedBy {
    final $$TeamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.managedBy,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableOrderingComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ManagedTeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ManagedTeamsTable> {
  $$ManagedTeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  $$ActivitiesTableAnnotationComposer get activity {
    final $$ActivitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.activity,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableAnnotationComposer get managedBy {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.managedBy,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ManagedTeamsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ManagedTeamsTable,
    ManagedTeam,
    $$ManagedTeamsTableFilterComposer,
    $$ManagedTeamsTableOrderingComposer,
    $$ManagedTeamsTableAnnotationComposer,
    $$ManagedTeamsTableCreateCompanionBuilder,
    $$ManagedTeamsTableUpdateCompanionBuilder,
    (ManagedTeam, $$ManagedTeamsTableReferences),
    ManagedTeam,
    PrefetchHooks Function({bool activity, bool managedBy})> {
  $$ManagedTeamsTableTableManager(_$AppDatabase db, $ManagedTeamsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ManagedTeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ManagedTeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ManagedTeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String> activity = const Value.absent(),
            Value<String> managedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ManagedTeamsCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            code: code,
            activity: activity,
            managedBy: managedBy,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> code = const Value.absent(),
            required String activity,
            required String managedBy,
            Value<int> rowid = const Value.absent(),
          }) =>
              ManagedTeamsCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            code: code,
            activity: activity,
            managedBy: managedBy,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ManagedTeamsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({activity = false, managedBy = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (activity) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.activity,
                    referencedTable:
                        $$ManagedTeamsTableReferences._activityTable(db),
                    referencedColumn:
                        $$ManagedTeamsTableReferences._activityTable(db).id,
                  ) as T;
                }
                if (managedBy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.managedBy,
                    referencedTable:
                        $$ManagedTeamsTableReferences._managedByTable(db),
                    referencedColumn:
                        $$ManagedTeamsTableReferences._managedByTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ManagedTeamsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ManagedTeamsTable,
    ManagedTeam,
    $$ManagedTeamsTableFilterComposer,
    $$ManagedTeamsTableOrderingComposer,
    $$ManagedTeamsTableAnnotationComposer,
    $$ManagedTeamsTableCreateCompanionBuilder,
    $$ManagedTeamsTableUpdateCompanionBuilder,
    (ManagedTeam, $$ManagedTeamsTableReferences),
    ManagedTeam,
    PrefetchHooks Function({bool activity, bool managedBy})>;
typedef $$AssignmentsTableCreateCompanionBuilder = AssignmentsCompanion
    Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  required String activity,
  required String team,
  required String orgUnit,
  Value<DateTime?> instanceDate,
  required InstanceSyncStatus syncState,
  Value<AssignmentStatus?> status,
  Value<DateTime?> completedDate,
  Value<DateTime?> updatedAtClient,
  Value<bool?> disabled,
  Value<int> rowid,
});
typedef $$AssignmentsTableUpdateCompanionBuilder = AssignmentsCompanion
    Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String> activity,
  Value<String> team,
  Value<String> orgUnit,
  Value<DateTime?> instanceDate,
  Value<InstanceSyncStatus> syncState,
  Value<AssignmentStatus?> status,
  Value<DateTime?> completedDate,
  Value<DateTime?> updatedAtClient,
  Value<bool?> disabled,
  Value<int> rowid,
});

final class $$AssignmentsTableReferences
    extends BaseReferences<_$AppDatabase, $AssignmentsTable, Assignment> {
  $$AssignmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ActivitiesTable _activityTable(_$AppDatabase db) =>
      db.activities.createAlias(
          $_aliasNameGenerator(db.assignments.activity, db.activities.id));

  $$ActivitiesTableProcessedTableManager get activity {
    final $_column = $_itemColumn<String>('activity')!;

    final manager = $$ActivitiesTableTableManager($_db, $_db.activities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_activityTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TeamsTable _teamTable(_$AppDatabase db) => db.teams
      .createAlias($_aliasNameGenerator(db.assignments.team, db.teams.id));

  $$TeamsTableProcessedTableManager get team {
    final $_column = $_itemColumn<String>('team')!;

    final manager = $$TeamsTableTableManager($_db, $_db.teams)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $OrgUnitsTable _orgUnitTable(_$AppDatabase db) =>
      db.orgUnits.createAlias(
          $_aliasNameGenerator(db.assignments.orgUnit, db.orgUnits.id));

  $$OrgUnitsTableProcessedTableManager get orgUnit {
    final $_column = $_itemColumn<String>('org_unit')!;

    final manager = $$OrgUnitsTableTableManager($_db, $_db.orgUnits)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orgUnitTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AssignmentFormsTable, List<AssignmentForm>>
      _formsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.assignmentForms,
              aliasName: $_aliasNameGenerator(
                  db.assignments.id, db.assignmentForms.assignment));

  $$AssignmentFormsTableProcessedTableManager get forms {
    final manager = $$AssignmentFormsTableTableManager(
            $_db, $_db.assignmentForms)
        .filter((f) => f.assignment.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_formsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DataInstancesTable, List<DataInstance>>
      _assignmentDataInstancesTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.dataInstances,
              aliasName: $_aliasNameGenerator(
                  db.assignments.id, db.dataInstances.assignment));

  $$DataInstancesTableProcessedTableManager get assignmentDataInstances {
    final manager = $$DataInstancesTableTableManager($_db, $_db.dataInstances)
        .filter((f) => f.assignment.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_assignmentDataInstancesTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AssignmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AssignmentsTable> {
  $$AssignmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get instanceDate => $composableBuilder(
      column: $table.instanceDate, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<InstanceSyncStatus, InstanceSyncStatus, String>
      get syncState => $composableBuilder(
          column: $table.syncState,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<AssignmentStatus?, AssignmentStatus, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get completedDate => $composableBuilder(
      column: $table.completedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAtClient => $composableBuilder(
      column: $table.updatedAtClient,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get disabled => $composableBuilder(
      column: $table.disabled, builder: (column) => ColumnFilters(column));

  $$ActivitiesTableFilterComposer get activity {
    final $$ActivitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.activity,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableFilterComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableFilterComposer get team {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.team,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableFilterComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrgUnitsTableFilterComposer get orgUnit {
    final $$OrgUnitsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orgUnit,
        referencedTable: $db.orgUnits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrgUnitsTableFilterComposer(
              $db: $db,
              $table: $db.orgUnits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> forms(
      Expression<bool> Function($$AssignmentFormsTableFilterComposer f) f) {
    final $$AssignmentFormsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assignmentForms,
        getReferencedColumn: (t) => t.assignment,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentFormsTableFilterComposer(
              $db: $db,
              $table: $db.assignmentForms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> assignmentDataInstances(
      Expression<bool> Function($$DataInstancesTableFilterComposer f) f) {
    final $$DataInstancesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataInstances,
        getReferencedColumn: (t) => t.assignment,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataInstancesTableFilterComposer(
              $db: $db,
              $table: $db.dataInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AssignmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssignmentsTable> {
  $$AssignmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get instanceDate => $composableBuilder(
      column: $table.instanceDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedDate => $composableBuilder(
      column: $table.completedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAtClient => $composableBuilder(
      column: $table.updatedAtClient,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get disabled => $composableBuilder(
      column: $table.disabled, builder: (column) => ColumnOrderings(column));

  $$ActivitiesTableOrderingComposer get activity {
    final $$ActivitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.activity,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableOrderingComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableOrderingComposer get team {
    final $$TeamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.team,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableOrderingComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrgUnitsTableOrderingComposer get orgUnit {
    final $$OrgUnitsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orgUnit,
        referencedTable: $db.orgUnits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrgUnitsTableOrderingComposer(
              $db: $db,
              $table: $db.orgUnits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssignmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssignmentsTable> {
  $$AssignmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<DateTime> get instanceDate => $composableBuilder(
      column: $table.instanceDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InstanceSyncStatus, String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AssignmentStatus?, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get completedDate => $composableBuilder(
      column: $table.completedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAtClient => $composableBuilder(
      column: $table.updatedAtClient, builder: (column) => column);

  GeneratedColumn<bool> get disabled =>
      $composableBuilder(column: $table.disabled, builder: (column) => column);

  $$ActivitiesTableAnnotationComposer get activity {
    final $$ActivitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.activity,
        referencedTable: $db.activities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.activities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableAnnotationComposer get team {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.team,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrgUnitsTableAnnotationComposer get orgUnit {
    final $$OrgUnitsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orgUnit,
        referencedTable: $db.orgUnits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrgUnitsTableAnnotationComposer(
              $db: $db,
              $table: $db.orgUnits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> forms<T extends Object>(
      Expression<T> Function($$AssignmentFormsTableAnnotationComposer a) f) {
    final $$AssignmentFormsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assignmentForms,
        getReferencedColumn: (t) => t.assignment,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentFormsTableAnnotationComposer(
              $db: $db,
              $table: $db.assignmentForms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> assignmentDataInstances<T extends Object>(
      Expression<T> Function($$DataInstancesTableAnnotationComposer a) f) {
    final $$DataInstancesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataInstances,
        getReferencedColumn: (t) => t.assignment,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataInstancesTableAnnotationComposer(
              $db: $db,
              $table: $db.dataInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AssignmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AssignmentsTable,
    Assignment,
    $$AssignmentsTableFilterComposer,
    $$AssignmentsTableOrderingComposer,
    $$AssignmentsTableAnnotationComposer,
    $$AssignmentsTableCreateCompanionBuilder,
    $$AssignmentsTableUpdateCompanionBuilder,
    (Assignment, $$AssignmentsTableReferences),
    Assignment,
    PrefetchHooks Function(
        {bool activity,
        bool team,
        bool orgUnit,
        bool forms,
        bool assignmentDataInstances})> {
  $$AssignmentsTableTableManager(_$AppDatabase db, $AssignmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssignmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssignmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssignmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String> activity = const Value.absent(),
            Value<String> team = const Value.absent(),
            Value<String> orgUnit = const Value.absent(),
            Value<DateTime?> instanceDate = const Value.absent(),
            Value<InstanceSyncStatus> syncState = const Value.absent(),
            Value<AssignmentStatus?> status = const Value.absent(),
            Value<DateTime?> completedDate = const Value.absent(),
            Value<DateTime?> updatedAtClient = const Value.absent(),
            Value<bool?> disabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AssignmentsCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            activity: activity,
            team: team,
            orgUnit: orgUnit,
            instanceDate: instanceDate,
            syncState: syncState,
            status: status,
            completedDate: completedDate,
            updatedAtClient: updatedAtClient,
            disabled: disabled,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            required String activity,
            required String team,
            required String orgUnit,
            Value<DateTime?> instanceDate = const Value.absent(),
            required InstanceSyncStatus syncState,
            Value<AssignmentStatus?> status = const Value.absent(),
            Value<DateTime?> completedDate = const Value.absent(),
            Value<DateTime?> updatedAtClient = const Value.absent(),
            Value<bool?> disabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AssignmentsCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            activity: activity,
            team: team,
            orgUnit: orgUnit,
            instanceDate: instanceDate,
            syncState: syncState,
            status: status,
            completedDate: completedDate,
            updatedAtClient: updatedAtClient,
            disabled: disabled,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AssignmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {activity = false,
              team = false,
              orgUnit = false,
              forms = false,
              assignmentDataInstances = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (forms) db.assignmentForms,
                if (assignmentDataInstances) db.dataInstances
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (activity) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.activity,
                    referencedTable:
                        $$AssignmentsTableReferences._activityTable(db),
                    referencedColumn:
                        $$AssignmentsTableReferences._activityTable(db).id,
                  ) as T;
                }
                if (team) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.team,
                    referencedTable:
                        $$AssignmentsTableReferences._teamTable(db),
                    referencedColumn:
                        $$AssignmentsTableReferences._teamTable(db).id,
                  ) as T;
                }
                if (orgUnit) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.orgUnit,
                    referencedTable:
                        $$AssignmentsTableReferences._orgUnitTable(db),
                    referencedColumn:
                        $$AssignmentsTableReferences._orgUnitTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (forms)
                    await $_getPrefetchedData<Assignment, $AssignmentsTable,
                            AssignmentForm>(
                        currentTable: table,
                        referencedTable:
                            $$AssignmentsTableReferences._formsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AssignmentsTableReferences(db, table, p0).forms,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.assignment == item.id),
                        typedResults: items),
                  if (assignmentDataInstances)
                    await $_getPrefetchedData<Assignment, $AssignmentsTable,
                            DataInstance>(
                        currentTable: table,
                        referencedTable: $$AssignmentsTableReferences
                            ._assignmentDataInstancesTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AssignmentsTableReferences(db, table, p0)
                                .assignmentDataInstances,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.assignment == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AssignmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AssignmentsTable,
    Assignment,
    $$AssignmentsTableFilterComposer,
    $$AssignmentsTableOrderingComposer,
    $$AssignmentsTableAnnotationComposer,
    $$AssignmentsTableCreateCompanionBuilder,
    $$AssignmentsTableUpdateCompanionBuilder,
    (Assignment, $$AssignmentsTableReferences),
    Assignment,
    PrefetchHooks Function(
        {bool activity,
        bool team,
        bool orgUnit,
        bool forms,
        bool assignmentDataInstances})>;
typedef $$FormTemplatesTableCreateCompanionBuilder = FormTemplatesCompanion
    Function({
  required String id,
  required String versionUid,
  required int versionNumber,
  required String name,
  Value<Map<String, dynamic>?> label,
  Value<String?> description,
  Value<bool?> disabled,
  Value<int> rowid,
});
typedef $$FormTemplatesTableUpdateCompanionBuilder = FormTemplatesCompanion
    Function({
  Value<String> id,
  Value<String> versionUid,
  Value<int> versionNumber,
  Value<String> name,
  Value<Map<String, dynamic>?> label,
  Value<String?> description,
  Value<bool?> disabled,
  Value<int> rowid,
});

final class $$FormTemplatesTableReferences
    extends BaseReferences<_$AppDatabase, $FormTemplatesTable, FormTemplate> {
  $$FormTemplatesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AssignmentFormsTable, List<AssignmentForm>>
      _assignmentsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.assignmentForms,
              aliasName: $_aliasNameGenerator(
                  db.formTemplates.id, db.assignmentForms.form));

  $$AssignmentFormsTableProcessedTableManager get assignments {
    final manager =
        $$AssignmentFormsTableTableManager($_db, $_db.assignmentForms)
            .filter((f) => f.form.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_assignmentsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FormTemplateVersionsTable,
      List<FormTemplateVersion>> _versionsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.formTemplateVersions,
          aliasName: $_aliasNameGenerator(
              db.formTemplates.id, db.formTemplateVersions.template));

  $$FormTemplateVersionsTableProcessedTableManager get versions {
    final manager = $$FormTemplateVersionsTableTableManager(
            $_db, $_db.formTemplateVersions)
        .filter((f) => f.template.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_versionsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DataInstancesTable, List<DataInstance>>
      _templateDataInstancesTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.dataInstances,
              aliasName: $_aliasNameGenerator(
                  db.formTemplates.id, db.dataInstances.formTemplate));

  $$DataInstancesTableProcessedTableManager get templateDataInstances {
    final manager = $$DataInstancesTableTableManager($_db, $_db.dataInstances)
        .filter(
            (f) => f.formTemplate.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_templateDataInstancesTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$UserFormPermissionsTable,
      List<UserFormPermission>> _formPermissionsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.userFormPermissions,
          aliasName: $_aliasNameGenerator(
              db.formTemplates.id, db.userFormPermissions.form));

  $$UserFormPermissionsTableProcessedTableManager get formPermissions {
    final manager =
        $$UserFormPermissionsTableTableManager($_db, $_db.userFormPermissions)
            .filter((f) => f.form.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_formPermissionsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FormTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $FormTemplatesTable> {
  $$FormTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get versionUid => $composableBuilder(
      column: $table.versionUid, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get versionNumber => $composableBuilder(
      column: $table.versionNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get label => $composableBuilder(
          column: $table.label,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get disabled => $composableBuilder(
      column: $table.disabled, builder: (column) => ColumnFilters(column));

  Expression<bool> assignments(
      Expression<bool> Function($$AssignmentFormsTableFilterComposer f) f) {
    final $$AssignmentFormsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assignmentForms,
        getReferencedColumn: (t) => t.form,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentFormsTableFilterComposer(
              $db: $db,
              $table: $db.assignmentForms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> versions(
      Expression<bool> Function($$FormTemplateVersionsTableFilterComposer f)
          f) {
    final $$FormTemplateVersionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.formTemplateVersions,
        getReferencedColumn: (t) => t.template,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplateVersionsTableFilterComposer(
              $db: $db,
              $table: $db.formTemplateVersions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> templateDataInstances(
      Expression<bool> Function($$DataInstancesTableFilterComposer f) f) {
    final $$DataInstancesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataInstances,
        getReferencedColumn: (t) => t.formTemplate,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataInstancesTableFilterComposer(
              $db: $db,
              $table: $db.dataInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> formPermissions(
      Expression<bool> Function($$UserFormPermissionsTableFilterComposer f) f) {
    final $$UserFormPermissionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userFormPermissions,
        getReferencedColumn: (t) => t.form,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserFormPermissionsTableFilterComposer(
              $db: $db,
              $table: $db.userFormPermissions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FormTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $FormTemplatesTable> {
  $$FormTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get versionUid => $composableBuilder(
      column: $table.versionUid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get versionNumber => $composableBuilder(
      column: $table.versionNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get disabled => $composableBuilder(
      column: $table.disabled, builder: (column) => ColumnOrderings(column));
}

class $$FormTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FormTemplatesTable> {
  $$FormTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get versionUid => $composableBuilder(
      column: $table.versionUid, builder: (column) => column);

  GeneratedColumn<int> get versionNumber => $composableBuilder(
      column: $table.versionNumber, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get disabled =>
      $composableBuilder(column: $table.disabled, builder: (column) => column);

  Expression<T> assignments<T extends Object>(
      Expression<T> Function($$AssignmentFormsTableAnnotationComposer a) f) {
    final $$AssignmentFormsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assignmentForms,
        getReferencedColumn: (t) => t.form,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentFormsTableAnnotationComposer(
              $db: $db,
              $table: $db.assignmentForms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> versions<T extends Object>(
      Expression<T> Function($$FormTemplateVersionsTableAnnotationComposer a)
          f) {
    final $$FormTemplateVersionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.formTemplateVersions,
            getReferencedColumn: (t) => t.template,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FormTemplateVersionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.formTemplateVersions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> templateDataInstances<T extends Object>(
      Expression<T> Function($$DataInstancesTableAnnotationComposer a) f) {
    final $$DataInstancesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataInstances,
        getReferencedColumn: (t) => t.formTemplate,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataInstancesTableAnnotationComposer(
              $db: $db,
              $table: $db.dataInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> formPermissions<T extends Object>(
      Expression<T> Function($$UserFormPermissionsTableAnnotationComposer a)
          f) {
    final $$UserFormPermissionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.userFormPermissions,
            getReferencedColumn: (t) => t.form,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$UserFormPermissionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.userFormPermissions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$FormTemplatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FormTemplatesTable,
    FormTemplate,
    $$FormTemplatesTableFilterComposer,
    $$FormTemplatesTableOrderingComposer,
    $$FormTemplatesTableAnnotationComposer,
    $$FormTemplatesTableCreateCompanionBuilder,
    $$FormTemplatesTableUpdateCompanionBuilder,
    (FormTemplate, $$FormTemplatesTableReferences),
    FormTemplate,
    PrefetchHooks Function(
        {bool assignments,
        bool versions,
        bool templateDataInstances,
        bool formPermissions})> {
  $$FormTemplatesTableTableManager(_$AppDatabase db, $FormTemplatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FormTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FormTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FormTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> versionUid = const Value.absent(),
            Value<int> versionNumber = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool?> disabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FormTemplatesCompanion(
            id: id,
            versionUid: versionUid,
            versionNumber: versionNumber,
            name: name,
            label: label,
            description: description,
            disabled: disabled,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String versionUid,
            required int versionNumber,
            required String name,
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool?> disabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FormTemplatesCompanion.insert(
            id: id,
            versionUid: versionUid,
            versionNumber: versionNumber,
            name: name,
            label: label,
            description: description,
            disabled: disabled,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FormTemplatesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {assignments = false,
              versions = false,
              templateDataInstances = false,
              formPermissions = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (assignments) db.assignmentForms,
                if (versions) db.formTemplateVersions,
                if (templateDataInstances) db.dataInstances,
                if (formPermissions) db.userFormPermissions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (assignments)
                    await $_getPrefetchedData<FormTemplate, $FormTemplatesTable,
                            AssignmentForm>(
                        currentTable: table,
                        referencedTable: $$FormTemplatesTableReferences
                            ._assignmentsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FormTemplatesTableReferences(db, table, p0)
                                .assignments,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.form == item.id),
                        typedResults: items),
                  if (versions)
                    await $_getPrefetchedData<FormTemplate, $FormTemplatesTable,
                            FormTemplateVersion>(
                        currentTable: table,
                        referencedTable:
                            $$FormTemplatesTableReferences._versionsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FormTemplatesTableReferences(db, table, p0)
                                .versions,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.template == item.id),
                        typedResults: items),
                  if (templateDataInstances)
                    await $_getPrefetchedData<FormTemplate, $FormTemplatesTable,
                            DataInstance>(
                        currentTable: table,
                        referencedTable: $$FormTemplatesTableReferences
                            ._templateDataInstancesTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FormTemplatesTableReferences(db, table, p0)
                                .templateDataInstances,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.formTemplate == item.id),
                        typedResults: items),
                  if (formPermissions)
                    await $_getPrefetchedData<FormTemplate, $FormTemplatesTable,
                            UserFormPermission>(
                        currentTable: table,
                        referencedTable: $$FormTemplatesTableReferences
                            ._formPermissionsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FormTemplatesTableReferences(db, table, p0)
                                .formPermissions,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.form == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FormTemplatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FormTemplatesTable,
    FormTemplate,
    $$FormTemplatesTableFilterComposer,
    $$FormTemplatesTableOrderingComposer,
    $$FormTemplatesTableAnnotationComposer,
    $$FormTemplatesTableCreateCompanionBuilder,
    $$FormTemplatesTableUpdateCompanionBuilder,
    (FormTemplate, $$FormTemplatesTableReferences),
    FormTemplate,
    PrefetchHooks Function(
        {bool assignments,
        bool versions,
        bool templateDataInstances,
        bool formPermissions})>;
typedef $$AssignmentFormsTableCreateCompanionBuilder = AssignmentFormsCompanion
    Function({
  required String assignment,
  required String form,
  Value<bool?> canAddSubmissions,
  Value<bool?> canViewSubmissions,
  Value<bool?> canEditSubmissions,
  Value<bool?> canDeleteSubmissions,
  Value<int> rowid,
});
typedef $$AssignmentFormsTableUpdateCompanionBuilder = AssignmentFormsCompanion
    Function({
  Value<String> assignment,
  Value<String> form,
  Value<bool?> canAddSubmissions,
  Value<bool?> canViewSubmissions,
  Value<bool?> canEditSubmissions,
  Value<bool?> canDeleteSubmissions,
  Value<int> rowid,
});

final class $$AssignmentFormsTableReferences extends BaseReferences<
    _$AppDatabase, $AssignmentFormsTable, AssignmentForm> {
  $$AssignmentFormsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $AssignmentsTable _assignmentTable(_$AppDatabase db) =>
      db.assignments.createAlias($_aliasNameGenerator(
          db.assignmentForms.assignment, db.assignments.id));

  $$AssignmentsTableProcessedTableManager get assignment {
    final $_column = $_itemColumn<String>('assignment')!;

    final manager = $$AssignmentsTableTableManager($_db, $_db.assignments)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assignmentTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FormTemplatesTable _formTable(_$AppDatabase db) =>
      db.formTemplates.createAlias(
          $_aliasNameGenerator(db.assignmentForms.form, db.formTemplates.id));

  $$FormTemplatesTableProcessedTableManager get form {
    final $_column = $_itemColumn<String>('form')!;

    final manager = $$FormTemplatesTableTableManager($_db, $_db.formTemplates)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_formTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AssignmentFormsTableFilterComposer
    extends Composer<_$AppDatabase, $AssignmentFormsTable> {
  $$AssignmentFormsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get canAddSubmissions => $composableBuilder(
      column: $table.canAddSubmissions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get canViewSubmissions => $composableBuilder(
      column: $table.canViewSubmissions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get canEditSubmissions => $composableBuilder(
      column: $table.canEditSubmissions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get canDeleteSubmissions => $composableBuilder(
      column: $table.canDeleteSubmissions,
      builder: (column) => ColumnFilters(column));

  $$AssignmentsTableFilterComposer get assignment {
    final $$AssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignment,
        referencedTable: $db.assignments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.assignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FormTemplatesTableFilterComposer get form {
    final $$FormTemplatesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.form,
        referencedTable: $db.formTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplatesTableFilterComposer(
              $db: $db,
              $table: $db.formTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssignmentFormsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssignmentFormsTable> {
  $$AssignmentFormsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get canAddSubmissions => $composableBuilder(
      column: $table.canAddSubmissions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get canViewSubmissions => $composableBuilder(
      column: $table.canViewSubmissions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get canEditSubmissions => $composableBuilder(
      column: $table.canEditSubmissions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get canDeleteSubmissions => $composableBuilder(
      column: $table.canDeleteSubmissions,
      builder: (column) => ColumnOrderings(column));

  $$AssignmentsTableOrderingComposer get assignment {
    final $$AssignmentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignment,
        referencedTable: $db.assignments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentsTableOrderingComposer(
              $db: $db,
              $table: $db.assignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FormTemplatesTableOrderingComposer get form {
    final $$FormTemplatesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.form,
        referencedTable: $db.formTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplatesTableOrderingComposer(
              $db: $db,
              $table: $db.formTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssignmentFormsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssignmentFormsTable> {
  $$AssignmentFormsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get canAddSubmissions => $composableBuilder(
      column: $table.canAddSubmissions, builder: (column) => column);

  GeneratedColumn<bool> get canViewSubmissions => $composableBuilder(
      column: $table.canViewSubmissions, builder: (column) => column);

  GeneratedColumn<bool> get canEditSubmissions => $composableBuilder(
      column: $table.canEditSubmissions, builder: (column) => column);

  GeneratedColumn<bool> get canDeleteSubmissions => $composableBuilder(
      column: $table.canDeleteSubmissions, builder: (column) => column);

  $$AssignmentsTableAnnotationComposer get assignment {
    final $$AssignmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignment,
        referencedTable: $db.assignments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.assignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FormTemplatesTableAnnotationComposer get form {
    final $$FormTemplatesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.form,
        referencedTable: $db.formTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplatesTableAnnotationComposer(
              $db: $db,
              $table: $db.formTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssignmentFormsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AssignmentFormsTable,
    AssignmentForm,
    $$AssignmentFormsTableFilterComposer,
    $$AssignmentFormsTableOrderingComposer,
    $$AssignmentFormsTableAnnotationComposer,
    $$AssignmentFormsTableCreateCompanionBuilder,
    $$AssignmentFormsTableUpdateCompanionBuilder,
    (AssignmentForm, $$AssignmentFormsTableReferences),
    AssignmentForm,
    PrefetchHooks Function({bool assignment, bool form})> {
  $$AssignmentFormsTableTableManager(
      _$AppDatabase db, $AssignmentFormsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssignmentFormsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssignmentFormsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssignmentFormsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> assignment = const Value.absent(),
            Value<String> form = const Value.absent(),
            Value<bool?> canAddSubmissions = const Value.absent(),
            Value<bool?> canViewSubmissions = const Value.absent(),
            Value<bool?> canEditSubmissions = const Value.absent(),
            Value<bool?> canDeleteSubmissions = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AssignmentFormsCompanion(
            assignment: assignment,
            form: form,
            canAddSubmissions: canAddSubmissions,
            canViewSubmissions: canViewSubmissions,
            canEditSubmissions: canEditSubmissions,
            canDeleteSubmissions: canDeleteSubmissions,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String assignment,
            required String form,
            Value<bool?> canAddSubmissions = const Value.absent(),
            Value<bool?> canViewSubmissions = const Value.absent(),
            Value<bool?> canEditSubmissions = const Value.absent(),
            Value<bool?> canDeleteSubmissions = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AssignmentFormsCompanion.insert(
            assignment: assignment,
            form: form,
            canAddSubmissions: canAddSubmissions,
            canViewSubmissions: canViewSubmissions,
            canEditSubmissions: canEditSubmissions,
            canDeleteSubmissions: canDeleteSubmissions,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AssignmentFormsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({assignment = false, form = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (assignment) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.assignment,
                    referencedTable:
                        $$AssignmentFormsTableReferences._assignmentTable(db),
                    referencedColumn: $$AssignmentFormsTableReferences
                        ._assignmentTable(db)
                        .id,
                  ) as T;
                }
                if (form) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.form,
                    referencedTable:
                        $$AssignmentFormsTableReferences._formTable(db),
                    referencedColumn:
                        $$AssignmentFormsTableReferences._formTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AssignmentFormsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AssignmentFormsTable,
    AssignmentForm,
    $$AssignmentFormsTableFilterComposer,
    $$AssignmentFormsTableOrderingComposer,
    $$AssignmentFormsTableAnnotationComposer,
    $$AssignmentFormsTableCreateCompanionBuilder,
    $$AssignmentFormsTableUpdateCompanionBuilder,
    (AssignmentForm, $$AssignmentFormsTableReferences),
    AssignmentForm,
    PrefetchHooks Function({bool assignment, bool form})>;
typedef $$FormTemplateVersionsTableCreateCompanionBuilder
    = FormTemplateVersionsCompanion Function({
  required String id,
  required String template,
  required int versionNumber,
  required List<Template> fields,
  required List<Template> sections,
  Value<int> rowid,
});
typedef $$FormTemplateVersionsTableUpdateCompanionBuilder
    = FormTemplateVersionsCompanion Function({
  Value<String> id,
  Value<String> template,
  Value<int> versionNumber,
  Value<List<Template>> fields,
  Value<List<Template>> sections,
  Value<int> rowid,
});

final class $$FormTemplateVersionsTableReferences extends BaseReferences<
    _$AppDatabase, $FormTemplateVersionsTable, FormTemplateVersion> {
  $$FormTemplateVersionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $FormTemplatesTable _templateTable(_$AppDatabase db) =>
      db.formTemplates.createAlias($_aliasNameGenerator(
          db.formTemplateVersions.template, db.formTemplates.id));

  $$FormTemplatesTableProcessedTableManager get template {
    final $_column = $_itemColumn<String>('template')!;

    final manager = $$FormTemplatesTableTableManager($_db, $_db.formTemplates)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$DataInstancesTable, List<DataInstance>>
      _VersionDataInstancesTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.dataInstances,
              aliasName: $_aliasNameGenerator(db.formTemplateVersions.id,
                  db.dataInstances.templateVersion));

  $$DataInstancesTableProcessedTableManager get VersionDataInstances {
    final manager = $$DataInstancesTableTableManager($_db, $_db.dataInstances)
        .filter(
            (f) => f.templateVersion.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_VersionDataInstancesTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FormTemplateVersionsTableFilterComposer
    extends Composer<_$AppDatabase, $FormTemplateVersionsTable> {
  $$FormTemplateVersionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get versionNumber => $composableBuilder(
      column: $table.versionNumber, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<Template>, List<Template>, String>
      get fields => $composableBuilder(
          column: $table.fields,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<Template>, List<Template>, String>
      get sections => $composableBuilder(
          column: $table.sections,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  $$FormTemplatesTableFilterComposer get template {
    final $$FormTemplatesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.template,
        referencedTable: $db.formTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplatesTableFilterComposer(
              $db: $db,
              $table: $db.formTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> VersionDataInstances(
      Expression<bool> Function($$DataInstancesTableFilterComposer f) f) {
    final $$DataInstancesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataInstances,
        getReferencedColumn: (t) => t.templateVersion,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataInstancesTableFilterComposer(
              $db: $db,
              $table: $db.dataInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FormTemplateVersionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FormTemplateVersionsTable> {
  $$FormTemplateVersionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get versionNumber => $composableBuilder(
      column: $table.versionNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fields => $composableBuilder(
      column: $table.fields, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sections => $composableBuilder(
      column: $table.sections, builder: (column) => ColumnOrderings(column));

  $$FormTemplatesTableOrderingComposer get template {
    final $$FormTemplatesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.template,
        referencedTable: $db.formTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplatesTableOrderingComposer(
              $db: $db,
              $table: $db.formTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FormTemplateVersionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FormTemplateVersionsTable> {
  $$FormTemplateVersionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get versionNumber => $composableBuilder(
      column: $table.versionNumber, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Template>, String> get fields =>
      $composableBuilder(column: $table.fields, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Template>, String> get sections =>
      $composableBuilder(column: $table.sections, builder: (column) => column);

  $$FormTemplatesTableAnnotationComposer get template {
    final $$FormTemplatesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.template,
        referencedTable: $db.formTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplatesTableAnnotationComposer(
              $db: $db,
              $table: $db.formTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> VersionDataInstances<T extends Object>(
      Expression<T> Function($$DataInstancesTableAnnotationComposer a) f) {
    final $$DataInstancesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataInstances,
        getReferencedColumn: (t) => t.templateVersion,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataInstancesTableAnnotationComposer(
              $db: $db,
              $table: $db.dataInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FormTemplateVersionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FormTemplateVersionsTable,
    FormTemplateVersion,
    $$FormTemplateVersionsTableFilterComposer,
    $$FormTemplateVersionsTableOrderingComposer,
    $$FormTemplateVersionsTableAnnotationComposer,
    $$FormTemplateVersionsTableCreateCompanionBuilder,
    $$FormTemplateVersionsTableUpdateCompanionBuilder,
    (FormTemplateVersion, $$FormTemplateVersionsTableReferences),
    FormTemplateVersion,
    PrefetchHooks Function({bool template, bool VersionDataInstances})> {
  $$FormTemplateVersionsTableTableManager(
      _$AppDatabase db, $FormTemplateVersionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FormTemplateVersionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FormTemplateVersionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FormTemplateVersionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> template = const Value.absent(),
            Value<int> versionNumber = const Value.absent(),
            Value<List<Template>> fields = const Value.absent(),
            Value<List<Template>> sections = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FormTemplateVersionsCompanion(
            id: id,
            template: template,
            versionNumber: versionNumber,
            fields: fields,
            sections: sections,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String template,
            required int versionNumber,
            required List<Template> fields,
            required List<Template> sections,
            Value<int> rowid = const Value.absent(),
          }) =>
              FormTemplateVersionsCompanion.insert(
            id: id,
            template: template,
            versionNumber: versionNumber,
            fields: fields,
            sections: sections,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FormTemplateVersionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {template = false, VersionDataInstances = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (VersionDataInstances) db.dataInstances
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (template) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.template,
                    referencedTable: $$FormTemplateVersionsTableReferences
                        ._templateTable(db),
                    referencedColumn: $$FormTemplateVersionsTableReferences
                        ._templateTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (VersionDataInstances)
                    await $_getPrefetchedData<FormTemplateVersion,
                            $FormTemplateVersionsTable, DataInstance>(
                        currentTable: table,
                        referencedTable: $$FormTemplateVersionsTableReferences
                            ._VersionDataInstancesTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FormTemplateVersionsTableReferences(db, table, p0)
                                .VersionDataInstances,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.templateVersion == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FormTemplateVersionsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $FormTemplateVersionsTable,
        FormTemplateVersion,
        $$FormTemplateVersionsTableFilterComposer,
        $$FormTemplateVersionsTableOrderingComposer,
        $$FormTemplateVersionsTableAnnotationComposer,
        $$FormTemplateVersionsTableCreateCompanionBuilder,
        $$FormTemplateVersionsTableUpdateCompanionBuilder,
        (FormTemplateVersion, $$FormTemplateVersionsTableReferences),
        FormTemplateVersion,
        PrefetchHooks Function({bool template, bool VersionDataInstances})>;
typedef $$MetadataSubmissionsTableCreateCompanionBuilder
    = MetadataSubmissionsCompanion Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  required MetadataResourceType resourceType,
  required String metadataSchema,
  required int serialNumber,
  required int version,
  required String resourceId,
  Value<Map<String, dynamic>?> formData,
  Value<String?> createdBy,
  Value<String?> lastModifiedBy,
  Value<int> rowid,
});
typedef $$MetadataSubmissionsTableUpdateCompanionBuilder
    = MetadataSubmissionsCompanion Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<MetadataResourceType> resourceType,
  Value<String> metadataSchema,
  Value<int> serialNumber,
  Value<int> version,
  Value<String> resourceId,
  Value<Map<String, dynamic>?> formData,
  Value<String?> createdBy,
  Value<String?> lastModifiedBy,
  Value<int> rowid,
});

class $$MetadataSubmissionsTableFilterComposer
    extends Composer<_$AppDatabase, $MetadataSubmissionsTable> {
  $$MetadataSubmissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MetadataResourceType, MetadataResourceType,
          String>
      get resourceType => $composableBuilder(
          column: $table.resourceType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get metadataSchema => $composableBuilder(
      column: $table.metadataSchema,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get serialNumber => $composableBuilder(
      column: $table.serialNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get formData => $composableBuilder(
          column: $table.formData,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastModifiedBy => $composableBuilder(
      column: $table.lastModifiedBy,
      builder: (column) => ColumnFilters(column));
}

class $$MetadataSubmissionsTableOrderingComposer
    extends Composer<_$AppDatabase, $MetadataSubmissionsTable> {
  $$MetadataSubmissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resourceType => $composableBuilder(
      column: $table.resourceType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadataSchema => $composableBuilder(
      column: $table.metadataSchema,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get serialNumber => $composableBuilder(
      column: $table.serialNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get formData => $composableBuilder(
      column: $table.formData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastModifiedBy => $composableBuilder(
      column: $table.lastModifiedBy,
      builder: (column) => ColumnOrderings(column));
}

class $$MetadataSubmissionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetadataSubmissionsTable> {
  $$MetadataSubmissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MetadataResourceType, String>
      get resourceType => $composableBuilder(
          column: $table.resourceType, builder: (column) => column);

  GeneratedColumn<String> get metadataSchema => $composableBuilder(
      column: $table.metadataSchema, builder: (column) => column);

  GeneratedColumn<int> get serialNumber => $composableBuilder(
      column: $table.serialNumber, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      get formData => $composableBuilder(
          column: $table.formData, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get lastModifiedBy => $composableBuilder(
      column: $table.lastModifiedBy, builder: (column) => column);
}

class $$MetadataSubmissionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MetadataSubmissionsTable,
    MetadataSubmission,
    $$MetadataSubmissionsTableFilterComposer,
    $$MetadataSubmissionsTableOrderingComposer,
    $$MetadataSubmissionsTableAnnotationComposer,
    $$MetadataSubmissionsTableCreateCompanionBuilder,
    $$MetadataSubmissionsTableUpdateCompanionBuilder,
    (
      MetadataSubmission,
      BaseReferences<_$AppDatabase, $MetadataSubmissionsTable,
          MetadataSubmission>
    ),
    MetadataSubmission,
    PrefetchHooks Function()> {
  $$MetadataSubmissionsTableTableManager(
      _$AppDatabase db, $MetadataSubmissionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetadataSubmissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetadataSubmissionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetadataSubmissionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<MetadataResourceType> resourceType = const Value.absent(),
            Value<String> metadataSchema = const Value.absent(),
            Value<int> serialNumber = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<String> resourceId = const Value.absent(),
            Value<Map<String, dynamic>?> formData = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> lastModifiedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MetadataSubmissionsCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            resourceType: resourceType,
            metadataSchema: metadataSchema,
            serialNumber: serialNumber,
            version: version,
            resourceId: resourceId,
            formData: formData,
            createdBy: createdBy,
            lastModifiedBy: lastModifiedBy,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            required MetadataResourceType resourceType,
            required String metadataSchema,
            required int serialNumber,
            required int version,
            required String resourceId,
            Value<Map<String, dynamic>?> formData = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> lastModifiedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MetadataSubmissionsCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            resourceType: resourceType,
            metadataSchema: metadataSchema,
            serialNumber: serialNumber,
            version: version,
            resourceId: resourceId,
            formData: formData,
            createdBy: createdBy,
            lastModifiedBy: lastModifiedBy,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MetadataSubmissionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MetadataSubmissionsTable,
    MetadataSubmission,
    $$MetadataSubmissionsTableFilterComposer,
    $$MetadataSubmissionsTableOrderingComposer,
    $$MetadataSubmissionsTableAnnotationComposer,
    $$MetadataSubmissionsTableCreateCompanionBuilder,
    $$MetadataSubmissionsTableUpdateCompanionBuilder,
    (
      MetadataSubmission,
      BaseReferences<_$AppDatabase, $MetadataSubmissionsTable,
          MetadataSubmission>
    ),
    MetadataSubmission,
    PrefetchHooks Function()>;
typedef $$DataInstancesTableCreateCompanionBuilder = DataInstancesCompanion
    Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<bool> deleted,
  Value<DateTime?> deletedAt,
  required String formTemplate,
  required String templateVersion,
  Value<String?> assignment,
  Value<DateTime> startEntryTime,
  Value<DateTime?> finishedEntryTime,
  Value<Map<String, dynamic>?> formData,
  Value<DateTime?> updatedAtClient,
  required InstanceSyncStatus syncState,
  Value<DateTime?> lastSyncDate,
  Value<String?> lastSyncMessage,
  required bool isToUpdate,
  Value<int> rowid,
});
typedef $$DataInstancesTableUpdateCompanionBuilder = DataInstancesCompanion
    Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<bool> deleted,
  Value<DateTime?> deletedAt,
  Value<String> formTemplate,
  Value<String> templateVersion,
  Value<String?> assignment,
  Value<DateTime> startEntryTime,
  Value<DateTime?> finishedEntryTime,
  Value<Map<String, dynamic>?> formData,
  Value<DateTime?> updatedAtClient,
  Value<InstanceSyncStatus> syncState,
  Value<DateTime?> lastSyncDate,
  Value<String?> lastSyncMessage,
  Value<bool> isToUpdate,
  Value<int> rowid,
});

final class $$DataInstancesTableReferences
    extends BaseReferences<_$AppDatabase, $DataInstancesTable, DataInstance> {
  $$DataInstancesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $FormTemplatesTable _formTemplateTable(_$AppDatabase db) =>
      db.formTemplates.createAlias($_aliasNameGenerator(
          db.dataInstances.formTemplate, db.formTemplates.id));

  $$FormTemplatesTableProcessedTableManager get formTemplate {
    final $_column = $_itemColumn<String>('form_template')!;

    final manager = $$FormTemplatesTableTableManager($_db, $_db.formTemplates)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_formTemplateTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FormTemplateVersionsTable _templateVersionTable(_$AppDatabase db) =>
      db.formTemplateVersions.createAlias($_aliasNameGenerator(
          db.dataInstances.templateVersion, db.formTemplateVersions.id));

  $$FormTemplateVersionsTableProcessedTableManager get templateVersion {
    final $_column = $_itemColumn<String>('template_version')!;

    final manager =
        $$FormTemplateVersionsTableTableManager($_db, $_db.formTemplateVersions)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateVersionTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AssignmentsTable _assignmentTable(_$AppDatabase db) =>
      db.assignments.createAlias(
          $_aliasNameGenerator(db.dataInstances.assignment, db.assignments.id));

  $$AssignmentsTableProcessedTableManager? get assignment {
    final $_column = $_itemColumn<String>('assignment');
    if ($_column == null) return null;
    final manager = $$AssignmentsTableTableManager($_db, $_db.assignments)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assignmentTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$RepeatInstancesTable, List<RepeatInstance>>
      _repeatInstancesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.repeatInstances,
              aliasName: $_aliasNameGenerator(
                  db.dataInstances.id, db.repeatInstances.submission));

  $$RepeatInstancesTableProcessedTableManager get repeatInstancesRefs {
    final manager = $$RepeatInstancesTableTableManager(
            $_db, $_db.repeatInstances)
        .filter((f) => f.submission.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_repeatInstancesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DataValuesTable, List<DataValue>>
      _instanceValuesTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.dataValues,
              aliasName: $_aliasNameGenerator(
                  db.dataInstances.id, db.dataValues.dataInstance));

  $$DataValuesTableProcessedTableManager get instanceValues {
    final manager = $$DataValuesTableTableManager($_db, $_db.dataValues).filter(
        (f) => f.dataInstance.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_instanceValuesTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DataInstancesTableFilterComposer
    extends Composer<_$AppDatabase, $DataInstancesTable> {
  $$DataInstancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get deleted => $composableBuilder(
      column: $table.deleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startEntryTime => $composableBuilder(
      column: $table.startEntryTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get finishedEntryTime => $composableBuilder(
      column: $table.finishedEntryTime,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get formData => $composableBuilder(
          column: $table.formData,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get updatedAtClient => $composableBuilder(
      column: $table.updatedAtClient,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<InstanceSyncStatus, InstanceSyncStatus, String>
      get syncState => $composableBuilder(
          column: $table.syncState,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get lastSyncDate => $composableBuilder(
      column: $table.lastSyncDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastSyncMessage => $composableBuilder(
      column: $table.lastSyncMessage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isToUpdate => $composableBuilder(
      column: $table.isToUpdate, builder: (column) => ColumnFilters(column));

  $$FormTemplatesTableFilterComposer get formTemplate {
    final $$FormTemplatesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.formTemplate,
        referencedTable: $db.formTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplatesTableFilterComposer(
              $db: $db,
              $table: $db.formTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FormTemplateVersionsTableFilterComposer get templateVersion {
    final $$FormTemplateVersionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.templateVersion,
        referencedTable: $db.formTemplateVersions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplateVersionsTableFilterComposer(
              $db: $db,
              $table: $db.formTemplateVersions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AssignmentsTableFilterComposer get assignment {
    final $$AssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignment,
        referencedTable: $db.assignments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.assignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> repeatInstancesRefs(
      Expression<bool> Function($$RepeatInstancesTableFilterComposer f) f) {
    final $$RepeatInstancesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.repeatInstances,
        getReferencedColumn: (t) => t.submission,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RepeatInstancesTableFilterComposer(
              $db: $db,
              $table: $db.repeatInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> instanceValues(
      Expression<bool> Function($$DataValuesTableFilterComposer f) f) {
    final $$DataValuesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataValues,
        getReferencedColumn: (t) => t.dataInstance,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataValuesTableFilterComposer(
              $db: $db,
              $table: $db.dataValues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DataInstancesTableOrderingComposer
    extends Composer<_$AppDatabase, $DataInstancesTable> {
  $$DataInstancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get deleted => $composableBuilder(
      column: $table.deleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startEntryTime => $composableBuilder(
      column: $table.startEntryTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get finishedEntryTime => $composableBuilder(
      column: $table.finishedEntryTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get formData => $composableBuilder(
      column: $table.formData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAtClient => $composableBuilder(
      column: $table.updatedAtClient,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncDate => $composableBuilder(
      column: $table.lastSyncDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastSyncMessage => $composableBuilder(
      column: $table.lastSyncMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isToUpdate => $composableBuilder(
      column: $table.isToUpdate, builder: (column) => ColumnOrderings(column));

  $$FormTemplatesTableOrderingComposer get formTemplate {
    final $$FormTemplatesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.formTemplate,
        referencedTable: $db.formTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplatesTableOrderingComposer(
              $db: $db,
              $table: $db.formTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FormTemplateVersionsTableOrderingComposer get templateVersion {
    final $$FormTemplateVersionsTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.templateVersion,
            referencedTable: $db.formTemplateVersions,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FormTemplateVersionsTableOrderingComposer(
                  $db: $db,
                  $table: $db.formTemplateVersions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$AssignmentsTableOrderingComposer get assignment {
    final $$AssignmentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignment,
        referencedTable: $db.assignments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentsTableOrderingComposer(
              $db: $db,
              $table: $db.assignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DataInstancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DataInstancesTable> {
  $$DataInstancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get startEntryTime => $composableBuilder(
      column: $table.startEntryTime, builder: (column) => column);

  GeneratedColumn<DateTime> get finishedEntryTime => $composableBuilder(
      column: $table.finishedEntryTime, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      get formData => $composableBuilder(
          column: $table.formData, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAtClient => $composableBuilder(
      column: $table.updatedAtClient, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InstanceSyncStatus, String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncDate => $composableBuilder(
      column: $table.lastSyncDate, builder: (column) => column);

  GeneratedColumn<String> get lastSyncMessage => $composableBuilder(
      column: $table.lastSyncMessage, builder: (column) => column);

  GeneratedColumn<bool> get isToUpdate => $composableBuilder(
      column: $table.isToUpdate, builder: (column) => column);

  $$FormTemplatesTableAnnotationComposer get formTemplate {
    final $$FormTemplatesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.formTemplate,
        referencedTable: $db.formTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplatesTableAnnotationComposer(
              $db: $db,
              $table: $db.formTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FormTemplateVersionsTableAnnotationComposer get templateVersion {
    final $$FormTemplateVersionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.templateVersion,
            referencedTable: $db.formTemplateVersions,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FormTemplateVersionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.formTemplateVersions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$AssignmentsTableAnnotationComposer get assignment {
    final $$AssignmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignment,
        referencedTable: $db.assignments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssignmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.assignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> repeatInstancesRefs<T extends Object>(
      Expression<T> Function($$RepeatInstancesTableAnnotationComposer a) f) {
    final $$RepeatInstancesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.repeatInstances,
        getReferencedColumn: (t) => t.submission,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RepeatInstancesTableAnnotationComposer(
              $db: $db,
              $table: $db.repeatInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> instanceValues<T extends Object>(
      Expression<T> Function($$DataValuesTableAnnotationComposer a) f) {
    final $$DataValuesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataValues,
        getReferencedColumn: (t) => t.dataInstance,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataValuesTableAnnotationComposer(
              $db: $db,
              $table: $db.dataValues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DataInstancesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DataInstancesTable,
    DataInstance,
    $$DataInstancesTableFilterComposer,
    $$DataInstancesTableOrderingComposer,
    $$DataInstancesTableAnnotationComposer,
    $$DataInstancesTableCreateCompanionBuilder,
    $$DataInstancesTableUpdateCompanionBuilder,
    (DataInstance, $$DataInstancesTableReferences),
    DataInstance,
    PrefetchHooks Function(
        {bool formTemplate,
        bool templateVersion,
        bool assignment,
        bool repeatInstancesRefs,
        bool instanceValues})> {
  $$DataInstancesTableTableManager(_$AppDatabase db, $DataInstancesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DataInstancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DataInstancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DataInstancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<bool> deleted = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> formTemplate = const Value.absent(),
            Value<String> templateVersion = const Value.absent(),
            Value<String?> assignment = const Value.absent(),
            Value<DateTime> startEntryTime = const Value.absent(),
            Value<DateTime?> finishedEntryTime = const Value.absent(),
            Value<Map<String, dynamic>?> formData = const Value.absent(),
            Value<DateTime?> updatedAtClient = const Value.absent(),
            Value<InstanceSyncStatus> syncState = const Value.absent(),
            Value<DateTime?> lastSyncDate = const Value.absent(),
            Value<String?> lastSyncMessage = const Value.absent(),
            Value<bool> isToUpdate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DataInstancesCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            deleted: deleted,
            deletedAt: deletedAt,
            formTemplate: formTemplate,
            templateVersion: templateVersion,
            assignment: assignment,
            startEntryTime: startEntryTime,
            finishedEntryTime: finishedEntryTime,
            formData: formData,
            updatedAtClient: updatedAtClient,
            syncState: syncState,
            lastSyncDate: lastSyncDate,
            lastSyncMessage: lastSyncMessage,
            isToUpdate: isToUpdate,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<bool> deleted = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String formTemplate,
            required String templateVersion,
            Value<String?> assignment = const Value.absent(),
            Value<DateTime> startEntryTime = const Value.absent(),
            Value<DateTime?> finishedEntryTime = const Value.absent(),
            Value<Map<String, dynamic>?> formData = const Value.absent(),
            Value<DateTime?> updatedAtClient = const Value.absent(),
            required InstanceSyncStatus syncState,
            Value<DateTime?> lastSyncDate = const Value.absent(),
            Value<String?> lastSyncMessage = const Value.absent(),
            required bool isToUpdate,
            Value<int> rowid = const Value.absent(),
          }) =>
              DataInstancesCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            deleted: deleted,
            deletedAt: deletedAt,
            formTemplate: formTemplate,
            templateVersion: templateVersion,
            assignment: assignment,
            startEntryTime: startEntryTime,
            finishedEntryTime: finishedEntryTime,
            formData: formData,
            updatedAtClient: updatedAtClient,
            syncState: syncState,
            lastSyncDate: lastSyncDate,
            lastSyncMessage: lastSyncMessage,
            isToUpdate: isToUpdate,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DataInstancesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {formTemplate = false,
              templateVersion = false,
              assignment = false,
              repeatInstancesRefs = false,
              instanceValues = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (repeatInstancesRefs) db.repeatInstances,
                if (instanceValues) db.dataValues
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (formTemplate) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.formTemplate,
                    referencedTable:
                        $$DataInstancesTableReferences._formTemplateTable(db),
                    referencedColumn: $$DataInstancesTableReferences
                        ._formTemplateTable(db)
                        .id,
                  ) as T;
                }
                if (templateVersion) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.templateVersion,
                    referencedTable: $$DataInstancesTableReferences
                        ._templateVersionTable(db),
                    referencedColumn: $$DataInstancesTableReferences
                        ._templateVersionTable(db)
                        .id,
                  ) as T;
                }
                if (assignment) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.assignment,
                    referencedTable:
                        $$DataInstancesTableReferences._assignmentTable(db),
                    referencedColumn:
                        $$DataInstancesTableReferences._assignmentTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (repeatInstancesRefs)
                    await $_getPrefetchedData<DataInstance, $DataInstancesTable, RepeatInstance>(
                        currentTable: table,
                        referencedTable: $$DataInstancesTableReferences
                            ._repeatInstancesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DataInstancesTableReferences(db, table, p0)
                                .repeatInstancesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.submission == item.id),
                        typedResults: items),
                  if (instanceValues)
                    await $_getPrefetchedData<DataInstance, $DataInstancesTable,
                            DataValue>(
                        currentTable: table,
                        referencedTable: $$DataInstancesTableReferences
                            ._instanceValuesTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DataInstancesTableReferences(db, table, p0)
                                .instanceValues,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.dataInstance == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DataInstancesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DataInstancesTable,
    DataInstance,
    $$DataInstancesTableFilterComposer,
    $$DataInstancesTableOrderingComposer,
    $$DataInstancesTableAnnotationComposer,
    $$DataInstancesTableCreateCompanionBuilder,
    $$DataInstancesTableUpdateCompanionBuilder,
    (DataInstance, $$DataInstancesTableReferences),
    DataInstance,
    PrefetchHooks Function(
        {bool formTemplate,
        bool templateVersion,
        bool assignment,
        bool repeatInstancesRefs,
        bool instanceValues})>;
typedef $$RepeatInstancesTableCreateCompanionBuilder = RepeatInstancesCompanion
    Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  required String templatePath,
  required String submission,
  Value<String?> parent,
  required int repeatIndex,
  Value<int> rowid,
});
typedef $$RepeatInstancesTableUpdateCompanionBuilder = RepeatInstancesCompanion
    Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String> templatePath,
  Value<String> submission,
  Value<String?> parent,
  Value<int> repeatIndex,
  Value<int> rowid,
});

final class $$RepeatInstancesTableReferences extends BaseReferences<
    _$AppDatabase, $RepeatInstancesTable, RepeatInstance> {
  $$RepeatInstancesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DataInstancesTable _submissionTable(_$AppDatabase db) =>
      db.dataInstances.createAlias($_aliasNameGenerator(
          db.repeatInstances.submission, db.dataInstances.id));

  $$DataInstancesTableProcessedTableManager get submission {
    final $_column = $_itemColumn<String>('submission')!;

    final manager = $$DataInstancesTableTableManager($_db, $_db.dataInstances)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_submissionTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RepeatInstancesTable _parentTable(_$AppDatabase db) =>
      db.repeatInstances.createAlias($_aliasNameGenerator(
          db.repeatInstances.parent, db.repeatInstances.id));

  $$RepeatInstancesTableProcessedTableManager? get parent {
    final $_column = $_itemColumn<String>('parent');
    if ($_column == null) return null;
    final manager =
        $$RepeatInstancesTableTableManager($_db, $_db.repeatInstances)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RepeatInstancesTableFilterComposer
    extends Composer<_$AppDatabase, $RepeatInstancesTable> {
  $$RepeatInstancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get templatePath => $composableBuilder(
      column: $table.repeatPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get repeatIndex => $composableBuilder(
      column: $table.repeatIndex, builder: (column) => ColumnFilters(column));

  $$DataInstancesTableFilterComposer get submission {
    final $$DataInstancesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.submission,
        referencedTable: $db.dataInstances,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataInstancesTableFilterComposer(
              $db: $db,
              $table: $db.dataInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RepeatInstancesTableFilterComposer get parent {
    final $$RepeatInstancesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.repeatInstances,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RepeatInstancesTableFilterComposer(
              $db: $db,
              $table: $db.repeatInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RepeatInstancesTableOrderingComposer
    extends Composer<_$AppDatabase, $RepeatInstancesTable> {
  $$RepeatInstancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get templatePath => $composableBuilder(
      column: $table.repeatPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get repeatIndex => $composableBuilder(
      column: $table.repeatIndex, builder: (column) => ColumnOrderings(column));

  $$DataInstancesTableOrderingComposer get submission {
    final $$DataInstancesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.submission,
        referencedTable: $db.dataInstances,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataInstancesTableOrderingComposer(
              $db: $db,
              $table: $db.dataInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RepeatInstancesTableOrderingComposer get parent {
    final $$RepeatInstancesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.repeatInstances,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RepeatInstancesTableOrderingComposer(
              $db: $db,
              $table: $db.repeatInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RepeatInstancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepeatInstancesTable> {
  $$RepeatInstancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<String> get templatePath => $composableBuilder(
      column: $table.repeatPath, builder: (column) => column);

  GeneratedColumn<int> get repeatIndex => $composableBuilder(
      column: $table.repeatIndex, builder: (column) => column);

  $$DataInstancesTableAnnotationComposer get submission {
    final $$DataInstancesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.submission,
        referencedTable: $db.dataInstances,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataInstancesTableAnnotationComposer(
              $db: $db,
              $table: $db.dataInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RepeatInstancesTableAnnotationComposer get parent {
    final $$RepeatInstancesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.repeatInstances,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RepeatInstancesTableAnnotationComposer(
              $db: $db,
              $table: $db.repeatInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RepeatInstancesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RepeatInstancesTable,
    RepeatInstance,
    $$RepeatInstancesTableFilterComposer,
    $$RepeatInstancesTableOrderingComposer,
    $$RepeatInstancesTableAnnotationComposer,
    $$RepeatInstancesTableCreateCompanionBuilder,
    $$RepeatInstancesTableUpdateCompanionBuilder,
    (RepeatInstance, $$RepeatInstancesTableReferences),
    RepeatInstance,
    PrefetchHooks Function({bool submission, bool parent})> {
  $$RepeatInstancesTableTableManager(
      _$AppDatabase db, $RepeatInstancesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepeatInstancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepeatInstancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepeatInstancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String> templatePath = const Value.absent(),
            Value<String> submission = const Value.absent(),
            Value<String?> parent = const Value.absent(),
            Value<int> repeatIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RepeatInstancesCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            templatePath: templatePath,
            submission: submission,
            parent: parent,
            repeatIndex: repeatIndex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            required String templatePath,
            required String submission,
            Value<String?> parent = const Value.absent(),
            required int repeatIndex,
            Value<int> rowid = const Value.absent(),
          }) =>
              RepeatInstancesCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            templatePath: templatePath,
            submission: submission,
            parent: parent,
            repeatIndex: repeatIndex,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RepeatInstancesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({submission = false, parent = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (submission) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.submission,
                    referencedTable:
                        $$RepeatInstancesTableReferences._submissionTable(db),
                    referencedColumn: $$RepeatInstancesTableReferences
                        ._submissionTable(db)
                        .id,
                  ) as T;
                }
                if (parent) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parent,
                    referencedTable:
                        $$RepeatInstancesTableReferences._parentTable(db),
                    referencedColumn:
                        $$RepeatInstancesTableReferences._parentTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RepeatInstancesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RepeatInstancesTable,
    RepeatInstance,
    $$RepeatInstancesTableFilterComposer,
    $$RepeatInstancesTableOrderingComposer,
    $$RepeatInstancesTableAnnotationComposer,
    $$RepeatInstancesTableCreateCompanionBuilder,
    $$RepeatInstancesTableUpdateCompanionBuilder,
    (RepeatInstance, $$RepeatInstancesTableReferences),
    RepeatInstance,
    PrefetchHooks Function({bool submission, bool parent})>;
typedef $$DataOptionSetsTableCreateCompanionBuilder = DataOptionSetsCompanion
    Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  required String name,
  Value<String?> code,
  Value<int> rowid,
});
typedef $$DataOptionSetsTableUpdateCompanionBuilder = DataOptionSetsCompanion
    Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  Value<String> name,
  Value<String?> code,
  Value<int> rowid,
});

final class $$DataOptionSetsTableReferences
    extends BaseReferences<_$AppDatabase, $DataOptionSetsTable, DataOptionSet> {
  $$DataOptionSetsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DataElementsTable, List<DataElement>>
      _dataElementsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.dataElements,
              aliasName: $_aliasNameGenerator(
                  db.dataOptionSets.id, db.dataElements.optionSet));

  $$DataElementsTableProcessedTableManager get dataElementsRefs {
    final manager = $$DataElementsTableTableManager($_db, $_db.dataElements)
        .filter((f) => f.optionSet.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_dataElementsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DataOptionsTable, List<DataOption>> _optionsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.dataOptions,
          aliasName: $_aliasNameGenerator(
              db.dataOptionSets.id, db.dataOptions.optionSet));

  $$DataOptionsTableProcessedTableManager get options {
    final manager = $$DataOptionsTableTableManager($_db, $_db.dataOptions)
        .filter((f) => f.optionSet.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_optionsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DataOptionSetsTableFilterComposer
    extends Composer<_$AppDatabase, $DataOptionSetsTable> {
  $$DataOptionSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get label => $composableBuilder(
          column: $table.label,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<Translation>, List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  Expression<bool> dataElementsRefs(
      Expression<bool> Function($$DataElementsTableFilterComposer f) f) {
    final $$DataElementsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataElements,
        getReferencedColumn: (t) => t.optionSet,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataElementsTableFilterComposer(
              $db: $db,
              $table: $db.dataElements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> options(
      Expression<bool> Function($$DataOptionsTableFilterComposer f) f) {
    final $$DataOptionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataOptions,
        getReferencedColumn: (t) => t.optionSet,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataOptionsTableFilterComposer(
              $db: $db,
              $table: $db.dataOptions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DataOptionSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $DataOptionSetsTable> {
  $$DataOptionSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translations => $composableBuilder(
      column: $table.translations,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));
}

class $$DataOptionSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DataOptionSetsTable> {
  $$DataOptionSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  Expression<T> dataElementsRefs<T extends Object>(
      Expression<T> Function($$DataElementsTableAnnotationComposer a) f) {
    final $$DataElementsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataElements,
        getReferencedColumn: (t) => t.optionSet,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataElementsTableAnnotationComposer(
              $db: $db,
              $table: $db.dataElements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> options<T extends Object>(
      Expression<T> Function($$DataOptionsTableAnnotationComposer a) f) {
    final $$DataOptionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataOptions,
        getReferencedColumn: (t) => t.optionSet,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataOptionsTableAnnotationComposer(
              $db: $db,
              $table: $db.dataOptions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DataOptionSetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DataOptionSetsTable,
    DataOptionSet,
    $$DataOptionSetsTableFilterComposer,
    $$DataOptionSetsTableOrderingComposer,
    $$DataOptionSetsTableAnnotationComposer,
    $$DataOptionSetsTableCreateCompanionBuilder,
    $$DataOptionSetsTableUpdateCompanionBuilder,
    (DataOptionSet, $$DataOptionSetsTableReferences),
    DataOptionSet,
    PrefetchHooks Function({bool dataElementsRefs, bool options})> {
  $$DataOptionSetsTableTableManager(
      _$AppDatabase db, $DataOptionSetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DataOptionSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DataOptionSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DataOptionSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DataOptionSetsCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            required String name,
            Value<String?> code = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DataOptionSetsCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DataOptionSetsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({dataElementsRefs = false, options = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (dataElementsRefs) db.dataElements,
                if (options) db.dataOptions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dataElementsRefs)
                    await $_getPrefetchedData<DataOptionSet,
                            $DataOptionSetsTable, DataElement>(
                        currentTable: table,
                        referencedTable: $$DataOptionSetsTableReferences
                            ._dataElementsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DataOptionSetsTableReferences(db, table, p0)
                                .dataElementsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.optionSet == item.id),
                        typedResults: items),
                  if (options)
                    await $_getPrefetchedData<DataOptionSet,
                            $DataOptionSetsTable, DataOption>(
                        currentTable: table,
                        referencedTable:
                            $$DataOptionSetsTableReferences._optionsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DataOptionSetsTableReferences(db, table, p0)
                                .options,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.optionSet == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DataOptionSetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DataOptionSetsTable,
    DataOptionSet,
    $$DataOptionSetsTableFilterComposer,
    $$DataOptionSetsTableOrderingComposer,
    $$DataOptionSetsTableAnnotationComposer,
    $$DataOptionSetsTableCreateCompanionBuilder,
    $$DataOptionSetsTableUpdateCompanionBuilder,
    (DataOptionSet, $$DataOptionSetsTableReferences),
    DataOptionSet,
    PrefetchHooks Function({bool dataElementsRefs, bool options})>;
typedef $$DataElementsTableCreateCompanionBuilder = DataElementsCompanion
    Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  required String name,
  Value<String?> code,
  Value<String?> description,
  required ValueType type,
  Value<String?> optionSet,
  Value<bool?> mandatory,
  Value<String?> defaultValue,
  Value<ScannedCodeProperties?> scannedCodeProperties,
  Value<bool?> gs1Enabled,
  Value<MetadataResourceType?> resourceType,
  Value<String?> resourceMetadataSchema,
  Value<int> rowid,
});
typedef $$DataElementsTableUpdateCompanionBuilder = DataElementsCompanion
    Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  Value<String> name,
  Value<String?> code,
  Value<String?> description,
  Value<ValueType> type,
  Value<String?> optionSet,
  Value<bool?> mandatory,
  Value<String?> defaultValue,
  Value<ScannedCodeProperties?> scannedCodeProperties,
  Value<bool?> gs1Enabled,
  Value<MetadataResourceType?> resourceType,
  Value<String?> resourceMetadataSchema,
  Value<int> rowid,
});

final class $$DataElementsTableReferences
    extends BaseReferences<_$AppDatabase, $DataElementsTable, DataElement> {
  $$DataElementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DataOptionSetsTable _optionSetTable(_$AppDatabase db) =>
      db.dataOptionSets.createAlias($_aliasNameGenerator(
          db.dataElements.optionSet, db.dataOptionSets.id));

  $$DataOptionSetsTableProcessedTableManager? get optionSet {
    final $_column = $_itemColumn<String>('option_set');
    if ($_column == null) return null;
    final manager = $$DataOptionSetsTableTableManager($_db, $_db.dataOptionSets)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_optionSetTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$DataValuesTable, List<DataValue>>
      _dataValuesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.dataValues,
              aliasName: $_aliasNameGenerator(
                  db.dataElements.id, db.dataValues.dataElement));

  $$DataValuesTableProcessedTableManager get dataValuesRefs {
    final manager = $$DataValuesTableTableManager($_db, $_db.dataValues)
        .filter((f) => f.dataElement.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_dataValuesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DataElementsTableFilterComposer
    extends Composer<_$AppDatabase, $DataElementsTable> {
  $$DataElementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get label => $composableBuilder(
          column: $table.label,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<Translation>, List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ValueType, ValueType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get mandatory => $composableBuilder(
      column: $table.mandatory, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get defaultValue => $composableBuilder(
      column: $table.defaultValue, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ScannedCodeProperties?, ScannedCodeProperties,
          String>
      get scannedCodeProperties => $composableBuilder(
          column: $table.scannedCodeProperties,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get gs1Enabled => $composableBuilder(
      column: $table.gs1Enabled, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MetadataResourceType?, MetadataResourceType,
          String>
      get resourceType => $composableBuilder(
          column: $table.resourceType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get resourceMetadataSchema => $composableBuilder(
      column: $table.resourceMetadataSchema,
      builder: (column) => ColumnFilters(column));

  $$DataOptionSetsTableFilterComposer get optionSet {
    final $$DataOptionSetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.optionSet,
        referencedTable: $db.dataOptionSets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataOptionSetsTableFilterComposer(
              $db: $db,
              $table: $db.dataOptionSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> dataValuesRefs(
      Expression<bool> Function($$DataValuesTableFilterComposer f) f) {
    final $$DataValuesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataValues,
        getReferencedColumn: (t) => t.dataElement,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataValuesTableFilterComposer(
              $db: $db,
              $table: $db.dataValues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DataElementsTableOrderingComposer
    extends Composer<_$AppDatabase, $DataElementsTable> {
  $$DataElementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translations => $composableBuilder(
      column: $table.translations,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get mandatory => $composableBuilder(
      column: $table.mandatory, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get defaultValue => $composableBuilder(
      column: $table.defaultValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scannedCodeProperties => $composableBuilder(
      column: $table.scannedCodeProperties,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get gs1Enabled => $composableBuilder(
      column: $table.gs1Enabled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resourceType => $composableBuilder(
      column: $table.resourceType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resourceMetadataSchema => $composableBuilder(
      column: $table.resourceMetadataSchema,
      builder: (column) => ColumnOrderings(column));

  $$DataOptionSetsTableOrderingComposer get optionSet {
    final $$DataOptionSetsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.optionSet,
        referencedTable: $db.dataOptionSets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataOptionSetsTableOrderingComposer(
              $db: $db,
              $table: $db.dataOptionSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DataElementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DataElementsTable> {
  $$DataElementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ValueType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get mandatory =>
      $composableBuilder(column: $table.mandatory, builder: (column) => column);

  GeneratedColumn<String> get defaultValue => $composableBuilder(
      column: $table.defaultValue, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ScannedCodeProperties?, String>
      get scannedCodeProperties => $composableBuilder(
          column: $table.scannedCodeProperties, builder: (column) => column);

  GeneratedColumn<bool> get gs1Enabled => $composableBuilder(
      column: $table.gs1Enabled, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MetadataResourceType?, String>
      get resourceType => $composableBuilder(
          column: $table.resourceType, builder: (column) => column);

  GeneratedColumn<String> get resourceMetadataSchema => $composableBuilder(
      column: $table.resourceMetadataSchema, builder: (column) => column);

  $$DataOptionSetsTableAnnotationComposer get optionSet {
    final $$DataOptionSetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.optionSet,
        referencedTable: $db.dataOptionSets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataOptionSetsTableAnnotationComposer(
              $db: $db,
              $table: $db.dataOptionSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> dataValuesRefs<T extends Object>(
      Expression<T> Function($$DataValuesTableAnnotationComposer a) f) {
    final $$DataValuesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dataValues,
        getReferencedColumn: (t) => t.dataElement,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataValuesTableAnnotationComposer(
              $db: $db,
              $table: $db.dataValues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DataElementsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DataElementsTable,
    DataElement,
    $$DataElementsTableFilterComposer,
    $$DataElementsTableOrderingComposer,
    $$DataElementsTableAnnotationComposer,
    $$DataElementsTableCreateCompanionBuilder,
    $$DataElementsTableUpdateCompanionBuilder,
    (DataElement, $$DataElementsTableReferences),
    DataElement,
    PrefetchHooks Function({bool optionSet, bool dataValuesRefs})> {
  $$DataElementsTableTableManager(_$AppDatabase db, $DataElementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DataElementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DataElementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DataElementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<ValueType> type = const Value.absent(),
            Value<String?> optionSet = const Value.absent(),
            Value<bool?> mandatory = const Value.absent(),
            Value<String?> defaultValue = const Value.absent(),
            Value<ScannedCodeProperties?> scannedCodeProperties =
                const Value.absent(),
            Value<bool?> gs1Enabled = const Value.absent(),
            Value<MetadataResourceType?> resourceType = const Value.absent(),
            Value<String?> resourceMetadataSchema = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DataElementsCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            description: description,
            type: type,
            optionSet: optionSet,
            mandatory: mandatory,
            defaultValue: defaultValue,
            scannedCodeProperties: scannedCodeProperties,
            gs1Enabled: gs1Enabled,
            resourceType: resourceType,
            resourceMetadataSchema: resourceMetadataSchema,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            required String name,
            Value<String?> code = const Value.absent(),
            Value<String?> description = const Value.absent(),
            required ValueType type,
            Value<String?> optionSet = const Value.absent(),
            Value<bool?> mandatory = const Value.absent(),
            Value<String?> defaultValue = const Value.absent(),
            Value<ScannedCodeProperties?> scannedCodeProperties =
                const Value.absent(),
            Value<bool?> gs1Enabled = const Value.absent(),
            Value<MetadataResourceType?> resourceType = const Value.absent(),
            Value<String?> resourceMetadataSchema = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DataElementsCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            description: description,
            type: type,
            optionSet: optionSet,
            mandatory: mandatory,
            defaultValue: defaultValue,
            scannedCodeProperties: scannedCodeProperties,
            gs1Enabled: gs1Enabled,
            resourceType: resourceType,
            resourceMetadataSchema: resourceMetadataSchema,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DataElementsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({optionSet = false, dataValuesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (dataValuesRefs) db.dataValues],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (optionSet) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.optionSet,
                    referencedTable:
                        $$DataElementsTableReferences._optionSetTable(db),
                    referencedColumn:
                        $$DataElementsTableReferences._optionSetTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dataValuesRefs)
                    await $_getPrefetchedData<DataElement, $DataElementsTable,
                            DataValue>(
                        currentTable: table,
                        referencedTable: $$DataElementsTableReferences
                            ._dataValuesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DataElementsTableReferences(db, table, p0)
                                .dataValuesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.dataElement == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DataElementsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DataElementsTable,
    DataElement,
    $$DataElementsTableFilterComposer,
    $$DataElementsTableOrderingComposer,
    $$DataElementsTableAnnotationComposer,
    $$DataElementsTableCreateCompanionBuilder,
    $$DataElementsTableUpdateCompanionBuilder,
    (DataElement, $$DataElementsTableReferences),
    DataElement,
    PrefetchHooks Function({bool optionSet, bool dataValuesRefs})>;
typedef $$DataValuesTableCreateCompanionBuilder = DataValuesCompanion Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  required String dataElement,
  required String dataInstance,
  Value<String?> value,
  Value<String?> comment,
  Value<int> rowid,
});
typedef $$DataValuesTableUpdateCompanionBuilder = DataValuesCompanion Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String> dataElement,
  Value<String> dataInstance,
  Value<String?> value,
  Value<String?> comment,
  Value<int> rowid,
});

final class $$DataValuesTableReferences
    extends BaseReferences<_$AppDatabase, $DataValuesTable, DataValue> {
  $$DataValuesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DataElementsTable _dataElementTable(_$AppDatabase db) =>
      db.dataElements.createAlias(
          $_aliasNameGenerator(db.dataValues.dataElement, db.dataElements.id));

  $$DataElementsTableProcessedTableManager get dataElement {
    final $_column = $_itemColumn<String>('data_element')!;

    final manager = $$DataElementsTableTableManager($_db, $_db.dataElements)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dataElementTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $DataInstancesTable _dataInstanceTable(_$AppDatabase db) =>
      db.dataInstances.createAlias($_aliasNameGenerator(
          db.dataValues.dataInstance, db.dataInstances.id));

  $$DataInstancesTableProcessedTableManager get dataInstance {
    final $_column = $_itemColumn<String>('data_instance')!;

    final manager = $$DataInstancesTableTableManager($_db, $_db.dataInstances)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dataInstanceTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DataValuesTableFilterComposer
    extends Composer<_$AppDatabase, $DataValuesTable> {
  $$DataValuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get comment => $composableBuilder(
      column: $table.comment, builder: (column) => ColumnFilters(column));

  $$DataElementsTableFilterComposer get dataElement {
    final $$DataElementsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dataElement,
        referencedTable: $db.dataElements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataElementsTableFilterComposer(
              $db: $db,
              $table: $db.dataElements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DataInstancesTableFilterComposer get dataInstance {
    final $$DataInstancesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dataInstance,
        referencedTable: $db.dataInstances,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataInstancesTableFilterComposer(
              $db: $db,
              $table: $db.dataInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DataValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $DataValuesTable> {
  $$DataValuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get comment => $composableBuilder(
      column: $table.comment, builder: (column) => ColumnOrderings(column));

  $$DataElementsTableOrderingComposer get dataElement {
    final $$DataElementsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dataElement,
        referencedTable: $db.dataElements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataElementsTableOrderingComposer(
              $db: $db,
              $table: $db.dataElements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DataInstancesTableOrderingComposer get dataInstance {
    final $$DataInstancesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dataInstance,
        referencedTable: $db.dataInstances,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataInstancesTableOrderingComposer(
              $db: $db,
              $table: $db.dataInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DataValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DataValuesTable> {
  $$DataValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  $$DataElementsTableAnnotationComposer get dataElement {
    final $$DataElementsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dataElement,
        referencedTable: $db.dataElements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataElementsTableAnnotationComposer(
              $db: $db,
              $table: $db.dataElements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DataInstancesTableAnnotationComposer get dataInstance {
    final $$DataInstancesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dataInstance,
        referencedTable: $db.dataInstances,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataInstancesTableAnnotationComposer(
              $db: $db,
              $table: $db.dataInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DataValuesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DataValuesTable,
    DataValue,
    $$DataValuesTableFilterComposer,
    $$DataValuesTableOrderingComposer,
    $$DataValuesTableAnnotationComposer,
    $$DataValuesTableCreateCompanionBuilder,
    $$DataValuesTableUpdateCompanionBuilder,
    (DataValue, $$DataValuesTableReferences),
    DataValue,
    PrefetchHooks Function({bool dataElement, bool dataInstance})> {
  $$DataValuesTableTableManager(_$AppDatabase db, $DataValuesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DataValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DataValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DataValuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String> dataElement = const Value.absent(),
            Value<String> dataInstance = const Value.absent(),
            Value<String?> value = const Value.absent(),
            Value<String?> comment = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DataValuesCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            dataElement: dataElement,
            dataInstance: dataInstance,
            value: value,
            comment: comment,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            required String dataElement,
            required String dataInstance,
            Value<String?> value = const Value.absent(),
            Value<String?> comment = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DataValuesCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            dataElement: dataElement,
            dataInstance: dataInstance,
            value: value,
            comment: comment,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DataValuesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({dataElement = false, dataInstance = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (dataElement) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dataElement,
                    referencedTable:
                        $$DataValuesTableReferences._dataElementTable(db),
                    referencedColumn:
                        $$DataValuesTableReferences._dataElementTable(db).id,
                  ) as T;
                }
                if (dataInstance) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dataInstance,
                    referencedTable:
                        $$DataValuesTableReferences._dataInstanceTable(db),
                    referencedColumn:
                        $$DataValuesTableReferences._dataInstanceTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DataValuesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DataValuesTable,
    DataValue,
    $$DataValuesTableFilterComposer,
    $$DataValuesTableOrderingComposer,
    $$DataValuesTableAnnotationComposer,
    $$DataValuesTableCreateCompanionBuilder,
    $$DataValuesTableUpdateCompanionBuilder,
    (DataValue, $$DataValuesTableReferences),
    DataValue,
    PrefetchHooks Function({bool dataElement, bool dataInstance})>;
typedef $$DataOptionsTableCreateCompanionBuilder = DataOptionsCompanion
    Function({
  required String id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  required String name,
  required String code,
  required String optionSet,
  Value<int> order,
  Value<int> rowid,
});
typedef $$DataOptionsTableUpdateCompanionBuilder = DataOptionsCompanion
    Function({
  Value<String> id,
  Value<DateTime?> lastModifiedDate,
  Value<DateTime?> createdDate,
  Value<String?> displayName,
  Value<Map<String, dynamic>?> label,
  Value<List<Translation>> translations,
  Value<String> name,
  Value<String> code,
  Value<String> optionSet,
  Value<int> order,
  Value<int> rowid,
});

final class $$DataOptionsTableReferences
    extends BaseReferences<_$AppDatabase, $DataOptionsTable, DataOption> {
  $$DataOptionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DataOptionSetsTable _optionSetTable(_$AppDatabase db) =>
      db.dataOptionSets.createAlias(
          $_aliasNameGenerator(db.dataOptions.optionSet, db.dataOptionSets.id));

  $$DataOptionSetsTableProcessedTableManager get optionSet {
    final $_column = $_itemColumn<String>('option_set')!;

    final manager = $$DataOptionSetsTableTableManager($_db, $_db.dataOptionSets)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_optionSetTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DataOptionsTableFilterComposer
    extends Composer<_$AppDatabase, $DataOptionsTable> {
  $$DataOptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get label => $composableBuilder(
          column: $table.label,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<Translation>, List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  $$DataOptionSetsTableFilterComposer get optionSet {
    final $$DataOptionSetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.optionSet,
        referencedTable: $db.dataOptionSets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataOptionSetsTableFilterComposer(
              $db: $db,
              $table: $db.dataOptionSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DataOptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $DataOptionsTable> {
  $$DataOptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translations => $composableBuilder(
      column: $table.translations,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  $$DataOptionSetsTableOrderingComposer get optionSet {
    final $$DataOptionSetsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.optionSet,
        referencedTable: $db.dataOptionSets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataOptionSetsTableOrderingComposer(
              $db: $db,
              $table: $db.dataOptionSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DataOptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DataOptionsTable> {
  $$DataOptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedDate => $composableBuilder(
      column: $table.lastModifiedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
      column: $table.createdDate, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Translation>, String>
      get translations => $composableBuilder(
          column: $table.translations, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$DataOptionSetsTableAnnotationComposer get optionSet {
    final $$DataOptionSetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.optionSet,
        referencedTable: $db.dataOptionSets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DataOptionSetsTableAnnotationComposer(
              $db: $db,
              $table: $db.dataOptionSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DataOptionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DataOptionsTable,
    DataOption,
    $$DataOptionsTableFilterComposer,
    $$DataOptionsTableOrderingComposer,
    $$DataOptionsTableAnnotationComposer,
    $$DataOptionsTableCreateCompanionBuilder,
    $$DataOptionsTableUpdateCompanionBuilder,
    (DataOption, $$DataOptionsTableReferences),
    DataOption,
    PrefetchHooks Function({bool optionSet})> {
  $$DataOptionsTableTableManager(_$AppDatabase db, $DataOptionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DataOptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DataOptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DataOptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> optionSet = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DataOptionsCompanion(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            optionSet: optionSet,
            order: order,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> lastModifiedDate = const Value.absent(),
            Value<DateTime?> createdDate = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<Map<String, dynamic>?> label = const Value.absent(),
            Value<List<Translation>> translations = const Value.absent(),
            required String name,
            required String code,
            required String optionSet,
            Value<int> order = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DataOptionsCompanion.insert(
            id: id,
            lastModifiedDate: lastModifiedDate,
            createdDate: createdDate,
            displayName: displayName,
            label: label,
            translations: translations,
            name: name,
            code: code,
            optionSet: optionSet,
            order: order,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DataOptionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({optionSet = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (optionSet) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.optionSet,
                    referencedTable:
                        $$DataOptionsTableReferences._optionSetTable(db),
                    referencedColumn:
                        $$DataOptionsTableReferences._optionSetTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DataOptionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DataOptionsTable,
    DataOption,
    $$DataOptionsTableFilterComposer,
    $$DataOptionsTableOrderingComposer,
    $$DataOptionsTableAnnotationComposer,
    $$DataOptionsTableCreateCompanionBuilder,
    $$DataOptionsTableUpdateCompanionBuilder,
    (DataOption, $$DataOptionsTableReferences),
    DataOption,
    PrefetchHooks Function({bool optionSet})>;
typedef $$UserFormPermissionsTableCreateCompanionBuilder
    = UserFormPermissionsCompanion Function({
  required String team,
  required String form,
  Value<DateTime?> validFrom,
  Value<DateTime?> validTo,
  required List<FormPermission> permissions,
  Value<int> rowid,
});
typedef $$UserFormPermissionsTableUpdateCompanionBuilder
    = UserFormPermissionsCompanion Function({
  Value<String> team,
  Value<String> form,
  Value<DateTime?> validFrom,
  Value<DateTime?> validTo,
  Value<List<FormPermission>> permissions,
  Value<int> rowid,
});

final class $$UserFormPermissionsTableReferences extends BaseReferences<
    _$AppDatabase, $UserFormPermissionsTable, UserFormPermission> {
  $$UserFormPermissionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TeamsTable _teamTable(_$AppDatabase db) => db.teams.createAlias(
      $_aliasNameGenerator(db.userFormPermissions.team, db.teams.id));

  $$TeamsTableProcessedTableManager get team {
    final $_column = $_itemColumn<String>('team')!;

    final manager = $$TeamsTableTableManager($_db, $_db.teams)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FormTemplatesTable _formTable(_$AppDatabase db) =>
      db.formTemplates.createAlias($_aliasNameGenerator(
          db.userFormPermissions.form, db.formTemplates.id));

  $$FormTemplatesTableProcessedTableManager get form {
    final $_column = $_itemColumn<String>('form')!;

    final manager = $$FormTemplatesTableTableManager($_db, $_db.formTemplates)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_formTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UserFormPermissionsTableFilterComposer
    extends Composer<_$AppDatabase, $UserFormPermissionsTable> {
  $$UserFormPermissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get validFrom => $composableBuilder(
      column: $table.validFrom, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get validTo => $composableBuilder(
      column: $table.validTo, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<FormPermission>, List<FormPermission>,
          String>
      get permissions => $composableBuilder(
          column: $table.permissions,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  $$TeamsTableFilterComposer get team {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.team,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableFilterComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FormTemplatesTableFilterComposer get form {
    final $$FormTemplatesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.form,
        referencedTable: $db.formTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplatesTableFilterComposer(
              $db: $db,
              $table: $db.formTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserFormPermissionsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserFormPermissionsTable> {
  $$UserFormPermissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get validFrom => $composableBuilder(
      column: $table.validFrom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get validTo => $composableBuilder(
      column: $table.validTo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get permissions => $composableBuilder(
      column: $table.permissions, builder: (column) => ColumnOrderings(column));

  $$TeamsTableOrderingComposer get team {
    final $$TeamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.team,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableOrderingComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FormTemplatesTableOrderingComposer get form {
    final $$FormTemplatesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.form,
        referencedTable: $db.formTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplatesTableOrderingComposer(
              $db: $db,
              $table: $db.formTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserFormPermissionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserFormPermissionsTable> {
  $$UserFormPermissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get validFrom =>
      $composableBuilder(column: $table.validFrom, builder: (column) => column);

  GeneratedColumn<DateTime> get validTo =>
      $composableBuilder(column: $table.validTo, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<FormPermission>, String>
      get permissions => $composableBuilder(
          column: $table.permissions, builder: (column) => column);

  $$TeamsTableAnnotationComposer get team {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.team,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FormTemplatesTableAnnotationComposer get form {
    final $$FormTemplatesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.form,
        referencedTable: $db.formTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormTemplatesTableAnnotationComposer(
              $db: $db,
              $table: $db.formTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserFormPermissionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserFormPermissionsTable,
    UserFormPermission,
    $$UserFormPermissionsTableFilterComposer,
    $$UserFormPermissionsTableOrderingComposer,
    $$UserFormPermissionsTableAnnotationComposer,
    $$UserFormPermissionsTableCreateCompanionBuilder,
    $$UserFormPermissionsTableUpdateCompanionBuilder,
    (UserFormPermission, $$UserFormPermissionsTableReferences),
    UserFormPermission,
    PrefetchHooks Function({bool team, bool form})> {
  $$UserFormPermissionsTableTableManager(
      _$AppDatabase db, $UserFormPermissionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserFormPermissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserFormPermissionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserFormPermissionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> team = const Value.absent(),
            Value<String> form = const Value.absent(),
            Value<DateTime?> validFrom = const Value.absent(),
            Value<DateTime?> validTo = const Value.absent(),
            Value<List<FormPermission>> permissions = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserFormPermissionsCompanion(
            team: team,
            form: form,
            validFrom: validFrom,
            validTo: validTo,
            permissions: permissions,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String team,
            required String form,
            Value<DateTime?> validFrom = const Value.absent(),
            Value<DateTime?> validTo = const Value.absent(),
            required List<FormPermission> permissions,
            Value<int> rowid = const Value.absent(),
          }) =>
              UserFormPermissionsCompanion.insert(
            team: team,
            form: form,
            validFrom: validFrom,
            validTo: validTo,
            permissions: permissions,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserFormPermissionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({team = false, form = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (team) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.team,
                    referencedTable:
                        $$UserFormPermissionsTableReferences._teamTable(db),
                    referencedColumn:
                        $$UserFormPermissionsTableReferences._teamTable(db).id,
                  ) as T;
                }
                if (form) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.form,
                    referencedTable:
                        $$UserFormPermissionsTableReferences._formTable(db),
                    referencedColumn:
                        $$UserFormPermissionsTableReferences._formTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$UserFormPermissionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserFormPermissionsTable,
    UserFormPermission,
    $$UserFormPermissionsTableFilterComposer,
    $$UserFormPermissionsTableOrderingComposer,
    $$UserFormPermissionsTableAnnotationComposer,
    $$UserFormPermissionsTableCreateCompanionBuilder,
    $$UserFormPermissionsTableUpdateCompanionBuilder,
    (UserFormPermission, $$UserFormPermissionsTableReferences),
    UserFormPermission,
    PrefetchHooks Function({bool team, bool form})>;
typedef $$SyncSummariesTableCreateCompanionBuilder = SyncSummariesCompanion
    Function({
  required String entity,
  Value<DateTime> lastSync,
  Value<int> successCount,
  Value<int> failureCount,
  Value<List<SyncError>?> errors,
  Value<int> rowid,
});
typedef $$SyncSummariesTableUpdateCompanionBuilder = SyncSummariesCompanion
    Function({
  Value<String> entity,
  Value<DateTime> lastSync,
  Value<int> successCount,
  Value<int> failureCount,
  Value<List<SyncError>?> errors,
  Value<int> rowid,
});

class $$SyncSummariesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncSummariesTable> {
  $$SyncSummariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get entity => $composableBuilder(
      column: $table.entity, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get successCount => $composableBuilder(
      column: $table.successCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get failureCount => $composableBuilder(
      column: $table.failureCount, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<SyncError>?, List<SyncError>, String>
      get errors => $composableBuilder(
          column: $table.errors,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$SyncSummariesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncSummariesTable> {
  $$SyncSummariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get entity => $composableBuilder(
      column: $table.entity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get successCount => $composableBuilder(
      column: $table.successCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get failureCount => $composableBuilder(
      column: $table.failureCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errors => $composableBuilder(
      column: $table.errors, builder: (column) => ColumnOrderings(column));
}

class $$SyncSummariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncSummariesTable> {
  $$SyncSummariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);

  GeneratedColumn<int> get successCount => $composableBuilder(
      column: $table.successCount, builder: (column) => column);

  GeneratedColumn<int> get failureCount => $composableBuilder(
      column: $table.failureCount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<SyncError>?, String> get errors =>
      $composableBuilder(column: $table.errors, builder: (column) => column);
}

class $$SyncSummariesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncSummariesTable,
    SyncSummary,
    $$SyncSummariesTableFilterComposer,
    $$SyncSummariesTableOrderingComposer,
    $$SyncSummariesTableAnnotationComposer,
    $$SyncSummariesTableCreateCompanionBuilder,
    $$SyncSummariesTableUpdateCompanionBuilder,
    (
      SyncSummary,
      BaseReferences<_$AppDatabase, $SyncSummariesTable, SyncSummary>
    ),
    SyncSummary,
    PrefetchHooks Function()> {
  $$SyncSummariesTableTableManager(_$AppDatabase db, $SyncSummariesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncSummariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncSummariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncSummariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> entity = const Value.absent(),
            Value<DateTime> lastSync = const Value.absent(),
            Value<int> successCount = const Value.absent(),
            Value<int> failureCount = const Value.absent(),
            Value<List<SyncError>?> errors = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncSummariesCompanion(
            entity: entity,
            lastSync: lastSync,
            successCount: successCount,
            failureCount: failureCount,
            errors: errors,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String entity,
            Value<DateTime> lastSync = const Value.absent(),
            Value<int> successCount = const Value.absent(),
            Value<int> failureCount = const Value.absent(),
            Value<List<SyncError>?> errors = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncSummariesCompanion.insert(
            entity: entity,
            lastSync: lastSync,
            successCount: successCount,
            failureCount: failureCount,
            errors: errors,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncSummariesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncSummariesTable,
    SyncSummary,
    $$SyncSummariesTableFilterComposer,
    $$SyncSummariesTableOrderingComposer,
    $$SyncSummariesTableAnnotationComposer,
    $$SyncSummariesTableCreateCompanionBuilder,
    $$SyncSummariesTableUpdateCompanionBuilder,
    (
      SyncSummary,
      BaseReferences<_$AppDatabase, $SyncSummariesTable, SyncSummary>
    ),
    SyncSummary,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$OrgUnitsTableTableManager get orgUnits =>
      $$OrgUnitsTableTableManager(_db, _db.orgUnits);
  $$OuLevelsTableTableManager get ouLevels =>
      $$OuLevelsTableTableManager(_db, _db.ouLevels);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$ActivitiesTableTableManager get activities =>
      $$ActivitiesTableTableManager(_db, _db.activities);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db, _db.teams);
  $$ManagedTeamsTableTableManager get managedTeams =>
      $$ManagedTeamsTableTableManager(_db, _db.managedTeams);
  $$AssignmentsTableTableManager get assignments =>
      $$AssignmentsTableTableManager(_db, _db.assignments);
  $$FormTemplatesTableTableManager get formTemplates =>
      $$FormTemplatesTableTableManager(_db, _db.formTemplates);
  $$AssignmentFormsTableTableManager get assignmentForms =>
      $$AssignmentFormsTableTableManager(_db, _db.assignmentForms);
  $$FormTemplateVersionsTableTableManager get formTemplateVersions =>
      $$FormTemplateVersionsTableTableManager(_db, _db.formTemplateVersions);
  $$MetadataSubmissionsTableTableManager get metadataSubmissions =>
      $$MetadataSubmissionsTableTableManager(_db, _db.metadataSubmissions);
  $$DataInstancesTableTableManager get dataInstances =>
      $$DataInstancesTableTableManager(_db, _db.dataInstances);
  $$RepeatInstancesTableTableManager get repeatInstances =>
      $$RepeatInstancesTableTableManager(_db, _db.repeatInstances);
  $$DataOptionSetsTableTableManager get dataOptionSets =>
      $$DataOptionSetsTableTableManager(_db, _db.dataOptionSets);
  $$DataElementsTableTableManager get dataElements =>
      $$DataElementsTableTableManager(_db, _db.dataElements);
  $$DataValuesTableTableManager get dataValues =>
      $$DataValuesTableTableManager(_db, _db.dataValues);
  $$DataOptionsTableTableManager get dataOptions =>
      $$DataOptionsTableTableManager(_db, _db.dataOptions);
  $$UserFormPermissionsTableTableManager get userFormPermissions =>
      $$UserFormPermissionsTableTableManager(_db, _db.userFormPermissions);
  $$SyncSummariesTableTableManager get syncSummaries =>
      $$SyncSummariesTableTableManager(_db, _db.syncSummaries);
}
