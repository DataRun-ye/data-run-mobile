// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$teamsHash() => r'fadce4ed177257c2a3045cfcbc92eee79de79411';

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

abstract class _$Teams
    extends BuildlessAutoDisposeAsyncNotifier<IList<TeamModel>> {
  late final EntityScope scope;

  FutureOr<IList<TeamModel>> build(
    EntityScope scope,
  );
}

/// See also [Teams].
@ProviderFor(Teams)
const teamsProvider = TeamsFamily();

/// See also [Teams].
class TeamsFamily extends Family<AsyncValue<IList<TeamModel>>> {
  /// See also [Teams].
  const TeamsFamily();

  /// See also [Teams].
  TeamsProvider call(
    EntityScope scope,
  ) {
    return TeamsProvider(
      scope,
    );
  }

  @override
  TeamsProvider getProviderOverride(
    covariant TeamsProvider provider,
  ) {
    return call(
      provider.scope,
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

/// See also [Teams].
class TeamsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Teams, IList<TeamModel>> {
  /// See also [Teams].
  TeamsProvider(
    EntityScope scope,
  ) : this._internal(
          () => Teams()..scope = scope,
          from: teamsProvider,
          name: r'teamsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$teamsHash,
          dependencies: TeamsFamily._dependencies,
          allTransitiveDependencies: TeamsFamily._allTransitiveDependencies,
          scope: scope,
        );

  TeamsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.scope,
  }) : super.internal();

  final EntityScope scope;

  @override
  FutureOr<IList<TeamModel>> runNotifierBuild(
    covariant Teams notifier,
  ) {
    return notifier.build(
      scope,
    );
  }

  @override
  Override overrideWith(Teams Function() create) {
    return ProviderOverride(
      origin: this,
      override: TeamsProvider._internal(
        () => create()..scope = scope,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        scope: scope,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Teams, IList<TeamModel>>
      createElement() {
    return _TeamsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamsProvider && other.scope == scope;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, scope.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TeamsRef on AutoDisposeAsyncNotifierProviderRef<IList<TeamModel>> {
  /// The parameter `scope` of this provider.
  EntityScope get scope;
}

class _TeamsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Teams, IList<TeamModel>>
    with TeamsRef {
  _TeamsProviderElement(super.provider);

  @override
  EntityScope get scope => (origin as TeamsProvider).scope;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
