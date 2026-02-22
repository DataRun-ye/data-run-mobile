// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_resolver.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$partyResolverHash() => r'bcb3e1624efee10e7c064dafb52c5c8882c5301f';

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

abstract class _$PartyResolver
    extends BuildlessAutoDisposeAsyncNotifier<List<Party>> {
  late final PartyResolutionParams params;

  FutureOr<List<Party>> build(
    PartyResolutionParams params,
  );
}

/// See also [PartyResolver].
@ProviderFor(PartyResolver)
const partyResolverProvider = PartyResolverFamily();

/// See also [PartyResolver].
class PartyResolverFamily extends Family<AsyncValue<List<Party>>> {
  /// See also [PartyResolver].
  const PartyResolverFamily();

  /// See also [PartyResolver].
  PartyResolverProvider call(
    PartyResolutionParams params,
  ) {
    return PartyResolverProvider(
      params,
    );
  }

  @override
  PartyResolverProvider getProviderOverride(
    covariant PartyResolverProvider provider,
  ) {
    return call(
      provider.params,
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
  String? get name => r'partyResolverProvider';
}

/// See also [PartyResolver].
class PartyResolverProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PartyResolver, List<Party>> {
  /// See also [PartyResolver].
  PartyResolverProvider(
    PartyResolutionParams params,
  ) : this._internal(
          () => PartyResolver()..params = params,
          from: partyResolverProvider,
          name: r'partyResolverProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$partyResolverHash,
          dependencies: PartyResolverFamily._dependencies,
          allTransitiveDependencies:
              PartyResolverFamily._allTransitiveDependencies,
          params: params,
        );

  PartyResolverProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final PartyResolutionParams params;

  @override
  FutureOr<List<Party>> runNotifierBuild(
    covariant PartyResolver notifier,
  ) {
    return notifier.build(
      params,
    );
  }

  @override
  Override overrideWith(PartyResolver Function() create) {
    return ProviderOverride(
      origin: this,
      override: PartyResolverProvider._internal(
        () => create()..params = params,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PartyResolver, List<Party>>
      createElement() {
    return _PartyResolverProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PartyResolverProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PartyResolverRef on AutoDisposeAsyncNotifierProviderRef<List<Party>> {
  /// The parameter `params` of this provider.
  PartyResolutionParams get params;
}

class _PartyResolverProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PartyResolver, List<Party>>
    with PartyResolverRef {
  _PartyResolverProviderElement(super.provider);

  @override
  PartyResolutionParams get params => (origin as PartyResolverProvider).params;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
