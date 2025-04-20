// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_instance.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userDeviceInfoServiceHash() =>
    r'4c4514d10d6f67ae6341ded57c5fcd4eaeafcd65';

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

typedef UserDeviceInfoServiceRef
    = AutoDisposeFutureProviderRef<AndroidDeviceInfoService>;
String _$latestFormTemplateHash() =>
    r'e1b57af01c315f5be442adfe0a3ec4a3d3ce75c3';

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
class LatestFormTemplateFamily extends Family {
  /// See also [latestFormTemplate].
  const LatestFormTemplateFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'latestFormTemplateProvider';

  /// See also [latestFormTemplate].
  LatestFormTemplateProvider call({
    required String formId,
  }) {
    return LatestFormTemplateProvider(
      formId: formId,
    );
  }

  @visibleForOverriding
  @override
  LatestFormTemplateProvider getProviderOverride(
    covariant LatestFormTemplateProvider provider,
  ) {
    return call(
      formId: provider.formId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<FormVersion> Function(LatestFormTemplateRef ref) create) {
    return _$LatestFormTemplateFamilyOverride(this, create);
  }
}

class _$LatestFormTemplateFamilyOverride implements FamilyOverride {
  _$LatestFormTemplateFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<FormVersion> Function(LatestFormTemplateRef ref) create;

  @override
  final LatestFormTemplateFamily overriddenFamily;

  @override
  LatestFormTemplateProvider getProviderOverride(
    covariant LatestFormTemplateProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [latestFormTemplate].
class LatestFormTemplateProvider
    extends AutoDisposeFutureProvider<FormVersion> {
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
    super.create, {
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
    FutureOr<FormVersion> Function(LatestFormTemplateRef ref) create,
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
  ({
    String formId,
  }) get argument {
    return (formId: formId,);
  }

  @override
  AutoDisposeFutureProviderElement<FormVersion> createElement() {
    return _LatestFormTemplateProviderElement(this);
  }

  LatestFormTemplateProvider _copyWith(
    FutureOr<FormVersion> Function(LatestFormTemplateRef ref) create,
  ) {
    return LatestFormTemplateProvider._internal(
      (ref) => create(ref as LatestFormTemplateRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      formId: formId,
    );
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

mixin LatestFormTemplateRef on AutoDisposeFutureProviderRef<FormVersion> {
  /// The parameter `formId` of this provider.
  String get formId;
}

class _LatestFormTemplateProviderElement
    extends AutoDisposeFutureProviderElement<FormVersion>
    with LatestFormTemplateRef {
  _LatestFormTemplateProviderElement(super.provider);

  @override
  String get formId => (origin as LatestFormTemplateProvider).formId;
}

String _$submissionVersionFormTemplateHash() =>
    r'981836f944173420cb750f1d1f2d4723d0b4ed2f';

/// form id could be on the format of formId-version or formId
/// look for the latest version of the form template or the form template
/// that matches the version
///
/// Copied from [submissionVersionFormTemplate].
@ProviderFor(submissionVersionFormTemplate)
const submissionVersionFormTemplateProvider =
    SubmissionVersionFormTemplateFamily();

/// form id could be on the format of formId-version or formId
/// look for the latest version of the form template or the form template
/// that matches the version
///
/// Copied from [submissionVersionFormTemplate].
class SubmissionVersionFormTemplateFamily extends Family {
  /// form id could be on the format of formId-version or formId
  /// look for the latest version of the form template or the form template
  /// that matches the version
  ///
  /// Copied from [submissionVersionFormTemplate].
  const SubmissionVersionFormTemplateFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'submissionVersionFormTemplateProvider';

  /// form id could be on the format of formId-version or formId
  /// look for the latest version of the form template or the form template
  /// that matches the version
  ///
  /// Copied from [submissionVersionFormTemplate].
  SubmissionVersionFormTemplateProvider call({
    required String formId,
  }) {
    return SubmissionVersionFormTemplateProvider(
      formId: formId,
    );
  }

  @visibleForOverriding
  @override
  SubmissionVersionFormTemplateProvider getProviderOverride(
    covariant SubmissionVersionFormTemplateProvider provider,
  ) {
    return call(
      formId: provider.formId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<FormVersion> Function(SubmissionVersionFormTemplateRef ref)
          create) {
    return _$SubmissionVersionFormTemplateFamilyOverride(this, create);
  }
}

class _$SubmissionVersionFormTemplateFamilyOverride implements FamilyOverride {
  _$SubmissionVersionFormTemplateFamilyOverride(
      this.overriddenFamily, this.create);

  final FutureOr<FormVersion> Function(SubmissionVersionFormTemplateRef ref)
      create;

  @override
  final SubmissionVersionFormTemplateFamily overriddenFamily;

  @override
  SubmissionVersionFormTemplateProvider getProviderOverride(
    covariant SubmissionVersionFormTemplateProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// form id could be on the format of formId-version or formId
/// look for the latest version of the form template or the form template
/// that matches the version
///
/// Copied from [submissionVersionFormTemplate].
class SubmissionVersionFormTemplateProvider
    extends AutoDisposeFutureProvider<FormVersion> {
  /// form id could be on the format of formId-version or formId
  /// look for the latest version of the form template or the form template
  /// that matches the version
  ///
  /// Copied from [submissionVersionFormTemplate].
  SubmissionVersionFormTemplateProvider({
    required String formId,
  }) : this._internal(
          (ref) => submissionVersionFormTemplate(
            ref as SubmissionVersionFormTemplateRef,
            formId: formId,
          ),
          from: submissionVersionFormTemplateProvider,
          name: r'submissionVersionFormTemplateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$submissionVersionFormTemplateHash,
          dependencies: SubmissionVersionFormTemplateFamily._dependencies,
          allTransitiveDependencies:
              SubmissionVersionFormTemplateFamily._allTransitiveDependencies,
          formId: formId,
        );

  SubmissionVersionFormTemplateProvider._internal(
    super.create, {
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
    FutureOr<FormVersion> Function(SubmissionVersionFormTemplateRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubmissionVersionFormTemplateProvider._internal(
        (ref) => create(ref as SubmissionVersionFormTemplateRef),
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
  ({
    String formId,
  }) get argument {
    return (formId: formId,);
  }

  @override
  AutoDisposeFutureProviderElement<FormVersion> createElement() {
    return _SubmissionVersionFormTemplateProviderElement(this);
  }

  SubmissionVersionFormTemplateProvider _copyWith(
    FutureOr<FormVersion> Function(SubmissionVersionFormTemplateRef ref) create,
  ) {
    return SubmissionVersionFormTemplateProvider._internal(
      (ref) => create(ref as SubmissionVersionFormTemplateRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      formId: formId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SubmissionVersionFormTemplateProvider &&
        other.formId == formId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, formId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SubmissionVersionFormTemplateRef
    on AutoDisposeFutureProviderRef<FormVersion> {
  /// The parameter `formId` of this provider.
  String get formId;
}

class _SubmissionVersionFormTemplateProviderElement
    extends AutoDisposeFutureProviderElement<FormVersion>
    with SubmissionVersionFormTemplateRef {
  _SubmissionVersionFormTemplateProviderElement(super.provider);

  @override
  String get formId => (origin as SubmissionVersionFormTemplateProvider).formId;
}

String _$formFlatTemplateHash() => r'a5e9881ad6ecb7d12befb9b0be647f2fa63f5746';

/// See also [formFlatTemplate].
@ProviderFor(formFlatTemplate)
const formFlatTemplateProvider = FormFlatTemplateFamily();

/// See also [formFlatTemplate].
class FormFlatTemplateFamily extends Family {
  /// See also [formFlatTemplate].
  const FormFlatTemplateFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'formFlatTemplateProvider';

  /// See also [formFlatTemplate].
  FormFlatTemplateProvider call({
    required FormMetadata formMetadata,
  }) {
    return FormFlatTemplateProvider(
      formMetadata: formMetadata,
    );
  }

  @visibleForOverriding
  @override
  FormFlatTemplateProvider getProviderOverride(
    covariant FormFlatTemplateProvider provider,
  ) {
    return call(
      formMetadata: provider.formMetadata,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<FormFlatTemplate> Function(FormFlatTemplateRef ref) create) {
    return _$FormFlatTemplateFamilyOverride(this, create);
  }
}

class _$FormFlatTemplateFamilyOverride implements FamilyOverride {
  _$FormFlatTemplateFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<FormFlatTemplate> Function(FormFlatTemplateRef ref) create;

  @override
  final FormFlatTemplateFamily overriddenFamily;

  @override
  FormFlatTemplateProvider getProviderOverride(
    covariant FormFlatTemplateProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [formFlatTemplate].
class FormFlatTemplateProvider
    extends AutoDisposeFutureProvider<FormFlatTemplate> {
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
    FutureOr<FormFlatTemplate> Function(FormFlatTemplateRef ref) create,
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
  ({
    FormMetadata formMetadata,
  }) get argument {
    return (formMetadata: formMetadata,);
  }

  @override
  AutoDisposeFutureProviderElement<FormFlatTemplate> createElement() {
    return _FormFlatTemplateProviderElement(this);
  }

  FormFlatTemplateProvider _copyWith(
    FutureOr<FormFlatTemplate> Function(FormFlatTemplateRef ref) create,
  ) {
    return FormFlatTemplateProvider._internal(
      (ref) => create(ref as FormFlatTemplateRef),
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

mixin FormFlatTemplateRef on AutoDisposeFutureProviderRef<FormFlatTemplate> {
  /// The parameter `formMetadata` of this provider.
  FormMetadata get formMetadata;
}

class _FormFlatTemplateProviderElement
    extends AutoDisposeFutureProviderElement<FormFlatTemplate>
    with FormFlatTemplateRef {
  _FormFlatTemplateProviderElement(super.provider);

  @override
  FormMetadata get formMetadata =>
      (origin as FormFlatTemplateProvider).formMetadata;
}

String _$formInstanceServiceHash() =>
    r'4909c7f6419b997f1293d09630931245dad1f794';

/// See also [formInstanceService].
@ProviderFor(formInstanceService)
const formInstanceServiceProvider = FormInstanceServiceFamily();

/// See also [formInstanceService].
class FormInstanceServiceFamily extends Family {
  /// See also [formInstanceService].
  const FormInstanceServiceFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'formInstanceServiceProvider';

  /// See also [formInstanceService].
  FormInstanceServiceProvider call({
    required FormMetadata formMetadata,
  }) {
    return FormInstanceServiceProvider(
      formMetadata: formMetadata,
    );
  }

  @visibleForOverriding
  @override
  FormInstanceServiceProvider getProviderOverride(
    covariant FormInstanceServiceProvider provider,
  ) {
    return call(
      formMetadata: provider.formMetadata,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<FormInstanceService> Function(FormInstanceServiceRef ref)
          create) {
    return _$FormInstanceServiceFamilyOverride(this, create);
  }
}

class _$FormInstanceServiceFamilyOverride implements FamilyOverride {
  _$FormInstanceServiceFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<FormInstanceService> Function(FormInstanceServiceRef ref)
      create;

  @override
  final FormInstanceServiceFamily overriddenFamily;

  @override
  FormInstanceServiceProvider getProviderOverride(
    covariant FormInstanceServiceProvider provider,
  ) {
    return provider._copyWith(create);
  }
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
    FutureOr<FormInstanceService> Function(FormInstanceServiceRef ref) create,
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
  ({
    FormMetadata formMetadata,
  }) get argument {
    return (formMetadata: formMetadata,);
  }

  @override
  AutoDisposeFutureProviderElement<FormInstanceService> createElement() {
    return _FormInstanceServiceProviderElement(this);
  }

  FormInstanceServiceProvider _copyWith(
    FutureOr<FormInstanceService> Function(FormInstanceServiceRef ref) create,
  ) {
    return FormInstanceServiceProvider._internal(
      (ref) => create(ref as FormInstanceServiceRef),
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

String _$formInstanceHash() => r'c77572321ecbfbb191f80ff535c9d2c716d1f2ad';

/// See also [formInstance].
@ProviderFor(formInstance)
const formInstanceProvider = FormInstanceFamily();

/// See also [formInstance].
class FormInstanceFamily extends Family {
  /// See also [formInstance].
  const FormInstanceFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'formInstanceProvider';

  /// See also [formInstance].
  FormInstanceProvider call({
    required FormMetadata formMetadata,
  }) {
    return FormInstanceProvider(
      formMetadata: formMetadata,
    );
  }

  @visibleForOverriding
  @override
  FormInstanceProvider getProviderOverride(
    covariant FormInstanceProvider provider,
  ) {
    return call(
      formMetadata: provider.formMetadata,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<FormInstance> Function(FormInstanceRef ref) create) {
    return _$FormInstanceFamilyOverride(this, create);
  }
}

class _$FormInstanceFamilyOverride implements FamilyOverride {
  _$FormInstanceFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<FormInstance> Function(FormInstanceRef ref) create;

  @override
  final FormInstanceFamily overriddenFamily;

  @override
  FormInstanceProvider getProviderOverride(
    covariant FormInstanceProvider provider,
  ) {
    return provider._copyWith(create);
  }
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
    FutureOr<FormInstance> Function(FormInstanceRef ref) create,
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
  ({
    FormMetadata formMetadata,
  }) get argument {
    return (formMetadata: formMetadata,);
  }

  @override
  AutoDisposeFutureProviderElement<FormInstance> createElement() {
    return _FormInstanceProviderElement(this);
  }

  FormInstanceProvider _copyWith(
    FutureOr<FormInstance> Function(FormInstanceRef ref) create,
  ) {
    return FormInstanceProvider._internal(
      (ref) => create(ref as FormInstanceRef),
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
    return other is FormInstanceProvider && other.formMetadata == formMetadata;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, formMetadata.hashCode);

    return _SystemHash.finish(hash);
  }
}

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
