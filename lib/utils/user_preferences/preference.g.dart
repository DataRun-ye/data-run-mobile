// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'0924fb848ccdeb837f448bcb2b685bf4104dbd40';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeProvider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedPreferencesRef = AutoDisposeProviderRef<SharedPreferences>;
String _$preferenceNotifierHash() =>
    r'097ae1ac0bb26767211e4ad944731da199fa7cba';

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

abstract class _$PreferenceNotifier<T> extends BuildlessAutoDisposeNotifier<T> {
  late final Preference<T> pref;

  T build(
    Preference<T> pref,
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
class PreferenceNotifierFamily extends Family {
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

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'preferenceNotifierProvider';

  /// read
  ///
  /// ref.watch(preferenceNotifierProvider(Preference.shouldShowWalkthrough));
  ///
  /// write
  ///
  /// ref.read(preferenceNotifierProvider(Preference.shouldShowWalkthrough).notifier).update(false);
  ///
  /// Copied from [PreferenceNotifier].
  PreferenceNotifierProvider<T> call<T>(
    Preference<T> pref,
  ) {
    return PreferenceNotifierProvider<T>(
      pref,
    );
  }

  @visibleForOverriding
  @override
  PreferenceNotifierProvider<Object?> getProviderOverride(
    covariant PreferenceNotifierProvider<Object?> provider,
  ) {
    return call(
      provider.pref,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(PreferenceNotifier Function() create) {
    return _$PreferenceNotifierFamilyOverride(this, create);
  }
}

class _$PreferenceNotifierFamilyOverride implements FamilyOverride {
  _$PreferenceNotifierFamilyOverride(this.overriddenFamily, this.create);

  final PreferenceNotifier Function() create;

  @override
  final PreferenceNotifierFamily overriddenFamily;

  @override
  PreferenceNotifierProvider getProviderOverride(
    covariant PreferenceNotifierProvider provider,
  ) {
    return provider._copyWith(create);
  }
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
class PreferenceNotifierProvider<T>
    extends AutoDisposeNotifierProviderImpl<PreferenceNotifier<T>, T> {
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
    Preference<T> pref,
  ) : this._internal(
          () => PreferenceNotifier<T>()..pref = pref,
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
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pref,
  }) : super.internal();

  final Preference<T> pref;

  @override
  T runNotifierBuild(
    covariant PreferenceNotifier<T> notifier,
  ) {
    return notifier.build(
      pref,
    );
  }

  @override
  Override overrideWith(PreferenceNotifier<T> Function() create) {
    return ProviderOverride(
      origin: this,
      override: PreferenceNotifierProvider<T>._internal(
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
  (Preference<T>,) get argument {
    return (pref,);
  }

  @override
  AutoDisposeNotifierProviderElement<PreferenceNotifier<T>, T> createElement() {
    return _PreferenceNotifierProviderElement(this);
  }

  PreferenceNotifierProvider _copyWith(
    PreferenceNotifier Function() create,
  ) {
    return PreferenceNotifierProvider._internal(
      () => create()..pref = pref,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      pref: pref,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PreferenceNotifierProvider &&
        other.runtimeType == runtimeType &&
        other.pref == pref;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pref.hashCode);
    hash = _SystemHash.combine(hash, T.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PreferenceNotifierRef<T> on AutoDisposeNotifierProviderRef<T> {
  /// The parameter `pref` of this provider.
  Preference<T> get pref;
}

class _PreferenceNotifierProviderElement<T>
    extends AutoDisposeNotifierProviderElement<PreferenceNotifier<T>, T>
    with PreferenceNotifierRef<T> {
  _PreferenceNotifierProviderElement(super.provider);

  @override
  Preference<T> get pref => (origin as PreferenceNotifierProvider<T>).pref;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
