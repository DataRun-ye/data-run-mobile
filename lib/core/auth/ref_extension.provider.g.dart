// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ref_extension.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authNotifier)
final authProvider = AuthNotifierProvider._();

final class AuthNotifierProvider extends $FunctionalProvider<Raw<AuthManager>,
    Raw<AuthManager>, Raw<AuthManager>> with $Provider<Raw<AuthManager>> {
  AuthNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authNotifierHash();

  @$internal
  @override
  $ProviderElement<Raw<AuthManager>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Raw<AuthManager> create(Ref ref) {
    return authNotifier(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Raw<AuthManager> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Raw<AuthManager>>(value),
    );
  }
}

String _$authNotifierHash() => r'ab5f95021aadc2c2813686f4264fa5093b6302b0';

@ProviderFor(localeNotifier)
final localeProvider = LocaleNotifierProvider._();

final class LocaleNotifierProvider extends $FunctionalProvider<
    Raw<ChangeNotifier>,
    Raw<ChangeNotifier>,
    Raw<ChangeNotifier>> with $Provider<Raw<ChangeNotifier>> {
  LocaleNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'localeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$localeNotifierHash();

  @$internal
  @override
  $ProviderElement<Raw<ChangeNotifier>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Raw<ChangeNotifier> create(Ref ref) {
    return localeNotifier(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Raw<ChangeNotifier> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Raw<ChangeNotifier>>(value),
    );
  }
}

String _$localeNotifierHash() => r'951ed6457bf93e85c62714ec41e8421c967ca9c1';
