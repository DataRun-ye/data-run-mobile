// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_controller.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TableController)
final tableControllerProvider = TableControllerProvider._();

final class TableControllerProvider
    extends $AsyncNotifierProvider<TableController, void> {
  TableControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'tableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tableControllerHash();

  @$internal
  @override
  TableController create() => TableController();
}

String _$tableControllerHash() => r'5b25b438a4e1a0d05fe0d16d5ff06a2cf6bb7de4';

abstract class _$TableController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<void>, void>,
        AsyncValue<void>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
