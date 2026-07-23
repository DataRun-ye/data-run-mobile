// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// read
///
/// ref.watch(preferenceProvider(Preference.shouldShowWalkthrough));
///
/// write
///
/// ref.read(preferenceProvider(Preference.shouldShowWalkthrough).notifier).update(false);

@ProviderFor(PreferenceNotifier)
final preferenceProvider = PreferenceNotifierFamily._();

/// read
///
/// ref.watch(preferenceProvider(Preference.shouldShowWalkthrough));
///
/// write
///
/// ref.read(preferenceProvider(Preference.shouldShowWalkthrough).notifier).update(false);
final class PreferenceNotifierProvider
    extends $NotifierProvider<PreferenceNotifier, dynamic> {
  /// read
  ///
  /// ref.watch(preferenceProvider(Preference.shouldShowWalkthrough));
  ///
  /// write
  ///
  /// ref.read(preferenceProvider(Preference.shouldShowWalkthrough).notifier).update(false);
  PreferenceNotifierProvider._(
      {required PreferenceNotifierFamily super.from,
      required Preference super.argument})
      : super(
          retry: null,
          name: r'preferenceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$preferenceNotifierHash();

  @override
  String toString() {
    return r'preferenceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PreferenceNotifier create() => PreferenceNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(dynamic value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<dynamic>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PreferenceNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$preferenceNotifierHash() =>
    r'c9461111d4c010929811f05fa73d52900233aa1b';

/// read
///
/// ref.watch(preferenceProvider(Preference.shouldShowWalkthrough));
///
/// write
///
/// ref.read(preferenceProvider(Preference.shouldShowWalkthrough).notifier).update(false);

final class PreferenceNotifierFamily extends $Family
    with
        $ClassFamilyOverride<PreferenceNotifier, dynamic, dynamic, dynamic,
            Preference> {
  PreferenceNotifierFamily._()
      : super(
          retry: null,
          name: r'preferenceProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// read
  ///
  /// ref.watch(preferenceProvider(Preference.shouldShowWalkthrough));
  ///
  /// write
  ///
  /// ref.read(preferenceProvider(Preference.shouldShowWalkthrough).notifier).update(false);

  PreferenceNotifierProvider call(
    Preference pref,
  ) =>
      PreferenceNotifierProvider._(argument: pref, from: this);

  @override
  String toString() => r'preferenceProvider';
}

/// read
///
/// ref.watch(preferenceProvider(Preference.shouldShowWalkthrough));
///
/// write
///
/// ref.read(preferenceProvider(Preference.shouldShowWalkthrough).notifier).update(false);

abstract class _$PreferenceNotifier extends $Notifier<dynamic> {
  late final _$args = ref.$arg as Preference;
  Preference get pref => _$args;

  dynamic build(
    Preference pref,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<dynamic, dynamic>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<dynamic, dynamic>, dynamic, Object?, Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
