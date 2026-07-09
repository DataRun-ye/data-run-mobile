// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_connectivity.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IsOnline)
final isOnlineProvider = IsOnlineProvider._();

final class IsOnlineProvider extends $AsyncNotifierProvider<IsOnline, bool> {
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
  IsOnline create() => IsOnline();
}

String _$isOnlineHash() => r'b5979ccd1dab1f117a66be0775ab685d4ad47632';

abstract class _$IsOnline extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<bool>, bool>,
        AsyncValue<bool>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
