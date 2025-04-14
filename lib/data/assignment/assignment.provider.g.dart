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
class FilterAssignmentsFamily
    extends Family<AsyncValue<List<AssignmentModel>>> {
  /// filters the list of assignment by certain
  ///
  /// Copied from [filterAssignments].
  const FilterAssignmentsFamily();

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

  @override
  FilterAssignmentsProvider getProviderOverride(
    covariant FilterAssignmentsProvider provider,
  ) {
    return call(
      provider.scope,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    activityModelProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    activityModelProvider,
    ...?activityModelProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filterAssignmentsProvider';
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
    super._createNotifier, {
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
    FutureOr<List<AssignmentModel>> Function(FilterAssignmentsRef provider)
        create,
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
  AutoDisposeFutureProviderElement<List<AssignmentModel>> createElement() {
    return _FilterAssignmentsProviderElement(this);
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
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
    r'd6f59cc35d9338bf0e4fe7b64eca0cb531215942';

abstract class _$AssignmentSubmissions
    extends BuildlessAutoDisposeAsyncNotifier<List<DataSubmission>> {
  late final String assignmentId;
  late final String form;

  FutureOr<List<DataSubmission>> build(
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
class AssignmentSubmissionsFamily
    extends Family<AsyncValue<List<DataSubmission>>> {
  /// retrieve a certain assignment forms submissions
  ///
  /// Copied from [AssignmentSubmissions].
  const AssignmentSubmissionsFamily();

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

  @override
  AssignmentSubmissionsProvider getProviderOverride(
    covariant AssignmentSubmissionsProvider provider,
  ) {
    return call(
      provider.assignmentId,
      form: provider.form,
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
  String? get name => r'assignmentSubmissionsProvider';
}

/// retrieve a certain assignment forms submissions
///
/// Copied from [AssignmentSubmissions].
class AssignmentSubmissionsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AssignmentSubmissions,
        List<DataSubmission>> {
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
    super._createNotifier, {
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
  FutureOr<List<DataSubmission>> runNotifierBuild(
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
  AutoDisposeAsyncNotifierProviderElement<AssignmentSubmissions,
      List<DataSubmission>> createElement() {
    return _AssignmentSubmissionsProviderElement(this);
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AssignmentSubmissionsRef
    on AutoDisposeAsyncNotifierProviderRef<List<DataSubmission>> {
  /// The parameter `assignmentId` of this provider.
  String get assignmentId;

  /// The parameter `form` of this provider.
  String get form;
}

class _AssignmentSubmissionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AssignmentSubmissions,
        List<DataSubmission>> with AssignmentSubmissionsRef {
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
