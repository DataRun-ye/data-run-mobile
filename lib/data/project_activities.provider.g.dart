// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_activities.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userAssignedTeamsHash() => r'af4a9768b71545b7bc726f0f6f0ab56054438454';

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
class UserAssignedTeamsFamily extends Family<AsyncValue<List<Team>>> {
  /// See also [userAssignedTeams].
  const UserAssignedTeamsFamily();

  /// See also [userAssignedTeams].
  UserAssignedTeamsProvider call({
    String? activity,
  }) {
    return UserAssignedTeamsProvider(
      activity: activity,
    );
  }

  @override
  UserAssignedTeamsProvider getProviderOverride(
    covariant UserAssignedTeamsProvider provider,
  ) {
    return call(
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
class UserAssignedTeamsProvider extends AutoDisposeFutureProvider<List<Team>> {
  /// See also [userAssignedTeams].
  UserAssignedTeamsProvider({
    String? activity,
  }) : this._internal(
          (ref) => userAssignedTeams(
            ref as UserAssignedTeamsRef,
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
          activity: activity,
        );

  UserAssignedTeamsProvider._internal(
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
    FutureOr<List<Team>> Function(UserAssignedTeamsRef provider) create,
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
        activity: activity,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Team>> createElement() {
    return _UserAssignedTeamsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserAssignedTeamsProvider && other.activity == activity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, activity.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserAssignedTeamsRef on AutoDisposeFutureProviderRef<List<Team>> {
  /// The parameter `activity` of this provider.
  String? get activity;
}

class _UserAssignedTeamsProviderElement
    extends AutoDisposeFutureProviderElement<List<Team>>
    with UserAssignedTeamsRef {
  _UserAssignedTeamsProviderElement(super.provider);

  @override
  String? get activity => (origin as UserAssignedTeamsProvider).activity;
}

String _$userAssignedActivitiesHash() =>
    r'9002f382321e4f47ac1b3bef3f5b1830732f7a21';

/// See also [userAssignedActivities].
@ProviderFor(userAssignedActivities)
const userAssignedActivitiesProvider = UserAssignedActivitiesFamily();

/// See also [userAssignedActivities].
class UserAssignedActivitiesFamily extends Family<AsyncValue<List<Activity>>> {
  /// See also [userAssignedActivities].
  const UserAssignedActivitiesFamily();

  /// See also [userAssignedActivities].
  UserAssignedActivitiesProvider call({
    String? project,
  }) {
    return UserAssignedActivitiesProvider(
      project: project,
    );
  }

  @override
  UserAssignedActivitiesProvider getProviderOverride(
    covariant UserAssignedActivitiesProvider provider,
  ) {
    return call(
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
    extends AutoDisposeFutureProvider<List<Activity>> {
  /// See also [userAssignedActivities].
  UserAssignedActivitiesProvider({
    String? project,
  }) : this._internal(
          (ref) => userAssignedActivities(
            ref as UserAssignedActivitiesRef,
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
          project: project,
        );

  UserAssignedActivitiesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.project,
  }) : super.internal();

  final String? project;

  @override
  Override overrideWith(
    FutureOr<List<Activity>> Function(UserAssignedActivitiesRef provider)
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
        project: project,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Activity>> createElement() {
    return _UserAssignedActivitiesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserAssignedActivitiesProvider && other.project == project;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, project.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserAssignedActivitiesRef
    on AutoDisposeFutureProviderRef<List<Activity>> {
  /// The parameter `project` of this provider.
  String? get project;
}

class _UserAssignedActivitiesProviderElement
    extends AutoDisposeFutureProviderElement<List<Activity>>
    with UserAssignedActivitiesRef {
  _UserAssignedActivitiesProviderElement(super.provider);

  @override
  String? get project => (origin as UserAssignedActivitiesProvider).project;
}

String _$projectActiveActivitiesHash() =>
    r'ee472177f30735ef1ed1255a6b4f641ce77e78e5';

/// See also [projectActiveActivities].
@ProviderFor(projectActiveActivities)
const projectActiveActivitiesProvider = ProjectActiveActivitiesFamily();

/// See also [projectActiveActivities].
class ProjectActiveActivitiesFamily extends Family<AsyncValue<List<Activity>>> {
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
    FutureOr<List<Activity>> Function(ProjectActiveActivitiesRef provider)
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
  AutoDisposeFutureProviderElement<List<Activity>> createElement() {
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
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

String _$activityTeamHash() => r'a79250a18524592bc6c7e50da9d06df98012f668';

/// See also [activityTeam].
@ProviderFor(activityTeam)
const activityTeamProvider = ActivityTeamFamily();

/// See also [activityTeam].
class ActivityTeamFamily extends Family<AsyncValue<Team?>> {
  /// See also [activityTeam].
  const ActivityTeamFamily();

  /// See also [activityTeam].
  ActivityTeamProvider call({
    required String activity,
  }) {
    return ActivityTeamProvider(
      activity: activity,
    );
  }

  @override
  ActivityTeamProvider getProviderOverride(
    covariant ActivityTeamProvider provider,
  ) {
    return call(
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
  String? get name => r'activityTeamProvider';
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
    super._createNotifier, {
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
    FutureOr<Team?> Function(ActivityTeamRef provider) create,
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
  AutoDisposeFutureProviderElement<Team?> createElement() {
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
