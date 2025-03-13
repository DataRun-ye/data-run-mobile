// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$treeNodeDataSourceHash() =>
    r'165974c26044e17a0759bfb8a3a4e66d9f691c33';

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

/// See also [treeNodeDataSource].
@ProviderFor(treeNodeDataSource)
const treeNodeDataSourceProvider = TreeNodeDataSourceFamily();

/// See also [treeNodeDataSource].
class TreeNodeDataSourceFamily extends Family {
  /// See also [treeNodeDataSource].
  const TreeNodeDataSourceFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'treeNodeDataSourceProvider';

  /// See also [treeNodeDataSource].
  TreeNodeDataSourceProvider call({
    required IList<String> selectableUids,
  }) {
    return TreeNodeDataSourceProvider(
      selectableUids: selectableUids,
    );
  }

  @visibleForOverriding
  @override
  TreeNodeDataSourceProvider getProviderOverride(
    covariant TreeNodeDataSourceProvider provider,
  ) {
    return call(
      selectableUids: provider.selectableUids,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<TreeNodeDataSource> Function(TreeNodeDataSourceRef ref) create) {
    return _$TreeNodeDataSourceFamilyOverride(this, create);
  }
}

class _$TreeNodeDataSourceFamilyOverride implements FamilyOverride {
  _$TreeNodeDataSourceFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<TreeNodeDataSource> Function(TreeNodeDataSourceRef ref) create;

  @override
  final TreeNodeDataSourceFamily overriddenFamily;

  @override
  TreeNodeDataSourceProvider getProviderOverride(
    covariant TreeNodeDataSourceProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [treeNodeDataSource].
class TreeNodeDataSourceProvider
    extends AutoDisposeFutureProvider<TreeNodeDataSource> {
  /// See also [treeNodeDataSource].
  TreeNodeDataSourceProvider({
    required IList<String> selectableUids,
  }) : this._internal(
          (ref) => treeNodeDataSource(
            ref as TreeNodeDataSourceRef,
            selectableUids: selectableUids,
          ),
          from: treeNodeDataSourceProvider,
          name: r'treeNodeDataSourceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$treeNodeDataSourceHash,
          dependencies: TreeNodeDataSourceFamily._dependencies,
          allTransitiveDependencies:
              TreeNodeDataSourceFamily._allTransitiveDependencies,
          selectableUids: selectableUids,
        );

  TreeNodeDataSourceProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.selectableUids,
  }) : super.internal();

  final IList<String> selectableUids;

  @override
  Override overrideWith(
    FutureOr<TreeNodeDataSource> Function(TreeNodeDataSourceRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TreeNodeDataSourceProvider._internal(
        (ref) => create(ref as TreeNodeDataSourceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        selectableUids: selectableUids,
      ),
    );
  }

  @override
  ({
    IList<String> selectableUids,
  }) get argument {
    return (selectableUids: selectableUids,);
  }

  @override
  AutoDisposeFutureProviderElement<TreeNodeDataSource> createElement() {
    return _TreeNodeDataSourceProviderElement(this);
  }

  TreeNodeDataSourceProvider _copyWith(
    FutureOr<TreeNodeDataSource> Function(TreeNodeDataSourceRef ref) create,
  ) {
    return TreeNodeDataSourceProvider._internal(
      (ref) => create(ref as TreeNodeDataSourceRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      selectableUids: selectableUids,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TreeNodeDataSourceProvider &&
        other.selectableUids == selectableUids;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, selectableUids.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TreeNodeDataSourceRef
    on AutoDisposeFutureProviderRef<TreeNodeDataSource> {
  /// The parameter `selectableUids` of this provider.
  IList<String> get selectableUids;
}

class _TreeNodeDataSourceProviderElement
    extends AutoDisposeFutureProviderElement<TreeNodeDataSource>
    with TreeNodeDataSourceRef {
  _TreeNodeDataSourceProviderElement(super.provider);

  @override
  IList<String> get selectableUids =>
      (origin as TreeNodeDataSourceProvider).selectableUids;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
