// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_instance.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$latestFormTemplateHash() =>
    r'137e3ec3bf6d0131d8247980e17bb7aabaf76b15';

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

/// See also [latestFormTemplate].
@ProviderFor(latestFormTemplate)
const latestFormTemplateProvider = LatestFormTemplateFamily();

/// See also [latestFormTemplate].
class LatestFormTemplateFamily
    extends Family<AsyncValue<FormTemplateRepository>> {
  /// See also [latestFormTemplate].
  const LatestFormTemplateFamily();

  /// See also [latestFormTemplate].
  LatestFormTemplateProvider call({
    required String formId,
  }) {
    return LatestFormTemplateProvider(
      formId: formId,
    );
  }

  @override
  LatestFormTemplateProvider getProviderOverride(
    covariant LatestFormTemplateProvider provider,
  ) {
    return call(
      formId: provider.formId,
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
  String? get name => r'latestFormTemplateProvider';
}

/// See also [latestFormTemplate].
class LatestFormTemplateProvider
    extends AutoDisposeFutureProvider<FormTemplateRepository> {
  /// See also [latestFormTemplate].
  LatestFormTemplateProvider({
    required String formId,
  }) : this._internal(
          (ref) => latestFormTemplate(
            ref as LatestFormTemplateRef,
            formId: formId,
          ),
          from: latestFormTemplateProvider,
          name: r'latestFormTemplateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$latestFormTemplateHash,
          dependencies: LatestFormTemplateFamily._dependencies,
          allTransitiveDependencies:
              LatestFormTemplateFamily._allTransitiveDependencies,
          formId: formId,
        );

  LatestFormTemplateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.formId,
  }) : super.internal();

  final String formId;

  @override
  Override overrideWith(
    FutureOr<FormTemplateRepository> Function(LatestFormTemplateRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LatestFormTemplateProvider._internal(
        (ref) => create(ref as LatestFormTemplateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        formId: formId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FormTemplateRepository> createElement() {
    return _LatestFormTemplateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LatestFormTemplateProvider && other.formId == formId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, formId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LatestFormTemplateRef
    on AutoDisposeFutureProviderRef<FormTemplateRepository> {
  /// The parameter `formId` of this provider.
  String get formId;
}

class _LatestFormTemplateProviderElement
    extends AutoDisposeFutureProviderElement<FormTemplateRepository>
    with LatestFormTemplateRef {
  _LatestFormTemplateProviderElement(super.provider);

  @override
  String get formId => (origin as LatestFormTemplateProvider).formId;
}

String _$formFlatTemplateHash() => r'c42f62aff67ed37f2bfe38e28ea11a1789826286';

/// See also [formFlatTemplate].
@ProviderFor(formFlatTemplate)
const formFlatTemplateProvider = FormFlatTemplateFamily();

/// See also [formFlatTemplate].
class FormFlatTemplateFamily
    extends Family<AsyncValue<FormTemplateRepository>> {
  /// See also [formFlatTemplate].
  const FormFlatTemplateFamily();

  /// See also [formFlatTemplate].
  FormFlatTemplateProvider call({
    required FormMetadata formMetadata,
  }) {
    return FormFlatTemplateProvider(
      formMetadata: formMetadata,
    );
  }

  @override
  FormFlatTemplateProvider getProviderOverride(
    covariant FormFlatTemplateProvider provider,
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
  String? get name => r'formFlatTemplateProvider';
}

/// See also [formFlatTemplate].
class FormFlatTemplateProvider
    extends AutoDisposeFutureProvider<FormTemplateRepository> {
  /// See also [formFlatTemplate].
  FormFlatTemplateProvider({
    required FormMetadata formMetadata,
  }) : this._internal(
          (ref) => formFlatTemplate(
            ref as FormFlatTemplateRef,
            formMetadata: formMetadata,
          ),
          from: formFlatTemplateProvider,
          name: r'formFlatTemplateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$formFlatTemplateHash,
          dependencies: FormFlatTemplateFamily._dependencies,
          allTransitiveDependencies:
              FormFlatTemplateFamily._allTransitiveDependencies,
          formMetadata: formMetadata,
        );

  FormFlatTemplateProvider._internal(
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
    FutureOr<FormTemplateRepository> Function(FormFlatTemplateRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FormFlatTemplateProvider._internal(
        (ref) => create(ref as FormFlatTemplateRef),
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
  AutoDisposeFutureProviderElement<FormTemplateRepository> createElement() {
    return _FormFlatTemplateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormFlatTemplateProvider &&
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
mixin FormFlatTemplateRef
    on AutoDisposeFutureProviderRef<FormTemplateRepository> {
  /// The parameter `formMetadata` of this provider.
  FormMetadata get formMetadata;
}

class _FormFlatTemplateProviderElement
    extends AutoDisposeFutureProviderElement<FormTemplateRepository>
    with FormFlatTemplateRef {
  _FormFlatTemplateProviderElement(super.provider);

  @override
  FormMetadata get formMetadata =>
      (origin as FormFlatTemplateProvider).formMetadata;
}

String _$formInstanceHash() => r'34986b00d0c99de02da9c5757d4ac1a330afb452';

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
