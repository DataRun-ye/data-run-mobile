// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_filter.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// filters the list of assignment by certain

@ProviderFor(filterAssignments)
final filterAssignmentsProvider = FilterAssignmentsFamily._();

/// filters the list of assignment by certain

final class FilterAssignmentsProvider extends $FunctionalProvider<
        AsyncValue<List<AssignmentModel>>,
        List<AssignmentModel>,
        FutureOr<List<AssignmentModel>>>
    with
        $FutureModifier<List<AssignmentModel>>,
        $FutureProvider<List<AssignmentModel>> {
  /// filters the list of assignment by certain
  FilterAssignmentsProvider._(
      {required FilterAssignmentsFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'filterAssignmentsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$filterAssignmentsHash();

  @override
  String toString() {
    return r'filterAssignmentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<AssignmentModel>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<AssignmentModel>> create(Ref ref) {
    final argument = this.argument as String;
    return filterAssignments(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilterAssignmentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filterAssignmentsHash() => r'fc771c45395f1ee54dc091ec2abb7b569612c1ff';

/// filters the list of assignment by certain

final class FilterAssignmentsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<AssignmentModel>>, String> {
  FilterAssignmentsFamily._()
      : super(
          retry: null,
          name: r'filterAssignmentsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// filters the list of assignment by certain

  FilterAssignmentsProvider call(
    String activityId,
  ) =>
      FilterAssignmentsProvider._(argument: activityId, from: this);

  @override
  String toString() => r'filterAssignmentsProvider';
}

/// filter query model notifier that store filtering cretirias

@ProviderFor(FilterQuery)
final filterQueryProvider = FilterQueryProvider._();

/// filter query model notifier that store filtering cretirias
final class FilterQueryProvider
    extends $NotifierProvider<FilterQuery, AssignmentFilterQuery> {
  /// filter query model notifier that store filtering cretirias
  FilterQueryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'filterQueryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$filterQueryHash();

  @$internal
  @override
  FilterQuery create() => FilterQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssignmentFilterQuery value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssignmentFilterQuery>(value),
    );
  }
}

String _$filterQueryHash() => r'dd65b73b7b12917a4001e583f07e8d50f21f446c';

/// filter query model notifier that store filtering cretirias

abstract class _$FilterQuery extends $Notifier<AssignmentFilterQuery> {
  AssignmentFilterQuery build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AssignmentFilterQuery, AssignmentFilterQuery>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AssignmentFilterQuery, AssignmentFilterQuery>,
        AssignmentFilterQuery,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
