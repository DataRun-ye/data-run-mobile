// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ou_picker_data_source.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ouPickerDataSourceHash() =>
    r'537edfc16f18b37b00504d48a6e315cc0b238264';

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

/// See also [ouPickerDataSource].
@ProviderFor(ouPickerDataSource)
const ouPickerDataSourceProvider = OuPickerDataSourceFamily();

/// See also [ouPickerDataSource].
class OuPickerDataSourceFamily extends Family {
  /// See also [ouPickerDataSource].
  const OuPickerDataSourceFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ouPickerDataSourceProvider';

  /// See also [ouPickerDataSource].
  OuPickerDataSourceProvider call({
    required FormMetadata formMetadata,
  }) {
    return OuPickerDataSourceProvider(
      formMetadata: formMetadata,
    );
  }

  @visibleForOverriding
  @override
  OuPickerDataSourceProvider getProviderOverride(
    covariant OuPickerDataSourceProvider provider,
  ) {
    return call(
      formMetadata: provider.formMetadata,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<TreeNodeDataSource> Function(OuPickerDataSourceRef ref) create) {
    return _$OuPickerDataSourceFamilyOverride(this, create);
  }
}

class _$OuPickerDataSourceFamilyOverride implements FamilyOverride {
  _$OuPickerDataSourceFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<TreeNodeDataSource> Function(OuPickerDataSourceRef ref) create;

  @override
  final OuPickerDataSourceFamily overriddenFamily;

  @override
  OuPickerDataSourceProvider getProviderOverride(
    covariant OuPickerDataSourceProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [ouPickerDataSource].
class OuPickerDataSourceProvider
    extends AutoDisposeFutureProvider<TreeNodeDataSource> {
  /// See also [ouPickerDataSource].
  OuPickerDataSourceProvider({
    required FormMetadata formMetadata,
  }) : this._internal(
          (ref) => ouPickerDataSource(
            ref as OuPickerDataSourceRef,
            formMetadata: formMetadata,
          ),
          from: ouPickerDataSourceProvider,
          name: r'ouPickerDataSourceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ouPickerDataSourceHash,
          dependencies: OuPickerDataSourceFamily._dependencies,
          allTransitiveDependencies:
              OuPickerDataSourceFamily._allTransitiveDependencies,
          formMetadata: formMetadata,
        );

  OuPickerDataSourceProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.formMetadata,
  }) : super.internal();

  final FormMetadata formMetadata;

  @override
  Override overrideWith(
    FutureOr<TreeNodeDataSource> Function(OuPickerDataSourceRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OuPickerDataSourceProvider._internal(
        (ref) => create(ref as OuPickerDataSourceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        formMetadata: formMetadata,
      ),
    );
  }

  @override
  ({
    FormMetadata formMetadata,
  }) get argument {
    return (formMetadata: formMetadata,);
  }

  @override
  AutoDisposeFutureProviderElement<TreeNodeDataSource> createElement() {
    return _OuPickerDataSourceProviderElement(this);
  }

  OuPickerDataSourceProvider _copyWith(
    FutureOr<TreeNodeDataSource> Function(OuPickerDataSourceRef ref) create,
  ) {
    return OuPickerDataSourceProvider._internal(
      (ref) => create(ref as OuPickerDataSourceRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      formMetadata: formMetadata,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is OuPickerDataSourceProvider &&
        other.formMetadata == formMetadata;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, formMetadata.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OuPickerDataSourceRef
    on AutoDisposeFutureProviderRef<TreeNodeDataSource> {
  /// The parameter `formMetadata` of this provider.
  FormMetadata get formMetadata;
}

class _OuPickerDataSourceProviderElement
    extends AutoDisposeFutureProviderElement<TreeNodeDataSource>
    with OuPickerDataSourceRef {
  _OuPickerDataSourceProviderElement(super.provider);

  @override
  FormMetadata get formMetadata =>
      (origin as OuPickerDataSourceProvider).formMetadata;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
