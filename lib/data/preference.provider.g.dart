// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$preferenceNotifierHash() =>
    r'2781871ad0ffed37357f7074b32c68d061050d02';

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

abstract class _$PreferenceNotifier
    extends BuildlessAutoDisposeNotifier<dynamic> {
  late final Preference pref;

  dynamic build(
    Preference pref,
  );
}

/// read
///
/// ref.watch(preferenceNotifierProvider(Preference.shouldShowWalkthrough));
///
/// write
///
/// ref.read(preferenceNotifierProvider(Preference.shouldShowWalkthrough).notifier).update(false);
///
/// Copied from [PreferenceNotifier].
@ProviderFor(PreferenceNotifier)
const preferenceNotifierProvider = PreferenceNotifierFamily();

/// read
///
/// ref.watch(preferenceNotifierProvider(Preference.shouldShowWalkthrough));
///
/// write
///
/// ref.read(preferenceNotifierProvider(Preference.shouldShowWalkthrough).notifier).update(false);
///
/// Copied from [PreferenceNotifier].
class PreferenceNotifierFamily extends Family<dynamic> {
  /// read
  ///
  /// ref.watch(preferenceNotifierProvider(Preference.shouldShowWalkthrough));
  ///
  /// write
  ///
  /// ref.read(preferenceNotifierProvider(Preference.shouldShowWalkthrough).notifier).update(false);
  ///
  /// Copied from [PreferenceNotifier].
  const PreferenceNotifierFamily();

  /// read
  ///
  /// ref.watch(preferenceNotifierProvider(Preference.shouldShowWalkthrough));
  ///
  /// write
  ///
  /// ref.read(preferenceNotifierProvider(Preference.shouldShowWalkthrough).notifier).update(false);
  ///
  /// Copied from [PreferenceNotifier].
  PreferenceNotifierProvider call(
    Preference pref,
  ) {
    return PreferenceNotifierProvider(
      pref,
    );
  }

  @override
  PreferenceNotifierProvider getProviderOverride(
    covariant PreferenceNotifierProvider provider,
  ) {
    return call(
      provider.pref,
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
  String? get name => r'preferenceNotifierProvider';
}

/// read
///
/// ref.watch(preferenceNotifierProvider(Preference.shouldShowWalkthrough));
///
/// write
///
/// ref.read(preferenceNotifierProvider(Preference.shouldShowWalkthrough).notifier).update(false);
///
/// Copied from [PreferenceNotifier].
class PreferenceNotifierProvider
    extends AutoDisposeNotifierProviderImpl<PreferenceNotifier, dynamic> {
  /// read
  ///
  /// ref.watch(preferenceNotifierProvider(Preference.shouldShowWalkthrough));
  ///
  /// write
  ///
  /// ref.read(preferenceNotifierProvider(Preference.shouldShowWalkthrough).notifier).update(false);
  ///
  /// Copied from [PreferenceNotifier].
  PreferenceNotifierProvider(
    Preference pref,
  ) : this._internal(
          () => PreferenceNotifier()..pref = pref,
          from: preferenceNotifierProvider,
          name: r'preferenceNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$preferenceNotifierHash,
          dependencies: PreferenceNotifierFamily._dependencies,
          allTransitiveDependencies:
              PreferenceNotifierFamily._allTransitiveDependencies,
          pref: pref,
        );

  PreferenceNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pref,
  }) : super.internal();

  final Preference pref;

  @override
  dynamic runNotifierBuild(
    covariant PreferenceNotifier notifier,
  ) {
    return notifier.build(
      pref,
    );
  }

  @override
  Override overrideWith(PreferenceNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PreferenceNotifierProvider._internal(
        () => create()..pref = pref,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pref: pref,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PreferenceNotifier, dynamic>
      createElement() {
    return _PreferenceNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PreferenceNotifierProvider && other.pref == pref;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pref.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PreferenceNotifierRef on AutoDisposeNotifierProviderRef<dynamic> {
  /// The parameter `pref` of this provider.
  Preference get pref;
}

class _PreferenceNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<PreferenceNotifier, dynamic>
    with PreferenceNotifierRef {
  _PreferenceNotifierProviderElement(super.provider);

  @override
  Preference get pref => (origin as PreferenceNotifierProvider).pref;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
