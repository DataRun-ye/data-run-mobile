// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'if_online_abstract.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// a StreamProvider that emits true/false as the internet comes and goes

@ProviderFor(isOnline)
final isOnlineProvider = IsOnlineProvider._();

/// a StreamProvider that emits true/false as the internet comes and goes

final class IsOnlineProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  /// a StreamProvider that emits true/false as the internet comes and goes
  IsOnlineProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isOnlineProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isOnlineHash();

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    return isOnline(ref);
  }
}

String _$isOnlineHash() => r'7e44c51cbd24b968f78c86de6cfbdf2f66b56351';
