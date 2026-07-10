// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_progress.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SyncProgress)
final syncProgressProvider = SyncProgressProvider._();

final class SyncProgressProvider
    extends $NotifierProvider<SyncProgress, WorkInfo> {
  SyncProgressProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'syncProgressProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$syncProgressHash();

  @$internal
  @override
  SyncProgress create() => SyncProgress();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkInfo>(value),
    );
  }
}

String _$syncProgressHash() => r'83a4999aa1cf60f526d5f2c21ea3b1d80a9490fa';

abstract class _$SyncProgress extends $Notifier<WorkInfo> {
  WorkInfo build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<WorkInfo, WorkInfo>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<WorkInfo, WorkInfo>, WorkInfo, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
