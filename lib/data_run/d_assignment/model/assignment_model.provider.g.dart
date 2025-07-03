// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_model.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$assignmentHash() => r'02f87ffeee92adc173256978cece63f9257656aa';

/// See also [assignment].
@ProviderFor(assignment)
final assignmentProvider = AutoDisposeProvider<AssignmentModel>.internal(
  assignment,
  name: r'assignmentProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$assignmentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AssignmentRef = AutoDisposeProviderRef<AssignmentModel>;
String _$filterAssignmentsHash() => r'0971531f6be01d30e8bb20d934fd4c15d9ae23f4';

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
  dependencies: <ProviderOrFamily>[
    activityModelProvider,
    assignmentModelsProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    activityModelProvider,
    ...?activityModelProvider.allTransitiveDependencies,
    assignmentModelsProvider,
    ...?assignmentModelsProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilterAssignmentsRef
    = AutoDisposeFutureProviderRef<List<AssignmentModel>>;
String _$assignmentModelsHash() => r'f61e6010c04338ff622a2314b661058e0f13fde2';

/// a notifier that retrieves all assignments with their data populated
///
/// Copied from [AssignmentModels].
@ProviderFor(AssignmentModels)
final assignmentModelsProvider = AutoDisposeAsyncNotifierProvider<
    AssignmentModels, List<AssignmentModel>>.internal(
  AssignmentModels.new,
  name: r'assignmentModelsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$assignmentModelsHash,
  dependencies: <ProviderOrFamily>[activityModelProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    activityModelProvider,
    ...?activityModelProvider.allTransitiveDependencies
  },
);

typedef _$AssignmentModels = AutoDisposeAsyncNotifier<List<AssignmentModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
