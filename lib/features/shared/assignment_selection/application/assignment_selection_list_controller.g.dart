// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_selection_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$assignmentSelectionListControllerHash() =>
    r'e7d7330ce63cc8e36ca92903b8a3270729c08d2e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AssignmentSelectionListController
    extends BuildlessAutoDisposeAsyncNotifier<
        PagingState<int, AssignmentModel>> {
  late final String? activity;
  late final int pageSize;

  FutureOr<PagingState<int, AssignmentModel>> build({
    String? activity,
    int pageSize = 20,
  });
}

/// See also [AssignmentSelectionListController].
@ProviderFor(AssignmentSelectionListController)
const assignmentSelectionListControllerProvider =
    AssignmentSelectionListControllerFamily();

/// See also [AssignmentSelectionListController].
class AssignmentSelectionListControllerFamily
    extends Family<AsyncValue<PagingState<int, AssignmentModel>>> {
  /// See also [AssignmentSelectionListController].
  const AssignmentSelectionListControllerFamily();

  /// See also [AssignmentSelectionListController].
  AssignmentSelectionListControllerProvider call({
    String? activity,
    int pageSize = 20,
  }) {
    return AssignmentSelectionListControllerProvider(
      activity: activity,
      pageSize: pageSize,
    );
  }

  @override
  AssignmentSelectionListControllerProvider getProviderOverride(
    covariant AssignmentSelectionListControllerProvider provider,
  ) {
    return call(
      activity: provider.activity,
      pageSize: provider.pageSize,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'assignmentSelectionListControllerProvider';
}

/// See also [AssignmentSelectionListController].
class AssignmentSelectionListControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        AssignmentSelectionListController, PagingState<int, AssignmentModel>> {
  /// See also [AssignmentSelectionListController].
  AssignmentSelectionListControllerProvider({
    String? activity,
    int pageSize = 20,
  }) : this._internal(
          () => AssignmentSelectionListController()
            ..activity = activity
            ..pageSize = pageSize,
          from: assignmentSelectionListControllerProvider,
          name: r'assignmentSelectionListControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$assignmentSelectionListControllerHash,
          dependencies: AssignmentSelectionListControllerFamily._dependencies,
          allTransitiveDependencies: AssignmentSelectionListControllerFamily
              ._allTransitiveDependencies,
          activity: activity,
          pageSize: pageSize,
        );

  AssignmentSelectionListControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.activity,
    required this.pageSize,
  }) : super.internal();

  final String? activity;
  final int pageSize;

  @override
  FutureOr<PagingState<int, AssignmentModel>> runNotifierBuild(
    covariant AssignmentSelectionListController notifier,
  ) {
    return notifier.build(
      activity: activity,
      pageSize: pageSize,
    );
  }

  @override
  Override overrideWith(AssignmentSelectionListController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AssignmentSelectionListControllerProvider._internal(
        () => create()
          ..activity = activity
          ..pageSize = pageSize,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        activity: activity,
        pageSize: pageSize,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AssignmentSelectionListController,
      PagingState<int, AssignmentModel>> createElement() {
    return _AssignmentSelectionListControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AssignmentSelectionListControllerProvider &&
        other.activity == activity &&
        other.pageSize == pageSize;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, activity.hashCode);
    hash = _SystemHash.combine(hash, pageSize.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AssignmentSelectionListControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PagingState<int, AssignmentModel>> {
  /// The parameter `activity` of this provider.
  String? get activity;

  /// The parameter `pageSize` of this provider.
  int get pageSize;
}

class _AssignmentSelectionListControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        AssignmentSelectionListController, PagingState<int, AssignmentModel>>
    with AssignmentSelectionListControllerRef {
  _AssignmentSelectionListControllerProviderElement(super.provider);

  @override
  String? get activity =>
      (origin as AssignmentSelectionListControllerProvider).activity;
  @override
  int get pageSize =>
      (origin as AssignmentSelectionListControllerProvider).pageSize;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
