// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_model.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$assignmentFormsHash() => r'679feabe8ff667434b4e94b3b2b27e932bfe9c69';

/// See also [assignmentForms].
@ProviderFor(assignmentForms)
final assignmentFormsProvider =
    AutoDisposeFutureProvider<List<FormVersion>>.internal(
  assignmentForms,
  name: r'assignmentFormsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$assignmentFormsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AssignmentFormsRef = AutoDisposeFutureProviderRef<List<FormVersion>>;
String _$assignmentHash() => r'3680f33d2aee3ba8b00eef4c55c38b17a38400d2';

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
String _$assignmentsHash() => r'53c0de5cc625af698879830cad9f25ecd77587eb';

/// a notifier that retrieves all assignments with their data populated
///
/// Copied from [Assignments].
@ProviderFor(Assignments)
final assignmentsProvider = AutoDisposeAsyncNotifierProvider<Assignments,
    List<AssignmentModel>>.internal(
  Assignments.new,
  name: r'assignmentsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$assignmentsHash,
  dependencies: <ProviderOrFamily>[activityModelProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    activityModelProvider,
    ...?activityModelProvider.allTransitiveDependencies
  },
);

typedef _$Assignments = AutoDisposeAsyncNotifier<List<AssignmentModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
