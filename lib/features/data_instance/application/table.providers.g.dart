// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DataInstanceFilter)
final dataInstanceFilterProvider = DataInstanceFilterFamily._();

final class DataInstanceFilterProvider
    extends $NotifierProvider<DataInstanceFilter, SubmissionsFilter> {
  DataInstanceFilterProvider._(
      {required DataInstanceFilterFamily super.from,
      required ({
        String formId,
        String? assignmentId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'dataInstanceFilterProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dataInstanceFilterHash();

  @override
  String toString() {
    return r'dataInstanceFilterProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  DataInstanceFilter create() => DataInstanceFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubmissionsFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubmissionsFilter>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DataInstanceFilterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dataInstanceFilterHash() =>
    r'091d5bb718eadfe76b6933abd7b1fca6c21c5d8e';

final class DataInstanceFilterFamily extends $Family
    with
        $ClassFamilyOverride<
            DataInstanceFilter,
            SubmissionsFilter,
            SubmissionsFilter,
            SubmissionsFilter,
            ({
              String formId,
              String? assignmentId,
            })> {
  DataInstanceFilterFamily._()
      : super(
          retry: null,
          name: r'dataInstanceFilterProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  DataInstanceFilterProvider call({
    required String formId,
    String? assignmentId,
  }) =>
      DataInstanceFilterProvider._(argument: (
        formId: formId,
        assignmentId: assignmentId,
      ), from: this);

  @override
  String toString() => r'dataInstanceFilterProvider';
}

abstract class _$DataInstanceFilter extends $Notifier<SubmissionsFilter> {
  late final _$args = ref.$arg as ({
    String formId,
    String? assignmentId,
  });
  String get formId => _$args.formId;
  String? get assignmentId => _$args.assignmentId;

  SubmissionsFilter build({
    required String formId,
    String? assignmentId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SubmissionsFilter, SubmissionsFilter>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<SubmissionsFilter, SubmissionsFilter>,
        SubmissionsFilter,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              formId: _$args.formId,
              assignmentId: _$args.assignmentId,
            ));
  }
}

@ProviderFor(totalItemsStream)
final totalItemsStreamProvider = TotalItemsStreamFamily._();

final class TotalItemsStreamProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  TotalItemsStreamProvider._(
      {required TotalItemsStreamFamily super.from,
      required SubmissionsFilter super.argument})
      : super(
          retry: null,
          name: r'totalItemsStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$totalItemsStreamHash();

  @override
  String toString() {
    return r'totalItemsStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    final argument = this.argument as SubmissionsFilter;
    return totalItemsStream(
      ref,
      templateFilter: argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TotalItemsStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$totalItemsStreamHash() => r'3af0341bc7c0495859ed213d12ed353aa8c1c0bb';

final class TotalItemsStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<int>, SubmissionsFilter> {
  TotalItemsStreamFamily._()
      : super(
          retry: null,
          name: r'totalItemsStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  TotalItemsStreamProvider call({
    required SubmissionsFilter templateFilter,
  }) =>
      TotalItemsStreamProvider._(argument: templateFilter, from: this);

  @override
  String toString() => r'totalItemsStreamProvider';
}

@ProviderFor(totalItems)
final totalItemsProvider = TotalItemsFamily._();

final class TotalItemsProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  TotalItemsProvider._(
      {required TotalItemsFamily super.from,
      required SubmissionsFilter super.argument})
      : super(
          retry: null,
          name: r'totalItemsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$totalItemsHash();

  @override
  String toString() {
    return r'totalItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    final argument = this.argument as SubmissionsFilter;
    return totalItems(
      ref,
      templateFilter: argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TotalItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$totalItemsHash() => r'3bf366f0ea1818df1c69eae456c65cd00cb80add';

final class TotalItemsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int>, SubmissionsFilter> {
  TotalItemsFamily._()
      : super(
          retry: null,
          name: r'totalItemsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  TotalItemsProvider call({
    required SubmissionsFilter templateFilter,
  }) =>
      TotalItemsProvider._(argument: templateFilter, from: this);

  @override
  String toString() => r'totalItemsProvider';
}

@ProviderFor(TablePagination)
final tablePaginationProvider = TablePaginationProvider._();

final class TablePaginationProvider
    extends $NotifierProvider<TablePagination, Pagination> {
  TablePaginationProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'tablePaginationProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tablePaginationHash();

  @$internal
  @override
  TablePagination create() => TablePagination();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Pagination value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Pagination>(value),
    );
  }
}

String _$tablePaginationHash() => r'2147240643591eed88d3d8eef8cbd5b2d683417d';

abstract class _$TablePagination extends $Notifier<Pagination> {
  Pagination build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Pagination, Pagination>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Pagination, Pagination>, Pagination, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedItems)
final selectedItemsProvider = SelectedItemsProvider._();

final class SelectedItemsProvider
    extends $NotifierProvider<SelectedItems, ISet<String>> {
  SelectedItemsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'selectedItemsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$selectedItemsHash();

  @$internal
  @override
  SelectedItems create() => SelectedItems();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ISet<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ISet<String>>(value),
    );
  }
}

String _$selectedItemsHash() => r'c160887e2af4eb7f57ca168ce4018b32cd3bbc0a';

abstract class _$SelectedItems extends $Notifier<ISet<String>> {
  ISet<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ISet<String>, ISet<String>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ISet<String>, ISet<String>>,
        ISet<String>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(selectedFinalizedItem)
final selectedFinalizedItemProvider = SelectedFinalizedItemProvider._();

final class SelectedFinalizedItemProvider extends $FunctionalProvider<
        AsyncValue<ISet<String>>, ISet<String>, FutureOr<ISet<String>>>
    with $FutureModifier<ISet<String>>, $FutureProvider<ISet<String>> {
  SelectedFinalizedItemProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'selectedFinalizedItemProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$selectedFinalizedItemHash();

  @$internal
  @override
  $FutureProviderElement<ISet<String>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ISet<String>> create(Ref ref) {
    return selectedFinalizedItem(ref);
  }
}

String _$selectedFinalizedItemHash() =>
    r'351b2c427818867cd0e6edd2a87de565ee4ce0ad';

@ProviderFor(TableAppearanceController)
final tableAppearanceControllerProvider = TableAppearanceControllerProvider._();

final class TableAppearanceControllerProvider
    extends $NotifierProvider<TableAppearanceController, TableAppearance> {
  TableAppearanceControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'tableAppearanceControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tableAppearanceControllerHash();

  @$internal
  @override
  TableAppearanceController create() => TableAppearanceController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TableAppearance value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TableAppearance>(value),
    );
  }
}

String _$tableAppearanceControllerHash() =>
    r'935c795f09a9163848e7cca7d5f02833af78cdaa';

abstract class _$TableAppearanceController extends $Notifier<TableAppearance> {
  TableAppearance build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TableAppearance, TableAppearance>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<TableAppearance, TableAppearance>,
        TableAppearance,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
