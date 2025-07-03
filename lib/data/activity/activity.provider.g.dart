// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activityModelHash() => r'66cbf967e19f27fef90a2ddb6ad8b56caa1de717';

/// See also [activityModel].
@ProviderFor(activityModel)
final activityModelProvider = AutoDisposeProvider<ActivityModel>.internal(
  activityModel,
  name: r'activityModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activityModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ActivityModelRef = AutoDisposeProviderRef<ActivityModel>;
String _$activitiesHash() => r'57cecd87d14a9cde29171f5a91daa6d79db188e2';

/// See also [activities].
@ProviderFor(activities)
final activitiesProvider =
    AutoDisposeFutureProvider<List<ActivityModel>>.internal(
  activities,
  name: r'activitiesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$activitiesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ActivitiesRef = AutoDisposeFutureProviderRef<List<ActivityModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
