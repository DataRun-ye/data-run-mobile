// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$submissionsSyncStateCountHash() =>
    r'f265105cb8efb71de18fd7ceee43a27d93a830bd';

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

/// See also [submissionsSyncStateCount].
@ProviderFor(submissionsSyncStateCount)
const submissionsSyncStateCountProvider = SubmissionsSyncStateCountFamily();

/// See also [submissionsSyncStateCount].
class SubmissionsSyncStateCountFamily extends Family {
  /// See also [submissionsSyncStateCount].
  const SubmissionsSyncStateCountFamily();

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    assignmentProvider
  ];

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    assignmentProvider,
    ...?assignmentProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'submissionsSyncStateCountProvider';

  /// See also [submissionsSyncStateCount].
  SubmissionsSyncStateCountProvider call(
    SyncStatus syncStatus,
  ) {
    return SubmissionsSyncStateCountProvider(
      syncStatus,
    );
  }

  @visibleForOverriding
  @override
  SubmissionsSyncStateCountProvider getProviderOverride(
    covariant SubmissionsSyncStateCountProvider provider,
  ) {
    return call(
      provider.syncStatus,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<int> Function(SubmissionsSyncStateCountRef ref) create) {
    return _$SubmissionsSyncStateCountFamilyOverride(this, create);
  }
}

class _$SubmissionsSyncStateCountFamilyOverride implements FamilyOverride {
  _$SubmissionsSyncStateCountFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<int> Function(SubmissionsSyncStateCountRef ref) create;

  @override
  final SubmissionsSyncStateCountFamily overriddenFamily;

  @override
  SubmissionsSyncStateCountProvider getProviderOverride(
    covariant SubmissionsSyncStateCountProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [submissionsSyncStateCount].
class SubmissionsSyncStateCountProvider extends AutoDisposeFutureProvider<int> {
  /// See also [submissionsSyncStateCount].
  SubmissionsSyncStateCountProvider(
    SyncStatus syncStatus,
  ) : this._internal(
          (ref) => submissionsSyncStateCount(
            ref as SubmissionsSyncStateCountRef,
            syncStatus,
          ),
          from: submissionsSyncStateCountProvider,
          name: r'submissionsSyncStateCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$submissionsSyncStateCountHash,
          dependencies: SubmissionsSyncStateCountFamily._dependencies,
          allTransitiveDependencies:
              SubmissionsSyncStateCountFamily._allTransitiveDependencies,
          syncStatus: syncStatus,
        );

  SubmissionsSyncStateCountProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.syncStatus,
  }) : super.internal();

  final SyncStatus syncStatus;

  @override
  Override overrideWith(
    FutureOr<int> Function(SubmissionsSyncStateCountRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubmissionsSyncStateCountProvider._internal(
        (ref) => create(ref as SubmissionsSyncStateCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        syncStatus: syncStatus,
      ),
    );
  }

  @override
  (SyncStatus,) get argument {
    return (syncStatus,);
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _SubmissionsSyncStateCountProviderElement(this);
  }

  SubmissionsSyncStateCountProvider _copyWith(
    FutureOr<int> Function(SubmissionsSyncStateCountRef ref) create,
  ) {
    return SubmissionsSyncStateCountProvider._internal(
      (ref) => create(ref as SubmissionsSyncStateCountRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      syncStatus: syncStatus,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SubmissionsSyncStateCountProvider &&
        other.syncStatus == syncStatus;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, syncStatus.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SubmissionsSyncStateCountRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `syncStatus` of this provider.
  SyncStatus get syncStatus;
}

class _SubmissionsSyncStateCountProviderElement
    extends AutoDisposeFutureProviderElement<int>
    with SubmissionsSyncStateCountRef {
  _SubmissionsSyncStateCountProviderElement(super.provider);

  @override
  SyncStatus get syncStatus =>
      (origin as SubmissionsSyncStateCountProvider).syncStatus;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
