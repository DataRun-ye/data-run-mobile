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
    r'7fc3baca83c1cae827095a967d644d722c32785e';

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

String _$totalItemsStreamHash() => r'61d818a9cd3d3c64ed658b6bee517b9736c758d5';

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
    r'ba076a48fe1b4bbe359e27d6da2e40201d59ead7';

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
