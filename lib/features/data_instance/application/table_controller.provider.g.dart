// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_controller.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TableController)
final tableControllerProvider = TableControllerFamily._();

final class TableControllerProvider
    extends $NotifierProvider<TableController, ISet<String>> {
  TableControllerProvider._(
      {required TableControllerFamily super.from,
      required ({
        String formId,
        String? assignmentId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'tableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tableControllerHash();

  @override
  String toString() {
    return r'tableControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  TableController create() => TableController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ISet<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ISet<String>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TableControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tableControllerHash() => r'cc2f495be40e1ceb32cc328ee7feff634d73b6b9';

final class TableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            TableController,
            ISet<String>,
            ISet<String>,
            ISet<String>,
            ({
              String formId,
              String? assignmentId,
            })> {
  TableControllerFamily._()
      : super(
          retry: null,
          name: r'tableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  TableControllerProvider call({
    required String formId,
    String? assignmentId,
  }) =>
      TableControllerProvider._(argument: (
        formId: formId,
        assignmentId: assignmentId,
      ), from: this);

  @override
  String toString() => r'tableControllerProvider';
}

abstract class _$TableController extends $Notifier<ISet<String>> {
  late final _$args = ref.$arg as ({
    String formId,
    String? assignmentId,
  });
  String get formId => _$args.formId;
  String? get assignmentId => _$args.assignmentId;

  ISet<String> build({
    required String formId,
    String? assignmentId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ISet<String>, ISet<String>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ISet<String>, ISet<String>>,
        ISet<String>,
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

@ProviderFor(selectedFinalizedItem)
final selectedFinalizedItemProvider = SelectedFinalizedItemFamily._();

final class SelectedFinalizedItemProvider extends $FunctionalProvider<
        AsyncValue<ISet<String>>, ISet<String>, FutureOr<ISet<String>>>
    with $FutureModifier<ISet<String>>, $FutureProvider<ISet<String>> {
  SelectedFinalizedItemProvider._(
      {required SelectedFinalizedItemFamily super.from,
      required ({
        String formId,
        String? assignmentId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'selectedFinalizedItemProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$selectedFinalizedItemHash();

  @override
  String toString() {
    return r'selectedFinalizedItemProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<ISet<String>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ISet<String>> create(Ref ref) {
    final argument = this.argument as ({
      String formId,
      String? assignmentId,
    });
    return selectedFinalizedItem(
      ref,
      formId: argument.formId,
      assignmentId: argument.assignmentId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedFinalizedItemProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedFinalizedItemHash() =>
    r'8d608887898fea01bc4fe97b7447badf77bad4f3';

final class SelectedFinalizedItemFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<ISet<String>>,
            ({
              String formId,
              String? assignmentId,
            })> {
  SelectedFinalizedItemFamily._()
      : super(
          retry: null,
          name: r'selectedFinalizedItemProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  SelectedFinalizedItemProvider call({
    required String formId,
    String? assignmentId,
  }) =>
      SelectedFinalizedItemProvider._(argument: (
        formId: formId,
        assignmentId: assignmentId,
      ), from: this);

  @override
  String toString() => r'selectedFinalizedItemProvider';
}
