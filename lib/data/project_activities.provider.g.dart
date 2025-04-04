// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_activities.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userAssignedTeamsHash() => r'484bfa2d3a938181293ccd886c0b63575c98a108';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [userAssignedTeams].
@ProviderFor(userAssignedTeams)
const userAssignedTeamsProvider = UserAssignedTeamsFamily();

/// See also [userAssignedTeams].
class UserAssignedTeamsFamily extends Family {
  /// See also [userAssignedTeams].
  const UserAssignedTeamsFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userAssignedTeamsProvider';

  /// See also [userAssignedTeams].
  UserAssignedTeamsProvider call({
    ActiveStatus activeStatus = ActiveStatus.EnabledOnly,
    String? activity,
  }) {
    return UserAssignedTeamsProvider(
      activeStatus: activeStatus,
      activity: activity,
    );
  }

  @visibleForOverriding
  @override
  UserAssignedTeamsProvider getProviderOverride(
    covariant UserAssignedTeamsProvider provider,
  ) {
    return call(
      activeStatus: provider.activeStatus,
      activity: provider.activity,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<Team>> Function(UserAssignedTeamsRef ref) create) {
    return _$UserAssignedTeamsFamilyOverride(this, create);
  }
}

class _$UserAssignedTeamsFamilyOverride implements FamilyOverride {
  _$UserAssignedTeamsFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<Team>> Function(UserAssignedTeamsRef ref) create;

  @override
  final UserAssignedTeamsFamily overriddenFamily;

  @override
  UserAssignedTeamsProvider getProviderOverride(
    covariant UserAssignedTeamsProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [userAssignedTeams].
class UserAssignedTeamsProvider extends AutoDisposeFutureProvider<List<Team>> {
  /// See also [userAssignedTeams].
  UserAssignedTeamsProvider({
    ActiveStatus activeStatus = ActiveStatus.EnabledOnly,
    String? activity,
  }) : this._internal(
          (ref) => userAssignedTeams(
            ref as UserAssignedTeamsRef,
            activeStatus: activeStatus,
            activity: activity,
          ),
          from: userAssignedTeamsProvider,
          name: r'userAssignedTeamsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userAssignedTeamsHash,
          dependencies: UserAssignedTeamsFamily._dependencies,
          allTransitiveDependencies:
              UserAssignedTeamsFamily._allTransitiveDependencies,
          activeStatus: activeStatus,
          activity: activity,
        );

  UserAssignedTeamsProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.activeStatus,
    required this.activity,
  }) : super.internal();

  final ActiveStatus activeStatus;
  final String? activity;

  @override
  Override overrideWith(
    FutureOr<List<Team>> Function(UserAssignedTeamsRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserAssignedTeamsProvider._internal(
        (ref) => create(ref as UserAssignedTeamsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        activeStatus: activeStatus,
        activity: activity,
      ),
    );
  }

  @override
  ({
    ActiveStatus activeStatus,
    String? activity,
  }) get argument {
    return (
      activeStatus: activeStatus,
      activity: activity,
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Team>> createElement() {
    return _UserAssignedTeamsProviderElement(this);
  }

  UserAssignedTeamsProvider _copyWith(
    FutureOr<List<Team>> Function(UserAssignedTeamsRef ref) create,
  ) {
    return UserAssignedTeamsProvider._internal(
      (ref) => create(ref as UserAssignedTeamsRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      activeStatus: activeStatus,
      activity: activity,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserAssignedTeamsProvider &&
        other.activeStatus == activeStatus &&
        other.activity == activity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, activeStatus.hashCode);
    hash = _SystemHash.combine(hash, activity.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserAssignedTeamsRef on AutoDisposeFutureProviderRef<List<Team>> {
  /// The parameter `activeStatus` of this provider.
  ActiveStatus get activeStatus;

  /// The parameter `activity` of this provider.
  String? get activity;
}

class _UserAssignedTeamsProviderElement
    extends AutoDisposeFutureProviderElement<List<Team>>
    with UserAssignedTeamsRef {
  _UserAssignedTeamsProviderElement(super.provider);

  @override
  ActiveStatus get activeStatus =>
      (origin as UserAssignedTeamsProvider).activeStatus;
  @override
  String? get activity => (origin as UserAssignedTeamsProvider).activity;
}

String _$userAssignedActivitiesHash() =>
    r'f94cdf8e0bf6a0479cee554a4d79fc8c1fae27d4';

/// See also [userAssignedActivities].
@ProviderFor(userAssignedActivities)
const userAssignedActivitiesProvider = UserAssignedActivitiesFamily();

/// See also [userAssignedActivities].
class UserAssignedActivitiesFamily extends Family {
  /// See also [userAssignedActivities].
  const UserAssignedActivitiesFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userAssignedActivitiesProvider';

  /// See also [userAssignedActivities].
  UserAssignedActivitiesProvider call({
    ActiveStatus activeStatus = ActiveStatus.EnabledOnly,
    String? project,
  }) {
    return UserAssignedActivitiesProvider(
      activeStatus: activeStatus,
      project: project,
    );
  }

  @visibleForOverriding
  @override
  UserAssignedActivitiesProvider getProviderOverride(
    covariant UserAssignedActivitiesProvider provider,
  ) {
    return call(
      activeStatus: provider.activeStatus,
      project: provider.project,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<Activity>> Function(UserAssignedActivitiesRef ref) create) {
    return _$UserAssignedActivitiesFamilyOverride(this, create);
  }
}

class _$UserAssignedActivitiesFamilyOverride implements FamilyOverride {
  _$UserAssignedActivitiesFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<Activity>> Function(UserAssignedActivitiesRef ref) create;

  @override
  final UserAssignedActivitiesFamily overriddenFamily;

  @override
  UserAssignedActivitiesProvider getProviderOverride(
    covariant UserAssignedActivitiesProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [userAssignedActivities].
class UserAssignedActivitiesProvider
    extends AutoDisposeFutureProvider<List<Activity>> {
  /// See also [userAssignedActivities].
  UserAssignedActivitiesProvider({
    ActiveStatus activeStatus = ActiveStatus.EnabledOnly,
    String? project,
  }) : this._internal(
          (ref) => userAssignedActivities(
            ref as UserAssignedActivitiesRef,
            activeStatus: activeStatus,
            project: project,
          ),
          from: userAssignedActivitiesProvider,
          name: r'userAssignedActivitiesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userAssignedActivitiesHash,
          dependencies: UserAssignedActivitiesFamily._dependencies,
          allTransitiveDependencies:
              UserAssignedActivitiesFamily._allTransitiveDependencies,
          activeStatus: activeStatus,
          project: project,
        );

  UserAssignedActivitiesProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.activeStatus,
    required this.project,
  }) : super.internal();

  final ActiveStatus activeStatus;
  final String? project;

  @override
  Override overrideWith(
    FutureOr<List<Activity>> Function(UserAssignedActivitiesRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserAssignedActivitiesProvider._internal(
        (ref) => create(ref as UserAssignedActivitiesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        activeStatus: activeStatus,
        project: project,
      ),
    );
  }

  @override
  ({
    ActiveStatus activeStatus,
    String? project,
  }) get argument {
    return (
      activeStatus: activeStatus,
      project: project,
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Activity>> createElement() {
    return _UserAssignedActivitiesProviderElement(this);
  }

  UserAssignedActivitiesProvider _copyWith(
    FutureOr<List<Activity>> Function(UserAssignedActivitiesRef ref) create,
  ) {
    return UserAssignedActivitiesProvider._internal(
      (ref) => create(ref as UserAssignedActivitiesRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      activeStatus: activeStatus,
      project: project,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserAssignedActivitiesProvider &&
        other.activeStatus == activeStatus &&
        other.project == project;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, activeStatus.hashCode);
    hash = _SystemHash.combine(hash, project.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserAssignedActivitiesRef
    on AutoDisposeFutureProviderRef<List<Activity>> {
  /// The parameter `activeStatus` of this provider.
  ActiveStatus get activeStatus;

  /// The parameter `project` of this provider.
  String? get project;
}

class _UserAssignedActivitiesProviderElement
    extends AutoDisposeFutureProviderElement<List<Activity>>
    with UserAssignedActivitiesRef {
  _UserAssignedActivitiesProviderElement(super.provider);

  @override
  ActiveStatus get activeStatus =>
      (origin as UserAssignedActivitiesProvider).activeStatus;
  @override
  String? get project => (origin as UserAssignedActivitiesProvider).project;
}

String _$projectActiveActivitiesHash() =>
    r'ee472177f30735ef1ed1255a6b4f641ce77e78e5';

/// See also [projectActiveActivities].
@ProviderFor(projectActiveActivities)
const projectActiveActivitiesProvider = ProjectActiveActivitiesFamily();

/// See also [projectActiveActivities].
class ProjectActiveActivitiesFamily extends Family {
  /// See also [projectActiveActivities].
  const ProjectActiveActivitiesFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'projectActiveActivitiesProvider';

  /// See also [projectActiveActivities].
  ProjectActiveActivitiesProvider call(
    String project,
  ) {
    return ProjectActiveActivitiesProvider(
      project,
    );
  }

  @visibleForOverriding
  @override
  ProjectActiveActivitiesProvider getProviderOverride(
    covariant ProjectActiveActivitiesProvider provider,
  ) {
    return call(
      provider.project,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<Activity>> Function(ProjectActiveActivitiesRef ref)
          create) {
    return _$ProjectActiveActivitiesFamilyOverride(this, create);
  }
}

class _$ProjectActiveActivitiesFamilyOverride implements FamilyOverride {
  _$ProjectActiveActivitiesFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<Activity>> Function(ProjectActiveActivitiesRef ref)
      create;

  @override
  final ProjectActiveActivitiesFamily overriddenFamily;

  @override
  ProjectActiveActivitiesProvider getProviderOverride(
    covariant ProjectActiveActivitiesProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [projectActiveActivities].
class ProjectActiveActivitiesProvider
    extends AutoDisposeFutureProvider<List<Activity>> {
  /// See also [projectActiveActivities].
  ProjectActiveActivitiesProvider(
    String project,
  ) : this._internal(
          (ref) => projectActiveActivities(
            ref as ProjectActiveActivitiesRef,
            project,
          ),
          from: projectActiveActivitiesProvider,
          name: r'projectActiveActivitiesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectActiveActivitiesHash,
          dependencies: ProjectActiveActivitiesFamily._dependencies,
          allTransitiveDependencies:
              ProjectActiveActivitiesFamily._allTransitiveDependencies,
          project: project,
        );

  ProjectActiveActivitiesProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.project,
  }) : super.internal();

  final String project;

  @override
  Override overrideWith(
    FutureOr<List<Activity>> Function(ProjectActiveActivitiesRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProjectActiveActivitiesProvider._internal(
        (ref) => create(ref as ProjectActiveActivitiesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        project: project,
      ),
    );
  }

  @override
  (String,) get argument {
    return (project,);
  }

  @override
  AutoDisposeFutureProviderElement<List<Activity>> createElement() {
    return _ProjectActiveActivitiesProviderElement(this);
  }

  ProjectActiveActivitiesProvider _copyWith(
    FutureOr<List<Activity>> Function(ProjectActiveActivitiesRef ref) create,
  ) {
    return ProjectActiveActivitiesProvider._internal(
      (ref) => create(ref as ProjectActiveActivitiesRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      project: project,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectActiveActivitiesProvider && other.project == project;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, project.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProjectActiveActivitiesRef
    on AutoDisposeFutureProviderRef<List<Activity>> {
  /// The parameter `project` of this provider.
  String get project;
}

class _ProjectActiveActivitiesProviderElement
    extends AutoDisposeFutureProviderElement<List<Activity>>
    with ProjectActiveActivitiesRef {
  _ProjectActiveActivitiesProviderElement(super.provider);

  @override
  String get project => (origin as ProjectActiveActivitiesProvider).project;
}

String _$activityFormsHash() => r'173db7a1c145d9506f7b18b64c5bf6bb84d3ff5d';

/// See also [activityForms].
@ProviderFor(activityForms)
const activityFormsProvider = ActivityFormsFamily();

/// See also [activityForms].
class ActivityFormsFamily extends Family {
  /// See also [activityForms].
  const ActivityFormsFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'activityFormsProvider';

  /// See also [activityForms].
  ActivityFormsProvider call(
    String? activity,
  ) {
    return ActivityFormsProvider(
      activity,
    );
  }

  @visibleForOverriding
  @override
  ActivityFormsProvider getProviderOverride(
    covariant ActivityFormsProvider provider,
  ) {
    return call(
      provider.activity,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<FormTemplate>> Function(ActivityFormsRef ref) create) {
    return _$ActivityFormsFamilyOverride(this, create);
  }
}

class _$ActivityFormsFamilyOverride implements FamilyOverride {
  _$ActivityFormsFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<FormTemplate>> Function(ActivityFormsRef ref) create;

  @override
  final ActivityFormsFamily overriddenFamily;

  @override
  ActivityFormsProvider getProviderOverride(
    covariant ActivityFormsProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [activityForms].
class ActivityFormsProvider
    extends AutoDisposeFutureProvider<List<FormTemplate>> {
  /// See also [activityForms].
  ActivityFormsProvider(
    String? activity,
  ) : this._internal(
          (ref) => activityForms(
            ref as ActivityFormsRef,
            activity,
          ),
          from: activityFormsProvider,
          name: r'activityFormsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$activityFormsHash,
          dependencies: ActivityFormsFamily._dependencies,
          allTransitiveDependencies:
              ActivityFormsFamily._allTransitiveDependencies,
          activity: activity,
        );

  ActivityFormsProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.activity,
  }) : super.internal();

  final String? activity;

  @override
  Override overrideWith(
    FutureOr<List<FormTemplate>> Function(ActivityFormsRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActivityFormsProvider._internal(
        (ref) => create(ref as ActivityFormsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        activity: activity,
      ),
    );
  }

  @override
  (String?,) get argument {
    return (activity,);
  }

  @override
  AutoDisposeFutureProviderElement<List<FormTemplate>> createElement() {
    return _ActivityFormsProviderElement(this);
  }

  ActivityFormsProvider _copyWith(
    FutureOr<List<FormTemplate>> Function(ActivityFormsRef ref) create,
  ) {
    return ActivityFormsProvider._internal(
      (ref) => create(ref as ActivityFormsRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      activity: activity,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityFormsProvider && other.activity == activity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, activity.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ActivityFormsRef on AutoDisposeFutureProviderRef<List<FormTemplate>> {
  /// The parameter `activity` of this provider.
  String? get activity;
}

class _ActivityFormsProviderElement
    extends AutoDisposeFutureProviderElement<List<FormTemplate>>
    with ActivityFormsRef {
  _ActivityFormsProviderElement(super.provider);

  @override
  String? get activity => (origin as ActivityFormsProvider).activity;
}

String _$activityTeamHash() => r'fb8b4e30d623c7a89a38c5a8a428424c54efe703';

/// See also [activityTeam].
@ProviderFor(activityTeam)
const activityTeamProvider = ActivityTeamFamily();

/// See also [activityTeam].
class ActivityTeamFamily extends Family {
  /// See also [activityTeam].
  const ActivityTeamFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'activityTeamProvider';

  /// See also [activityTeam].
  ActivityTeamProvider call({
    required String activity,
  }) {
    return ActivityTeamProvider(
      activity: activity,
    );
  }

  @visibleForOverriding
  @override
  ActivityTeamProvider getProviderOverride(
    covariant ActivityTeamProvider provider,
  ) {
    return call(
      activity: provider.activity,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(FutureOr<Team?> Function(ActivityTeamRef ref) create) {
    return _$ActivityTeamFamilyOverride(this, create);
  }
}

class _$ActivityTeamFamilyOverride implements FamilyOverride {
  _$ActivityTeamFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<Team?> Function(ActivityTeamRef ref) create;

  @override
  final ActivityTeamFamily overriddenFamily;

  @override
  ActivityTeamProvider getProviderOverride(
    covariant ActivityTeamProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [activityTeam].
class ActivityTeamProvider extends AutoDisposeFutureProvider<Team?> {
  /// See also [activityTeam].
  ActivityTeamProvider({
    required String activity,
  }) : this._internal(
          (ref) => activityTeam(
            ref as ActivityTeamRef,
            activity: activity,
          ),
          from: activityTeamProvider,
          name: r'activityTeamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$activityTeamHash,
          dependencies: ActivityTeamFamily._dependencies,
          allTransitiveDependencies:
              ActivityTeamFamily._allTransitiveDependencies,
          activity: activity,
        );

  ActivityTeamProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.activity,
  }) : super.internal();

  final String activity;

  @override
  Override overrideWith(
    FutureOr<Team?> Function(ActivityTeamRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActivityTeamProvider._internal(
        (ref) => create(ref as ActivityTeamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        activity: activity,
      ),
    );
  }

  @override
  ({
    String activity,
  }) get argument {
    return (activity: activity,);
  }

  @override
  AutoDisposeFutureProviderElement<Team?> createElement() {
    return _ActivityTeamProviderElement(this);
  }

  ActivityTeamProvider _copyWith(
    FutureOr<Team?> Function(ActivityTeamRef ref) create,
  ) {
    return ActivityTeamProvider._internal(
      (ref) => create(ref as ActivityTeamRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      activity: activity,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityTeamProvider && other.activity == activity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, activity.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ActivityTeamRef on AutoDisposeFutureProviderRef<Team?> {
  /// The parameter `activity` of this provider.
  String get activity;
}

class _ActivityTeamProviderElement
    extends AutoDisposeFutureProviderElement<Team?> with ActivityTeamRef {
  _ActivityTeamProviderElement(super.provider);

  @override
  String get activity => (origin as ActivityTeamProvider).activity;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
