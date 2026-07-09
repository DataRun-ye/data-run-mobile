// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_about_info.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appAboutInfo)
final appAboutInfoProvider = AppAboutInfoProvider._();

final class AppAboutInfoProvider extends $FunctionalProvider<
        AsyncValue<AppAbout>, AppAbout, FutureOr<AppAbout>>
    with $FutureModifier<AppAbout>, $FutureProvider<AppAbout> {
  AppAboutInfoProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appAboutInfoProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appAboutInfoHash();

  @$internal
  @override
  $FutureProviderElement<AppAbout> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AppAbout> create(Ref ref) {
    return appAboutInfo(ref);
  }
}

String _$appAboutInfoHash() => r'6aac77fa4f3592eadf8f4bcd72b56a937a332240';
