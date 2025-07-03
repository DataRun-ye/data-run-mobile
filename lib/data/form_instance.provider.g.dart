// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_instance.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userDeviceInfoServiceHash() =>
    r'b757adc31c86b929a08d7e5d9f26110f8c5626ed';

/// See also [userDeviceInfoService].
@ProviderFor(userDeviceInfoService)
final userDeviceInfoServiceProvider =
    AutoDisposeFutureProvider<AndroidDeviceInfoService>.internal(
  userDeviceInfoService,
  name: r'userDeviceInfoServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userDeviceInfoServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserDeviceInfoServiceRef
    = AutoDisposeFutureProviderRef<AndroidDeviceInfoService>;
String _$formInstanceServiceHash() =>
    r'ba1f23f32f2cd9556f84cfd8bcd88c4f605a10d1';

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

/// See also [formInstanceService].
@ProviderFor(formInstanceService)
const formInstanceServiceProvider = FormInstanceServiceFamily();

/// See also [formInstanceService].
class FormInstanceServiceFamily
    extends Family<AsyncValue<FormInstanceService>> {
  /// See also [formInstanceService].
  const FormInstanceServiceFamily();

  /// See also [formInstanceService].
  FormInstanceServiceProvider call({
    required FormMetadata formMetadata,
  }) {
    return FormInstanceServiceProvider(
      formMetadata: formMetadata,
    );
  }

  @override
  FormInstanceServiceProvider getProviderOverride(
    covariant FormInstanceServiceProvider provider,
  ) {
    return call(
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
  String? get name => r'formInstanceServiceProvider';
}

/// See also [formInstanceService].
class FormInstanceServiceProvider
    extends AutoDisposeFutureProvider<FormInstanceService> {
  /// See also [formInstanceService].
  FormInstanceServiceProvider({
    required FormMetadata formMetadata,
  }) : this._internal(
          (ref) => formInstanceService(
            ref as FormInstanceServiceRef,
            formMetadata: formMetadata,
          ),
          from: formInstanceServiceProvider,
          name: r'formInstanceServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$formInstanceServiceHash,
          dependencies: FormInstanceServiceFamily._dependencies,
          allTransitiveDependencies:
              FormInstanceServiceFamily._allTransitiveDependencies,
          formMetadata: formMetadata,
        );

  FormInstanceServiceProvider._internal(
    super._createNotifier, {
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
    FutureOr<FormInstanceService> Function(FormInstanceServiceRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FormInstanceServiceProvider._internal(
        (ref) => create(ref as FormInstanceServiceRef),
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
  AutoDisposeFutureProviderElement<FormInstanceService> createElement() {
    return _FormInstanceServiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormInstanceServiceProvider &&
        other.formMetadata == formMetadata;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, formMetadata.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FormInstanceServiceRef
    on AutoDisposeFutureProviderRef<FormInstanceService> {
  /// The parameter `formMetadata` of this provider.
  FormMetadata get formMetadata;
}

class _FormInstanceServiceProviderElement
    extends AutoDisposeFutureProviderElement<FormInstanceService>
    with FormInstanceServiceRef {
  _FormInstanceServiceProviderElement(super.provider);

  @override
  FormMetadata get formMetadata =>
      (origin as FormInstanceServiceProvider).formMetadata;
}

String _$formInstanceHash() => r'a8741a34be31406f97d18426463ac6675c593359';

/// See also [formInstance].
@ProviderFor(formInstance)
const formInstanceProvider = FormInstanceFamily();

/// See also [formInstance].
class FormInstanceFamily extends Family<AsyncValue<FormInstance>> {
  /// See also [formInstance].
  const FormInstanceFamily();

  /// See also [formInstance].
  FormInstanceProvider call({
    required FormMetadata formMetadata,
  }) {
    return FormInstanceProvider(
      formMetadata: formMetadata,
    );
  }

  @override
  FormInstanceProvider getProviderOverride(
    covariant FormInstanceProvider provider,
  ) {
    return call(
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
  String? get name => r'formInstanceProvider';
}

/// See also [formInstance].
class FormInstanceProvider extends AutoDisposeFutureProvider<FormInstance> {
  /// See also [formInstance].
  FormInstanceProvider({
    required FormMetadata formMetadata,
  }) : this._internal(
          (ref) => formInstance(
            ref as FormInstanceRef,
            formMetadata: formMetadata,
          ),
          from: formInstanceProvider,
          name: r'formInstanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$formInstanceHash,
          dependencies: FormInstanceFamily._dependencies,
          allTransitiveDependencies:
              FormInstanceFamily._allTransitiveDependencies,
          formMetadata: formMetadata,
        );

  FormInstanceProvider._internal(
    super._createNotifier, {
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
    FutureOr<FormInstance> Function(FormInstanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FormInstanceProvider._internal(
        (ref) => create(ref as FormInstanceRef),
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
  AutoDisposeFutureProviderElement<FormInstance> createElement() {
    return _FormInstanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormInstanceProvider && other.formMetadata == formMetadata;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, formMetadata.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FormInstanceRef on AutoDisposeFutureProviderRef<FormInstance> {
  /// The parameter `formMetadata` of this provider.
  FormMetadata get formMetadata;
}

class _FormInstanceProviderElement
    extends AutoDisposeFutureProviderElement<FormInstance>
    with FormInstanceRef {
  _FormInstanceProviderElement(super.provider);

  @override
  FormMetadata get formMetadata =>
      (origin as FormInstanceProvider).formMetadata;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
