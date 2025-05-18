// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
String _$assignmentSubmissionsHash() =>
    r'8e612fea6b8f34f048c09075c2b1d6bfb4977c36';

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
