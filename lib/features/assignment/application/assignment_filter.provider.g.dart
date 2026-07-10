// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_filter.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// filters the list of assignment by certain

@ProviderFor(filterAssignments)
final filterAssignmentsProvider = FilterAssignmentsProvider._();

/// filters the list of assignment by certain

final class FilterAssignmentsProvider extends $FunctionalProvider<
        AsyncValue<List<AssignmentModel>>,
        List<AssignmentModel>,
        FutureOr<List<AssignmentModel>>>
    with
        $FutureModifier<List<AssignmentModel>>,
        $FutureProvider<List<AssignmentModel>> {
  /// filters the list of assignment by certain
  FilterAssignmentsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'filterAssignmentsProvider',
          isAutoDispose: true,
          dependencies: <ProviderOrFamily>[
            activityModelProvider,
            assignmentsProvider
          ],
          $allTransitiveDependencies: <ProviderOrFamily>[
            FilterAssignmentsProvider.$allTransitiveDependencies0,
            FilterAssignmentsProvider.$allTransitiveDependencies1,
          ],
        );

  static final $allTransitiveDependencies0 = activityModelProvider;
  static final $allTransitiveDependencies1 = assignmentsProvider;

  @override
  String debugGetCreateSourceHash() => _$filterAssignmentsHash();

  @$internal
  @override
  $FutureProviderElement<List<AssignmentModel>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<AssignmentModel>> create(Ref ref) {
    return filterAssignments(ref);
  }
}

String _$filterAssignmentsHash() => r'afc52dae3b02d91b311aebedf89b120d1da1353f';

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

String _$filterQueryHash() => r'a68b50397ff2453e39cfae241108214737a4d6fa';

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
