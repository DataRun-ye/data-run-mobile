// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filterAssignmentsHash() => r'26bcc4b3391fd71d3c63fa4cc34dad5a3913b047';

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

/// filters the list of assignment by certain
///
/// Copied from [filterAssignments].
@ProviderFor(filterAssignments)
const filterAssignmentsProvider = FilterAssignmentsFamily();

/// filters the list of assignment by certain
///
/// Copied from [filterAssignments].
class FilterAssignmentsFamily extends Family {
  /// filters the list of assignment by certain
  ///
  /// Copied from [filterAssignments].
  const FilterAssignmentsFamily();

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    activityModelProvider
  ];

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    activityModelProvider,
    ...?activityModelProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filterAssignmentsProvider';

  /// filters the list of assignment by certain
  ///
  /// Copied from [filterAssignments].
  FilterAssignmentsProvider call([
    EntityScope? scope,
  ]) {
    return FilterAssignmentsProvider(
      scope,
    );
  }

  @visibleForOverriding
  @override
  FilterAssignmentsProvider getProviderOverride(
    covariant FilterAssignmentsProvider provider,
  ) {
    return call(
      provider.scope,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<AssignmentModel>> Function(FilterAssignmentsRef ref)
          create) {
    return _$FilterAssignmentsFamilyOverride(this, create);
  }
}

class _$FilterAssignmentsFamilyOverride implements FamilyOverride {
  _$FilterAssignmentsFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<AssignmentModel>> Function(FilterAssignmentsRef ref)
      create;

  @override
  final FilterAssignmentsFamily overriddenFamily;

  @override
  FilterAssignmentsProvider getProviderOverride(
    covariant FilterAssignmentsProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// filters the list of assignment by certain
///
/// Copied from [filterAssignments].
class FilterAssignmentsProvider
    extends AutoDisposeFutureProvider<List<AssignmentModel>> {
  /// filters the list of assignment by certain
  ///
  /// Copied from [filterAssignments].
  FilterAssignmentsProvider([
    EntityScope? scope,
  ]) : this._internal(
          (ref) => filterAssignments(
            ref as FilterAssignmentsRef,
            scope,
          ),
          from: filterAssignmentsProvider,
          name: r'filterAssignmentsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filterAssignmentsHash,
          dependencies: FilterAssignmentsFamily._dependencies,
          allTransitiveDependencies:
              FilterAssignmentsFamily._allTransitiveDependencies,
          scope: scope,
        );

  FilterAssignmentsProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.scope,
  }) : super.internal();

  final EntityScope? scope;

  @override
  Override overrideWith(
    FutureOr<List<AssignmentModel>> Function(FilterAssignmentsRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilterAssignmentsProvider._internal(
        (ref) => create(ref as FilterAssignmentsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        scope: scope,
      ),
    );
  }

  @override
  (EntityScope?,) get argument {
    return (scope,);
  }

  @override
  AutoDisposeFutureProviderElement<List<AssignmentModel>> createElement() {
    return _FilterAssignmentsProviderElement(this);
  }

  FilterAssignmentsProvider _copyWith(
    FutureOr<List<AssignmentModel>> Function(FilterAssignmentsRef ref) create,
  ) {
    return FilterAssignmentsProvider._internal(
      (ref) => create(ref as FilterAssignmentsRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      scope: scope,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilterAssignmentsProvider && other.scope == scope;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, scope.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FilterAssignmentsRef
    on AutoDisposeFutureProviderRef<List<AssignmentModel>> {
  /// The parameter `scope` of this provider.
  EntityScope? get scope;
}

class _FilterAssignmentsProviderElement
    extends AutoDisposeFutureProviderElement<List<AssignmentModel>>
    with FilterAssignmentsRef {
  _FilterAssignmentsProviderElement(super.provider);

  @override
  EntityScope? get scope => (origin as FilterAssignmentsProvider).scope;
}

String _$assignmentSubmissionsHash() =>
    r'4730a8095f4f5e40edcc38c46837b7b202e948ba';

abstract class _$AssignmentSubmissions
    extends BuildlessAutoDisposeAsyncNotifier<List<DataFormSubmission>> {
  late final String assignmentId;
  late final String form;

  FutureOr<List<DataFormSubmission>> build(
    String assignmentId, {
    required String form,
  });
}

/// retrieve a certain assignment forms submissions
///
/// Copied from [AssignmentSubmissions].
@ProviderFor(AssignmentSubmissions)
const assignmentSubmissionsProvider = AssignmentSubmissionsFamily();

/// retrieve a certain assignment forms submissions
///
/// Copied from [AssignmentSubmissions].
class AssignmentSubmissionsFamily extends Family {
  /// retrieve a certain assignment forms submissions
  ///
  /// Copied from [AssignmentSubmissions].
  const AssignmentSubmissionsFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'assignmentSubmissionsProvider';

  /// retrieve a certain assignment forms submissions
  ///
  /// Copied from [AssignmentSubmissions].
  AssignmentSubmissionsProvider call(
    String assignmentId, {
    required String form,
  }) {
    return AssignmentSubmissionsProvider(
      assignmentId,
      form: form,
    );
  }

  @visibleForOverriding
  @override
  AssignmentSubmissionsProvider getProviderOverride(
    covariant AssignmentSubmissionsProvider provider,
  ) {
    return call(
      provider.assignmentId,
      form: provider.form,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(AssignmentSubmissions Function() create) {
    return _$AssignmentSubmissionsFamilyOverride(this, create);
  }
}

class _$AssignmentSubmissionsFamilyOverride implements FamilyOverride {
  _$AssignmentSubmissionsFamilyOverride(this.overriddenFamily, this.create);

  final AssignmentSubmissions Function() create;

  @override
  final AssignmentSubmissionsFamily overriddenFamily;

  @override
  AssignmentSubmissionsProvider getProviderOverride(
    covariant AssignmentSubmissionsProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// retrieve a certain assignment forms submissions
///
/// Copied from [AssignmentSubmissions].
class AssignmentSubmissionsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AssignmentSubmissions,
        List<DataFormSubmission>> {
  /// retrieve a certain assignment forms submissions
  ///
  /// Copied from [AssignmentSubmissions].
  AssignmentSubmissionsProvider(
    String assignmentId, {
    required String form,
  }) : this._internal(
          () => AssignmentSubmissions()
            ..assignmentId = assignmentId
            ..form = form,
          from: assignmentSubmissionsProvider,
          name: r'assignmentSubmissionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$assignmentSubmissionsHash,
          dependencies: AssignmentSubmissionsFamily._dependencies,
          allTransitiveDependencies:
              AssignmentSubmissionsFamily._allTransitiveDependencies,
          assignmentId: assignmentId,
          form: form,
        );

  AssignmentSubmissionsProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.assignmentId,
    required this.form,
  }) : super.internal();

  final String assignmentId;
  final String form;

  @override
  FutureOr<List<DataFormSubmission>> runNotifierBuild(
    covariant AssignmentSubmissions notifier,
  ) {
    return notifier.build(
      assignmentId,
      form: form,
    );
  }

  @override
  Override overrideWith(AssignmentSubmissions Function() create) {
    return ProviderOverride(
      origin: this,
      override: AssignmentSubmissionsProvider._internal(
        () => create()
          ..assignmentId = assignmentId
          ..form = form,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        assignmentId: assignmentId,
        form: form,
      ),
    );
  }

  @override
  (
    String, {
    String form,
  }) get argument {
    return (
      assignmentId,
      form: form,
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AssignmentSubmissions,
      List<DataFormSubmission>> createElement() {
    return _AssignmentSubmissionsProviderElement(this);
  }

  AssignmentSubmissionsProvider _copyWith(
    AssignmentSubmissions Function() create,
  ) {
    return AssignmentSubmissionsProvider._internal(
      () => create()
        ..assignmentId = assignmentId
        ..form = form,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      assignmentId: assignmentId,
      form: form,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AssignmentSubmissionsProvider &&
        other.assignmentId == assignmentId &&
        other.form == form;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, assignmentId.hashCode);
    hash = _SystemHash.combine(hash, form.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AssignmentSubmissionsRef
    on AutoDisposeAsyncNotifierProviderRef<List<DataFormSubmission>> {
  /// The parameter `assignmentId` of this provider.
  String get assignmentId;

  /// The parameter `form` of this provider.
  String get form;
}

class _AssignmentSubmissionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AssignmentSubmissions,
        List<DataFormSubmission>> with AssignmentSubmissionsRef {
  _AssignmentSubmissionsProviderElement(super.provider);

  @override
  String get assignmentId =>
      (origin as AssignmentSubmissionsProvider).assignmentId;
  @override
  String get form => (origin as AssignmentSubmissionsProvider).form;
}

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
