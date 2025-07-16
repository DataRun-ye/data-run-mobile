// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_count.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$submissionsSyncStateCountHash() =>
    r'099cdabf0a7fa4dd025be0fe68202dcdadea87b6';

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
class SubmissionsSyncStateCountFamily extends Family<AsyncValue<int>> {
  /// See also [submissionsSyncStateCount].
  const SubmissionsSyncStateCountFamily();

  /// See also [submissionsSyncStateCount].
  SubmissionsSyncStateCountProvider call(
    InstanceSyncStatus syncStatus,
  ) {
    return SubmissionsSyncStateCountProvider(
      syncStatus,
    );
  }

  @override
  SubmissionsSyncStateCountProvider getProviderOverride(
    covariant SubmissionsSyncStateCountProvider provider,
  ) {
    return call(
      provider.syncStatus,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    assignmentProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    assignmentProvider,
    ...?assignmentProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'submissionsSyncStateCountProvider';
}

/// See also [submissionsSyncStateCount].
class SubmissionsSyncStateCountProvider extends AutoDisposeFutureProvider<int> {
  /// See also [submissionsSyncStateCount].
  SubmissionsSyncStateCountProvider(
    InstanceSyncStatus syncStatus,
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
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.syncStatus,
  }) : super.internal();

  final InstanceSyncStatus syncStatus;

  @override
  Override overrideWith(
    FutureOr<int> Function(SubmissionsSyncStateCountRef provider) create,
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
  AutoDisposeFutureProviderElement<int> createElement() {
    return _SubmissionsSyncStateCountProviderElement(this);
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubmissionsSyncStateCountRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `syncStatus` of this provider.
  InstanceSyncStatus get syncStatus;
}

class _SubmissionsSyncStateCountProviderElement
    extends AutoDisposeFutureProviderElement<int>
    with SubmissionsSyncStateCountRef {
  _SubmissionsSyncStateCountProviderElement(super.provider);

  @override
  InstanceSyncStatus get syncStatus =>
      (origin as SubmissionsSyncStateCountProvider).syncStatus;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
