// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_submission_update.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$metadataSubmissionRepositoryHash() =>
    r'908b5a21a1853daf2920c86cb926707dd093442e';

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

/// See also [metadataSubmissionRepository].
@ProviderFor(metadataSubmissionRepository)
const metadataSubmissionRepositoryProvider =
    MetadataSubmissionRepositoryFamily();

/// See also [metadataSubmissionRepository].
class MetadataSubmissionRepositoryFamily
    extends Family<AsyncValue<MetadataSubmission?>> {
  /// See also [metadataSubmissionRepository].
  const MetadataSubmissionRepositoryFamily();

  /// See also [metadataSubmissionRepository].
  MetadataSubmissionRepositoryProvider call(
    String? orgUnit,
  ) {
    return MetadataSubmissionRepositoryProvider(
      orgUnit,
    );
  }

  @override
  MetadataSubmissionRepositoryProvider getProviderOverride(
    covariant MetadataSubmissionRepositoryProvider provider,
  ) {
    return call(
      provider.orgUnit,
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
  String? get name => r'metadataSubmissionRepositoryProvider';
}

/// See also [metadataSubmissionRepository].
class MetadataSubmissionRepositoryProvider
    extends AutoDisposeFutureProvider<MetadataSubmission?> {
  /// See also [metadataSubmissionRepository].
  MetadataSubmissionRepositoryProvider(
    String? orgUnit,
  ) : this._internal(
          (ref) => metadataSubmissionRepository(
            ref as MetadataSubmissionRepositoryRef,
            orgUnit,
          ),
          from: metadataSubmissionRepositoryProvider,
          name: r'metadataSubmissionRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$metadataSubmissionRepositoryHash,
          dependencies: MetadataSubmissionRepositoryFamily._dependencies,
          allTransitiveDependencies:
              MetadataSubmissionRepositoryFamily._allTransitiveDependencies,
          orgUnit: orgUnit,
        );

  MetadataSubmissionRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orgUnit,
  }) : super.internal();

  final String? orgUnit;

  @override
  Override overrideWith(
    FutureOr<MetadataSubmission?> Function(
            MetadataSubmissionRepositoryRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MetadataSubmissionRepositoryProvider._internal(
        (ref) => create(ref as MetadataSubmissionRepositoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orgUnit: orgUnit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<MetadataSubmission?> createElement() {
    return _MetadataSubmissionRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MetadataSubmissionRepositoryProvider &&
        other.orgUnit == orgUnit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orgUnit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MetadataSubmissionRepositoryRef
    on AutoDisposeFutureProviderRef<MetadataSubmission?> {
  /// The parameter `orgUnit` of this provider.
  String? get orgUnit;
}

class _MetadataSubmissionRepositoryProviderElement
    extends AutoDisposeFutureProviderElement<MetadataSubmission?>
    with MetadataSubmissionRepositoryRef {
  _MetadataSubmissionRepositoryProviderElement(super.provider);

  @override
  String? get orgUnit =>
      (origin as MetadataSubmissionRepositoryProvider).orgUnit;
}

String _$systemMetadataSubmissionsHash() =>
    r'bfcc3ef9e485c374394cb66f4f760aba5c2c1d9c';

/// See also [systemMetadataSubmissions].
@ProviderFor(systemMetadataSubmissions)
const systemMetadataSubmissionsProvider = SystemMetadataSubmissionsFamily();

/// See also [systemMetadataSubmissions].
class SystemMetadataSubmissionsFamily
    extends Family<AsyncValue<List<MetadataSubmissionUpdate>>> {
  /// See also [systemMetadataSubmissions].
  const SystemMetadataSubmissionsFamily();

  /// See also [systemMetadataSubmissions].
  SystemMetadataSubmissionsProvider call({
    required String query,
    String? orgUnit,
    required String submissionId,
  }) {
    return SystemMetadataSubmissionsProvider(
      query: query,
      orgUnit: orgUnit,
      submissionId: submissionId,
    );
  }

  @override
  SystemMetadataSubmissionsProvider getProviderOverride(
    covariant SystemMetadataSubmissionsProvider provider,
  ) {
    return call(
      query: provider.query,
      orgUnit: provider.orgUnit,
      submissionId: provider.submissionId,
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
  String? get name => r'systemMetadataSubmissionsProvider';
}

/// See also [systemMetadataSubmissions].
class SystemMetadataSubmissionsProvider
    extends AutoDisposeFutureProvider<List<MetadataSubmissionUpdate>> {
  /// See also [systemMetadataSubmissions].
  SystemMetadataSubmissionsProvider({
    required String query,
    String? orgUnit,
    required String submissionId,
  }) : this._internal(
          (ref) => systemMetadataSubmissions(
            ref as SystemMetadataSubmissionsRef,
            query: query,
            orgUnit: orgUnit,
            submissionId: submissionId,
          ),
          from: systemMetadataSubmissionsProvider,
          name: r'systemMetadataSubmissionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$systemMetadataSubmissionsHash,
          dependencies: SystemMetadataSubmissionsFamily._dependencies,
          allTransitiveDependencies:
              SystemMetadataSubmissionsFamily._allTransitiveDependencies,
          query: query,
          orgUnit: orgUnit,
          submissionId: submissionId,
        );

  SystemMetadataSubmissionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.orgUnit,
    required this.submissionId,
  }) : super.internal();

  final String query;
  final String? orgUnit;
  final String submissionId;

  @override
  Override overrideWith(
    FutureOr<List<MetadataSubmissionUpdate>> Function(
            SystemMetadataSubmissionsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SystemMetadataSubmissionsProvider._internal(
        (ref) => create(ref as SystemMetadataSubmissionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        orgUnit: orgUnit,
        submissionId: submissionId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<MetadataSubmissionUpdate>>
      createElement() {
    return _SystemMetadataSubmissionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SystemMetadataSubmissionsProvider &&
        other.query == query &&
        other.orgUnit == orgUnit &&
        other.submissionId == submissionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, orgUnit.hashCode);
    hash = _SystemHash.combine(hash, submissionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SystemMetadataSubmissionsRef
    on AutoDisposeFutureProviderRef<List<MetadataSubmissionUpdate>> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `orgUnit` of this provider.
  String? get orgUnit;

  /// The parameter `submissionId` of this provider.
  String get submissionId;
}

class _SystemMetadataSubmissionsProviderElement
    extends AutoDisposeFutureProviderElement<List<MetadataSubmissionUpdate>>
    with SystemMetadataSubmissionsRef {
  _SystemMetadataSubmissionsProviderElement(super.provider);

  @override
  String get query => (origin as SystemMetadataSubmissionsProvider).query;
  @override
  String? get orgUnit => (origin as SystemMetadataSubmissionsProvider).orgUnit;
  @override
  String get submissionId =>
      (origin as SystemMetadataSubmissionsProvider).submissionId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
