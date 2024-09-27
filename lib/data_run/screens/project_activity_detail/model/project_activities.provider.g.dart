// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_activities.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userAssignedTeamsHash() => r'167026bbd8853834a9af0eedd3a837cdfc86f616';

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
class UserAssignedTeamsFamily extends Family<AsyncValue<List<DTeam>>> {
  /// See also [userAssignedTeams].
  const UserAssignedTeamsFamily();

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

  @override
  UserAssignedTeamsProvider getProviderOverride(
    covariant UserAssignedTeamsProvider provider,
  ) {
    return call(
      activeStatus: provider.activeStatus,
      activity: provider.activity,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userAssignedTeamsProvider';
}

/// See also [userAssignedTeams].
class UserAssignedTeamsProvider extends AutoDisposeFutureProvider<List<DTeam>> {
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
    super._createNotifier, {
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
    FutureOr<List<DTeam>> Function(UserAssignedTeamsRef provider) create,
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
  AutoDisposeFutureProviderElement<List<DTeam>> createElement() {
    return _UserAssignedTeamsProviderElement(this);
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

mixin UserAssignedTeamsRef on AutoDisposeFutureProviderRef<List<DTeam>> {
  /// The parameter `activeStatus` of this provider.
  ActiveStatus get activeStatus;

  /// The parameter `activity` of this provider.
  String? get activity;
}

class _UserAssignedTeamsProviderElement
    extends AutoDisposeFutureProviderElement<List<DTeam>>
    with UserAssignedTeamsRef {
  _UserAssignedTeamsProviderElement(super.provider);

  @override
  ActiveStatus get activeStatus =>
      (origin as UserAssignedTeamsProvider).activeStatus;
  @override
  String? get activity => (origin as UserAssignedTeamsProvider).activity;
}

String _$userAssignedActivitiesHash() =>
    r'14109189ae5041e2bdc4441a22630216d129deed';

/// See also [userAssignedActivities].
@ProviderFor(userAssignedActivities)
const userAssignedActivitiesProvider = UserAssignedActivitiesFamily();

/// See also [userAssignedActivities].
class UserAssignedActivitiesFamily extends Family<AsyncValue<List<DActivity>>> {
  /// See also [userAssignedActivities].
  const UserAssignedActivitiesFamily();

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

  @override
  UserAssignedActivitiesProvider getProviderOverride(
    covariant UserAssignedActivitiesProvider provider,
  ) {
    return call(
      activeStatus: provider.activeStatus,
      project: provider.project,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userAssignedActivitiesProvider';
}

/// See also [userAssignedActivities].
class UserAssignedActivitiesProvider
    extends AutoDisposeFutureProvider<List<DActivity>> {
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
    super._createNotifier, {
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
    FutureOr<List<DActivity>> Function(UserAssignedActivitiesRef provider)
        create,
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
  AutoDisposeFutureProviderElement<List<DActivity>> createElement() {
    return _UserAssignedActivitiesProviderElement(this);
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
    on AutoDisposeFutureProviderRef<List<DActivity>> {
  /// The parameter `activeStatus` of this provider.
  ActiveStatus get activeStatus;

  /// The parameter `project` of this provider.
  String? get project;
}

class _UserAssignedActivitiesProviderElement
    extends AutoDisposeFutureProviderElement<List<DActivity>>
    with UserAssignedActivitiesRef {
  _UserAssignedActivitiesProviderElement(super.provider);

  @override
  ActiveStatus get activeStatus =>
      (origin as UserAssignedActivitiesProvider).activeStatus;
  @override
  String? get project => (origin as UserAssignedActivitiesProvider).project;
}

String _$projectActiveActivitiesHash() =>
    r'4e3cf6a2ed0f98f219ae5622390ea71a0611fb30';

/// See also [projectActiveActivities].
@ProviderFor(projectActiveActivities)
const projectActiveActivitiesProvider = ProjectActiveActivitiesFamily();

/// See also [projectActiveActivities].
class ProjectActiveActivitiesFamily
    extends Family<AsyncValue<List<DActivity>>> {
  /// See also [projectActiveActivities].
  const ProjectActiveActivitiesFamily();

  /// See also [projectActiveActivities].
  ProjectActiveActivitiesProvider call(
    String project,
  ) {
    return ProjectActiveActivitiesProvider(
      project,
    );
  }

  @override
  ProjectActiveActivitiesProvider getProviderOverride(
    covariant ProjectActiveActivitiesProvider provider,
  ) {
    return call(
      provider.project,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'projectActiveActivitiesProvider';
}

/// See also [projectActiveActivities].
class ProjectActiveActivitiesProvider
    extends AutoDisposeFutureProvider<List<DActivity>> {
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
    super._createNotifier, {
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
    FutureOr<List<DActivity>> Function(ProjectActiveActivitiesRef provider)
        create,
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
  AutoDisposeFutureProviderElement<List<DActivity>> createElement() {
    return _ProjectActiveActivitiesProviderElement(this);
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
    on AutoDisposeFutureProviderRef<List<DActivity>> {
  /// The parameter `project` of this provider.
  String get project;
}

class _ProjectActiveActivitiesProviderElement
    extends AutoDisposeFutureProviderElement<List<DActivity>>
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
class ActivityFormsFamily extends Family<AsyncValue<List<FormTemplate>>> {
  /// See also [activityForms].
  const ActivityFormsFamily();

  /// See also [activityForms].
  ActivityFormsProvider call(
    String? activity,
  ) {
    return ActivityFormsProvider(
      activity,
    );
  }

  @override
  ActivityFormsProvider getProviderOverride(
    covariant ActivityFormsProvider provider,
  ) {
    return call(
      provider.activity,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'activityFormsProvider';
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
    super._createNotifier, {
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
    FutureOr<List<FormTemplate>> Function(ActivityFormsRef provider) create,
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
  AutoDisposeFutureProviderElement<List<FormTemplate>> createElement() {
    return _ActivityFormsProviderElement(this);
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

String _$activityTeamHash() => r'a68776d666a27a837c2159ad4db76ceb97b54ccf';

/// See also [activityTeam].
@ProviderFor(activityTeam)
const activityTeamProvider = ActivityTeamFamily();

/// See also [activityTeam].
class ActivityTeamFamily extends Family<AsyncValue<DTeam?>> {
  /// See also [activityTeam].
  const ActivityTeamFamily();

  /// See also [activityTeam].
  ActivityTeamProvider call(
    String? activity,
  ) {
    return ActivityTeamProvider(
      activity,
    );
  }

  @override
  ActivityTeamProvider getProviderOverride(
    covariant ActivityTeamProvider provider,
  ) {
    return call(
      provider.activity,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'activityTeamProvider';
}

/// See also [activityTeam].
class ActivityTeamProvider extends AutoDisposeFutureProvider<DTeam?> {
  /// See also [activityTeam].
  ActivityTeamProvider(
    String? activity,
  ) : this._internal(
          (ref) => activityTeam(
            ref as ActivityTeamRef,
            activity,
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
    super._createNotifier, {
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
    FutureOr<DTeam?> Function(ActivityTeamRef provider) create,
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
  AutoDisposeFutureProviderElement<DTeam?> createElement() {
    return _ActivityTeamProviderElement(this);
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

mixin ActivityTeamRef on AutoDisposeFutureProviderRef<DTeam?> {
  /// The parameter `activity` of this provider.
  String? get activity;
}

class _ActivityTeamProviderElement
    extends AutoDisposeFutureProviderElement<DTeam?> with ActivityTeamRef {
  _ActivityTeamProviderElement(super.provider);

  @override
  String? get activity => (origin as ActivityTeamProvider).activity;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
