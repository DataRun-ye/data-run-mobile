// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$teamsHash() => r'c66d3b5b09c7d1fa2507ec52abfa64e1956aed36';

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
class TeamsFamily extends Family {
  /// See also [Teams].
  const TeamsFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'teamsProvider';

  /// See also [Teams].
  TeamsProvider call(
    EntityScope scope,
  ) {
    return TeamsProvider(
      scope,
    );
  }

  @visibleForOverriding
  @override
  TeamsProvider getProviderOverride(
    covariant TeamsProvider provider,
  ) {
    return call(
      provider.scope,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(Teams Function() create) {
    return _$TeamsFamilyOverride(this, create);
  }
}

class _$TeamsFamilyOverride implements FamilyOverride {
  _$TeamsFamilyOverride(this.overriddenFamily, this.create);

  final Teams Function() create;

  @override
  final TeamsFamily overriddenFamily;

  @override
  TeamsProvider getProviderOverride(
    covariant TeamsProvider provider,
  ) {
    return provider._copyWith(create);
  }
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
    super.create, {
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
  (EntityScope,) get argument {
    return (scope,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Teams, IList<TeamModel>>
      createElement() {
    return _TeamsProviderElement(this);
  }

  TeamsProvider _copyWith(
    Teams Function() create,
  ) {
    return TeamsProvider._internal(
      () => create()..scope = scope,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      scope: scope,
    );
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
