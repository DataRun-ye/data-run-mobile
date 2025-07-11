// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userAvailableFormsHash() =>
    r'a89f1f59c00f0fe775f65a932b0099d05fea950b';

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

/// See also [userAvailableForms].
@ProviderFor(userAvailableForms)
const userAvailableFormsProvider = UserAvailableFormsFamily();

/// See also [userAvailableForms].
class UserAvailableFormsFamily
    extends Family<AsyncValue<List<Pair<AssignmentForm, bool>>>> {
  /// See also [userAvailableForms].
  const UserAvailableFormsFamily();

  /// See also [userAvailableForms].
  UserAvailableFormsProvider call({
    String? assignment,
  }) {
    return UserAvailableFormsProvider(
      assignment: assignment,
    );
  }

  @override
  UserAvailableFormsProvider getProviderOverride(
    covariant UserAvailableFormsProvider provider,
  ) {
    return call(
      assignment: provider.assignment,
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
  String? get name => r'userAvailableFormsProvider';
}

/// See also [userAvailableForms].
class UserAvailableFormsProvider
    extends AutoDisposeFutureProvider<List<Pair<AssignmentForm, bool>>> {
  /// See also [userAvailableForms].
  UserAvailableFormsProvider({
    String? assignment,
  }) : this._internal(
          (ref) => userAvailableForms(
            ref as UserAvailableFormsRef,
            assignment: assignment,
          ),
          from: userAvailableFormsProvider,
          name: r'userAvailableFormsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userAvailableFormsHash,
          dependencies: UserAvailableFormsFamily._dependencies,
          allTransitiveDependencies:
              UserAvailableFormsFamily._allTransitiveDependencies,
          assignment: assignment,
        );

  UserAvailableFormsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.assignment,
  }) : super.internal();

  final String? assignment;

  @override
  Override overrideWith(
    FutureOr<List<Pair<AssignmentForm, bool>>> Function(
            UserAvailableFormsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserAvailableFormsProvider._internal(
        (ref) => create(ref as UserAvailableFormsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        assignment: assignment,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Pair<AssignmentForm, bool>>>
      createElement() {
    return _UserAvailableFormsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserAvailableFormsProvider &&
        other.assignment == assignment;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, assignment.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserAvailableFormsRef
    on AutoDisposeFutureProviderRef<List<Pair<AssignmentForm, bool>>> {
  /// The parameter `assignment` of this provider.
  String? get assignment;
}

class _UserAvailableFormsProviderElement
    extends AutoDisposeFutureProviderElement<List<Pair<AssignmentForm, bool>>>
    with UserAvailableFormsRef {
  _UserAvailableFormsProviderElement(super.provider);

  @override
  String? get assignment => (origin as UserAvailableFormsProvider).assignment;
}

String _$teamsHash() => r'3256b5e57acf12e2c4c182e1ab1e0678685d881f';

/// See also [teams].
@ProviderFor(teams)
const teamsProvider = TeamsFamily();

/// See also [teams].
class TeamsFamily extends Family<AsyncValue<List<IdentifiableModel>>> {
  /// See also [teams].
  const TeamsFamily();

  /// See also [teams].
  TeamsProvider call({
    String? activity,
  }) {
    return TeamsProvider(
      activity: activity,
    );
  }

  @override
  TeamsProvider getProviderOverride(
    covariant TeamsProvider provider,
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
  String? get name => r'teamsProvider';
}

/// See also [teams].
class TeamsProvider extends AutoDisposeFutureProvider<List<IdentifiableModel>> {
  /// See also [teams].
  TeamsProvider({
    String? activity,
  }) : this._internal(
          (ref) => teams(
            ref as TeamsRef,
            activity: activity,
          ),
          from: teamsProvider,
          name: r'teamsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$teamsHash,
          dependencies: TeamsFamily._dependencies,
          allTransitiveDependencies: TeamsFamily._allTransitiveDependencies,
          activity: activity,
        );

  TeamsProvider._internal(
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
    FutureOr<List<IdentifiableModel>> Function(TeamsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeamsProvider._internal(
        (ref) => create(ref as TeamsRef),
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
  AutoDisposeFutureProviderElement<List<IdentifiableModel>> createElement() {
    return _TeamsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamsProvider && other.activity == activity;
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
mixin TeamsRef on AutoDisposeFutureProviderRef<List<IdentifiableModel>> {
  /// The parameter `activity` of this provider.
  String? get activity;
}

class _TeamsProviderElement
    extends AutoDisposeFutureProviderElement<List<IdentifiableModel>>
    with TeamsRef {
  _TeamsProviderElement(super.provider);

  @override
  String? get activity => (origin as TeamsProvider).activity;
}

String _$managedTeamsHash() => r'e7c649c9ed73df9ec8ca1e5a93012aa757b81e32';

/// See also [managedTeams].
@ProviderFor(managedTeams)
const managedTeamsProvider = ManagedTeamsFamily();

/// See also [managedTeams].
class ManagedTeamsFamily extends Family<AsyncValue<List<IdentifiableModel>>> {
  /// See also [managedTeams].
  const ManagedTeamsFamily();

  /// See also [managedTeams].
  ManagedTeamsProvider call({
    String? team,
    String? activity,
  }) {
    return ManagedTeamsProvider(
      team: team,
      activity: activity,
    );
  }

  @override
  ManagedTeamsProvider getProviderOverride(
    covariant ManagedTeamsProvider provider,
  ) {
    return call(
      team: provider.team,
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
  String? get name => r'managedTeamsProvider';
}

/// See also [managedTeams].
class ManagedTeamsProvider
    extends AutoDisposeFutureProvider<List<IdentifiableModel>> {
  /// See also [managedTeams].
  ManagedTeamsProvider({
    String? team,
    String? activity,
  }) : this._internal(
          (ref) => managedTeams(
            ref as ManagedTeamsRef,
            team: team,
            activity: activity,
          ),
          from: managedTeamsProvider,
          name: r'managedTeamsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$managedTeamsHash,
          dependencies: ManagedTeamsFamily._dependencies,
          allTransitiveDependencies:
              ManagedTeamsFamily._allTransitiveDependencies,
          team: team,
          activity: activity,
        );

  ManagedTeamsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.team,
    required this.activity,
  }) : super.internal();

  final String? team;
  final String? activity;

  @override
  Override overrideWith(
    FutureOr<List<IdentifiableModel>> Function(ManagedTeamsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ManagedTeamsProvider._internal(
        (ref) => create(ref as ManagedTeamsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        team: team,
        activity: activity,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<IdentifiableModel>> createElement() {
    return _ManagedTeamsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ManagedTeamsProvider &&
        other.team == team &&
        other.activity == activity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, team.hashCode);
    hash = _SystemHash.combine(hash, activity.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ManagedTeamsRef on AutoDisposeFutureProviderRef<List<IdentifiableModel>> {
  /// The parameter `team` of this provider.
  String? get team;

  /// The parameter `activity` of this provider.
  String? get activity;
}

class _ManagedTeamsProviderElement
    extends AutoDisposeFutureProviderElement<List<IdentifiableModel>>
    with ManagedTeamsRef {
  _ManagedTeamsProviderElement(super.provider);

  @override
  String? get team => (origin as ManagedTeamsProvider).team;
  @override
  String? get activity => (origin as ManagedTeamsProvider).activity;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
