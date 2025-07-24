// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'element_properties.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$elementPropertiesStreamHash() =>
    r'86e38b90da3e60de2491702c088589651449edeb';

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

/// See also [elementPropertiesStream].
@ProviderFor(elementPropertiesStream)
const elementPropertiesStreamProvider = ElementPropertiesStreamFamily();

/// See also [elementPropertiesStream].
class ElementPropertiesStreamFamily
    extends Family<AsyncValue<FormElementState<dynamic>>> {
  /// See also [elementPropertiesStream].
  const ElementPropertiesStreamFamily();

  /// See also [elementPropertiesStream].
  ElementPropertiesStreamProvider call({
    required String path,
    required FormMetadata formMetadata,
  }) {
    return ElementPropertiesStreamProvider(
      path: path,
      formMetadata: formMetadata,
    );
  }

  @override
  ElementPropertiesStreamProvider getProviderOverride(
    covariant ElementPropertiesStreamProvider provider,
  ) {
    return call(
      path: provider.path,
      formMetadata: provider.formMetadata,
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
  String? get name => r'elementPropertiesStreamProvider';
}

/// See also [elementPropertiesStream].
class ElementPropertiesStreamProvider
    extends AutoDisposeStreamProvider<FormElementState<dynamic>> {
  /// See also [elementPropertiesStream].
  ElementPropertiesStreamProvider({
    required String path,
    required FormMetadata formMetadata,
  }) : this._internal(
          (ref) => elementPropertiesStream(
            ref as ElementPropertiesStreamRef,
            path: path,
            formMetadata: formMetadata,
          ),
          from: elementPropertiesStreamProvider,
          name: r'elementPropertiesStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$elementPropertiesStreamHash,
          dependencies: ElementPropertiesStreamFamily._dependencies,
          allTransitiveDependencies:
              ElementPropertiesStreamFamily._allTransitiveDependencies,
          path: path,
          formMetadata: formMetadata,
        );

  ElementPropertiesStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
    required this.formMetadata,
  }) : super.internal();

  final String path;
  final FormMetadata formMetadata;

  @override
  Override overrideWith(
    Stream<FormElementState<dynamic>> Function(
            ElementPropertiesStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ElementPropertiesStreamProvider._internal(
        (ref) => create(ref as ElementPropertiesStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
        formMetadata: formMetadata,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<FormElementState<dynamic>> createElement() {
    return _ElementPropertiesStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ElementPropertiesStreamProvider &&
        other.path == path &&
        other.formMetadata == formMetadata;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);
    hash = _SystemHash.combine(hash, formMetadata.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ElementPropertiesStreamRef
    on AutoDisposeStreamProviderRef<FormElementState<dynamic>> {
  /// The parameter `path` of this provider.
  String get path;

  /// The parameter `formMetadata` of this provider.
  FormMetadata get formMetadata;
}

class _ElementPropertiesStreamProviderElement
    extends AutoDisposeStreamProviderElement<FormElementState<dynamic>>
    with ElementPropertiesStreamRef {
  _ElementPropertiesStreamProviderElement(super.provider);

  @override
  String get path => (origin as ElementPropertiesStreamProvider).path;
  @override
  FormMetadata get formMetadata =>
      (origin as ElementPropertiesStreamProvider).formMetadata;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
