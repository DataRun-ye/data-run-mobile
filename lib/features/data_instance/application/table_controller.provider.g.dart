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
    extends $AsyncNotifierProvider<TableController, TableState> {
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

String _$tableControllerHash() => r'3133d13bc53d843441f3bb67b775493ba6cb88e6';

abstract class _$TableController extends $AsyncNotifier<TableState> {
  FutureOr<TableState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<TableState>, TableState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<TableState>, TableState>,
        AsyncValue<TableState>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
