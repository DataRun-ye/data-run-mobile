// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_filter.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filterAssignmentsHash() => r'afc52dae3b02d91b311aebedf89b120d1da1353f';

/// filters the list of assignment by certain
///
/// Copied from [filterAssignments].
@ProviderFor(filterAssignments)
final filterAssignmentsProvider =
    AutoDisposeFutureProvider<List<AssignmentModel>>.internal(
  filterAssignments,
  name: r'filterAssignmentsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filterAssignmentsHash,
  dependencies: <ProviderOrFamily>[activityModelProvider, assignmentsProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    activityModelProvider,
    ...?activityModelProvider.allTransitiveDependencies,
    assignmentsProvider,
    ...?assignmentsProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilterAssignmentsRef
    = AutoDisposeFutureProviderRef<List<AssignmentModel>>;
String _$filterQueryHash() => r'a68b50397ff2453e39cfae241108214737a4d6fa';

/// filter query model notifier that store filtering cretirias
///
/// Copied from [FilterQuery].
@ProviderFor(FilterQuery)
final filterQueryProvider =
    AutoDisposeNotifierProvider<FilterQuery, AssignmentFilterQuery>.internal(
  FilterQuery.new,
  name: r'filterQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$filterQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FilterQuery = AutoDisposeNotifier<AssignmentFilterQuery>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
