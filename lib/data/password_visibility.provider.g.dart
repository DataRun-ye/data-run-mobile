// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_visibility.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PasswordVisibility)
final passwordVisibilityProvider = PasswordVisibilityProvider._();

final class PasswordVisibilityProvider
    extends $NotifierProvider<PasswordVisibility, bool> {
  PasswordVisibilityProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'passwordVisibilityProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$passwordVisibilityHash();

  @$internal
  @override
  PasswordVisibility create() => PasswordVisibility();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$passwordVisibilityHash() =>
    r'8d390ed6a44b5f46add91af55715063553f16792';

abstract class _$PasswordVisibility extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
