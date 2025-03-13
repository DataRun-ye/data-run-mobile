// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_submission_update.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$metadataSubmissionRepositoryHash() =>
    r'b0036c16a9a6f08fae03333901f2a5ff9bccc487';

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
class MetadataSubmissionRepositoryFamily extends Family {
  /// See also [metadataSubmissionRepository].
  const MetadataSubmissionRepositoryFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'metadataSubmissionRepositoryProvider';

  /// See also [metadataSubmissionRepository].
  MetadataSubmissionRepositoryProvider call(
    String? orgUnit,
  ) {
    return MetadataSubmissionRepositoryProvider(
      orgUnit,
    );
  }

  @visibleForOverriding
  @override
  MetadataSubmissionRepositoryProvider getProviderOverride(
    covariant MetadataSubmissionRepositoryProvider provider,
  ) {
    return call(
      provider.orgUnit,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<MetadataSubmission?> Function(
              MetadataSubmissionRepositoryRef ref)
          create) {
    return _$MetadataSubmissionRepositoryFamilyOverride(this, create);
  }
}

class _$MetadataSubmissionRepositoryFamilyOverride implements FamilyOverride {
  _$MetadataSubmissionRepositoryFamilyOverride(
      this.overriddenFamily, this.create);

  final FutureOr<MetadataSubmission?> Function(
      MetadataSubmissionRepositoryRef ref) create;

  @override
  final MetadataSubmissionRepositoryFamily overriddenFamily;

  @override
  MetadataSubmissionRepositoryProvider getProviderOverride(
    covariant MetadataSubmissionRepositoryProvider provider,
  ) {
    return provider._copyWith(create);
  }
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
    super.create, {
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
    FutureOr<MetadataSubmission?> Function(MetadataSubmissionRepositoryRef ref)
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
  (String?,) get argument {
    return (orgUnit,);
  }

  @override
  AutoDisposeFutureProviderElement<MetadataSubmission?> createElement() {
    return _MetadataSubmissionRepositoryProviderElement(this);
  }

  MetadataSubmissionRepositoryProvider _copyWith(
    FutureOr<MetadataSubmission?> Function(MetadataSubmissionRepositoryRef ref)
        create,
  ) {
    return MetadataSubmissionRepositoryProvider._internal(
      (ref) => create(ref as MetadataSubmissionRepositoryRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      orgUnit: orgUnit,
    );
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
    r'a64633e0574084628a3a815e2b507a7c4bb7f9a7';

/// See also [systemMetadataSubmissions].
@ProviderFor(systemMetadataSubmissions)
const systemMetadataSubmissionsProvider = SystemMetadataSubmissionsFamily();

/// See also [systemMetadataSubmissions].
class SystemMetadataSubmissionsFamily extends Family {
  /// See also [systemMetadataSubmissions].
  const SystemMetadataSubmissionsFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'systemMetadataSubmissionsProvider';

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

  @visibleForOverriding
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

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<MetadataSubmissionUpdate>> Function(
              SystemMetadataSubmissionsRef ref)
          create) {
    return _$SystemMetadataSubmissionsFamilyOverride(this, create);
  }
}

class _$SystemMetadataSubmissionsFamilyOverride implements FamilyOverride {
  _$SystemMetadataSubmissionsFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<MetadataSubmissionUpdate>> Function(
      SystemMetadataSubmissionsRef ref) create;

  @override
  final SystemMetadataSubmissionsFamily overriddenFamily;

  @override
  SystemMetadataSubmissionsProvider getProviderOverride(
    covariant SystemMetadataSubmissionsProvider provider,
  ) {
    return provider._copyWith(create);
  }
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
    super.create, {
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
            SystemMetadataSubmissionsRef ref)
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
  ({
    String query,
    String? orgUnit,
    String submissionId,
  }) get argument {
    return (
      query: query,
      orgUnit: orgUnit,
      submissionId: submissionId,
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<MetadataSubmissionUpdate>>
      createElement() {
    return _SystemMetadataSubmissionsProviderElement(this);
  }

  SystemMetadataSubmissionsProvider _copyWith(
    FutureOr<List<MetadataSubmissionUpdate>> Function(
            SystemMetadataSubmissionsRef ref)
        create,
  ) {
    return SystemMetadataSubmissionsProvider._internal(
      (ref) => create(ref as SystemMetadataSubmissionsRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      query: query,
      orgUnit: orgUnit,
      submissionId: submissionId,
    );
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

String _$metadataSubmissionUpdateFilterHash() =>
    r'1cb7f58cd42664db8e72655352eeff31d2720e65';

/// See also [metadataSubmissionUpdateFilter].
@ProviderFor(metadataSubmissionUpdateFilter)
const metadataSubmissionUpdateFilterProvider =
    MetadataSubmissionUpdateFilterFamily();

/// See also [metadataSubmissionUpdateFilter].
class MetadataSubmissionUpdateFilterFamily extends Family {
  /// See also [metadataSubmissionUpdateFilter].
  const MetadataSubmissionUpdateFilterFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'metadataSubmissionUpdateFilterProvider';

  /// See also [metadataSubmissionUpdateFilter].
  MetadataSubmissionUpdateFilterProvider call(
    String query,
    String orgUnit,
  ) {
    return MetadataSubmissionUpdateFilterProvider(
      query,
      orgUnit,
    );
  }

  @visibleForOverriding
  @override
  MetadataSubmissionUpdateFilterProvider getProviderOverride(
    covariant MetadataSubmissionUpdateFilterProvider provider,
  ) {
    return call(
      provider.query,
      provider.orgUnit,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<MetadataSubmissionUpdate>> Function(
              MetadataSubmissionUpdateFilterRef ref)
          create) {
    return _$MetadataSubmissionUpdateFilterFamilyOverride(this, create);
  }
}

class _$MetadataSubmissionUpdateFilterFamilyOverride implements FamilyOverride {
  _$MetadataSubmissionUpdateFilterFamilyOverride(
      this.overriddenFamily, this.create);

  final FutureOr<List<MetadataSubmissionUpdate>> Function(
      MetadataSubmissionUpdateFilterRef ref) create;

  @override
  final MetadataSubmissionUpdateFilterFamily overriddenFamily;

  @override
  MetadataSubmissionUpdateFilterProvider getProviderOverride(
    covariant MetadataSubmissionUpdateFilterProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [metadataSubmissionUpdateFilter].
class MetadataSubmissionUpdateFilterProvider
    extends AutoDisposeFutureProvider<List<MetadataSubmissionUpdate>> {
  /// See also [metadataSubmissionUpdateFilter].
  MetadataSubmissionUpdateFilterProvider(
    String query,
    String orgUnit,
  ) : this._internal(
          (ref) => metadataSubmissionUpdateFilter(
            ref as MetadataSubmissionUpdateFilterRef,
            query,
            orgUnit,
          ),
          from: metadataSubmissionUpdateFilterProvider,
          name: r'metadataSubmissionUpdateFilterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$metadataSubmissionUpdateFilterHash,
          dependencies: MetadataSubmissionUpdateFilterFamily._dependencies,
          allTransitiveDependencies:
              MetadataSubmissionUpdateFilterFamily._allTransitiveDependencies,
          query: query,
          orgUnit: orgUnit,
        );

  MetadataSubmissionUpdateFilterProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.orgUnit,
  }) : super.internal();

  final String query;
  final String orgUnit;

  @override
  Override overrideWith(
    FutureOr<List<MetadataSubmissionUpdate>> Function(
            MetadataSubmissionUpdateFilterRef ref)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MetadataSubmissionUpdateFilterProvider._internal(
        (ref) => create(ref as MetadataSubmissionUpdateFilterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        orgUnit: orgUnit,
      ),
    );
  }

  @override
  (
    String,
    String,
  ) get argument {
    return (
      query,
      orgUnit,
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<MetadataSubmissionUpdate>>
      createElement() {
    return _MetadataSubmissionUpdateFilterProviderElement(this);
  }

  MetadataSubmissionUpdateFilterProvider _copyWith(
    FutureOr<List<MetadataSubmissionUpdate>> Function(
            MetadataSubmissionUpdateFilterRef ref)
        create,
  ) {
    return MetadataSubmissionUpdateFilterProvider._internal(
      (ref) => create(ref as MetadataSubmissionUpdateFilterRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      query: query,
      orgUnit: orgUnit,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MetadataSubmissionUpdateFilterProvider &&
        other.query == query &&
        other.orgUnit == orgUnit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, orgUnit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MetadataSubmissionUpdateFilterRef
    on AutoDisposeFutureProviderRef<List<MetadataSubmissionUpdate>> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `orgUnit` of this provider.
  String get orgUnit;
}

class _MetadataSubmissionUpdateFilterProviderElement
    extends AutoDisposeFutureProviderElement<List<MetadataSubmissionUpdate>>
    with MetadataSubmissionUpdateFilterRef {
  _MetadataSubmissionUpdateFilterProviderElement(super.provider);

  @override
  String get query => (origin as MetadataSubmissionUpdateFilterProvider).query;
  @override
  String get orgUnit =>
      (origin as MetadataSubmissionUpdateFilterProvider).orgUnit;
}

String _$metadataSubmissionUpdatesHash() =>
    r'4581564036daff707ed42f1c9342f33afb1f4a5a';

abstract class _$MetadataSubmissionUpdates
    extends BuildlessAutoDisposeAsyncNotifier<List<MetadataSubmissionUpdate>> {
  late final String submissionId;

  FutureOr<List<MetadataSubmissionUpdate>> build(
    String submissionId,
  );
}

/// See also [MetadataSubmissionUpdates].
@ProviderFor(MetadataSubmissionUpdates)
const metadataSubmissionUpdatesProvider = MetadataSubmissionUpdatesFamily();

/// See also [MetadataSubmissionUpdates].
class MetadataSubmissionUpdatesFamily extends Family {
  /// See also [MetadataSubmissionUpdates].
  const MetadataSubmissionUpdatesFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'metadataSubmissionUpdatesProvider';

  /// See also [MetadataSubmissionUpdates].
  MetadataSubmissionUpdatesProvider call(
    String submissionId,
  ) {
    return MetadataSubmissionUpdatesProvider(
      submissionId,
    );
  }

  @visibleForOverriding
  @override
  MetadataSubmissionUpdatesProvider getProviderOverride(
    covariant MetadataSubmissionUpdatesProvider provider,
  ) {
    return call(
      provider.submissionId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(MetadataSubmissionUpdates Function() create) {
    return _$MetadataSubmissionUpdatesFamilyOverride(this, create);
  }
}

class _$MetadataSubmissionUpdatesFamilyOverride implements FamilyOverride {
  _$MetadataSubmissionUpdatesFamilyOverride(this.overriddenFamily, this.create);

  final MetadataSubmissionUpdates Function() create;

  @override
  final MetadataSubmissionUpdatesFamily overriddenFamily;

  @override
  MetadataSubmissionUpdatesProvider getProviderOverride(
    covariant MetadataSubmissionUpdatesProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [MetadataSubmissionUpdates].
class MetadataSubmissionUpdatesProvider
    extends AutoDisposeAsyncNotifierProviderImpl<MetadataSubmissionUpdates,
        List<MetadataSubmissionUpdate>> {
  /// See also [MetadataSubmissionUpdates].
  MetadataSubmissionUpdatesProvider(
    String submissionId,
  ) : this._internal(
          () => MetadataSubmissionUpdates()..submissionId = submissionId,
          from: metadataSubmissionUpdatesProvider,
          name: r'metadataSubmissionUpdatesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$metadataSubmissionUpdatesHash,
          dependencies: MetadataSubmissionUpdatesFamily._dependencies,
          allTransitiveDependencies:
              MetadataSubmissionUpdatesFamily._allTransitiveDependencies,
          submissionId: submissionId,
        );

  MetadataSubmissionUpdatesProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.submissionId,
  }) : super.internal();

  final String submissionId;

  @override
  FutureOr<List<MetadataSubmissionUpdate>> runNotifierBuild(
    covariant MetadataSubmissionUpdates notifier,
  ) {
    return notifier.build(
      submissionId,
    );
  }

  @override
  Override overrideWith(MetadataSubmissionUpdates Function() create) {
    return ProviderOverride(
      origin: this,
      override: MetadataSubmissionUpdatesProvider._internal(
        () => create()..submissionId = submissionId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        submissionId: submissionId,
      ),
    );
  }

  @override
  (String,) get argument {
    return (submissionId,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MetadataSubmissionUpdates,
      List<MetadataSubmissionUpdate>> createElement() {
    return _MetadataSubmissionUpdatesProviderElement(this);
  }

  MetadataSubmissionUpdatesProvider _copyWith(
    MetadataSubmissionUpdates Function() create,
  ) {
    return MetadataSubmissionUpdatesProvider._internal(
      () => create()..submissionId = submissionId,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      submissionId: submissionId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MetadataSubmissionUpdatesProvider &&
        other.submissionId == submissionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, submissionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MetadataSubmissionUpdatesRef
    on AutoDisposeAsyncNotifierProviderRef<List<MetadataSubmissionUpdate>> {
  /// The parameter `submissionId` of this provider.
  String get submissionId;
}

class _MetadataSubmissionUpdatesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MetadataSubmissionUpdates,
        List<MetadataSubmissionUpdate>> with MetadataSubmissionUpdatesRef {
  _MetadataSubmissionUpdatesProviderElement(super.provider);

  @override
  String get submissionId =>
      (origin as MetadataSubmissionUpdatesProvider).submissionId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
