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
String _$formTemplateOptionsHash() =>
    r'1cd4927b9d81cff4eddcce14f58ab35396974bb7';

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

/// See also [formTemplateOptions].
@ProviderFor(formTemplateOptions)
const formTemplateOptionsProvider = FormTemplateOptionsFamily();

/// See also [formTemplateOptions].
class FormTemplateOptionsFamily
    extends Family<AsyncValue<IMap<String, IList<FormOption>>>> {
  /// See also [formTemplateOptions].
  const FormTemplateOptionsFamily();

  /// See also [formTemplateOptions].
  FormTemplateOptionsProvider call({
    required String formId,
  }) {
    return FormTemplateOptionsProvider(
      formId: formId,
    );
  }

  @override
  FormTemplateOptionsProvider getProviderOverride(
    covariant FormTemplateOptionsProvider provider,
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
  String? get name => r'formTemplateOptionsProvider';
}

/// See also [formTemplateOptions].
class FormTemplateOptionsProvider
    extends AutoDisposeFutureProvider<IMap<String, IList<FormOption>>> {
  /// See also [formTemplateOptions].
  FormTemplateOptionsProvider({
    required String formId,
  }) : this._internal(
          (ref) => formTemplateOptions(
            ref as FormTemplateOptionsRef,
            formId: formId,
          ),
          from: formTemplateOptionsProvider,
          name: r'formTemplateOptionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$formTemplateOptionsHash,
          dependencies: FormTemplateOptionsFamily._dependencies,
          allTransitiveDependencies:
              FormTemplateOptionsFamily._allTransitiveDependencies,
          formId: formId,
        );

  FormTemplateOptionsProvider._internal(
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
    FutureOr<IMap<String, IList<FormOption>>> Function(
            FormTemplateOptionsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FormTemplateOptionsProvider._internal(
        (ref) => create(ref as FormTemplateOptionsRef),
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
  AutoDisposeFutureProviderElement<IMap<String, IList<FormOption>>>
      createElement() {
    return _FormTemplateOptionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormTemplateOptionsProvider && other.formId == formId;
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
mixin FormTemplateOptionsRef
    on AutoDisposeFutureProviderRef<IMap<String, IList<FormOption>>> {
  /// The parameter `formId` of this provider.
  String get formId;
}

class _FormTemplateOptionsProviderElement
    extends AutoDisposeFutureProviderElement<IMap<String, IList<FormOption>>>
    with FormTemplateOptionsRef {
  _FormTemplateOptionsProviderElement(super.provider);

  @override
  String get formId => (origin as FormTemplateOptionsProvider).formId;
}

String _$submissionVersionFormTemplateHash() =>
    r'b659d647474e6a6c9b7da3a16fe3c47921a56c2a';

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
class SubmissionVersionFormTemplateFamily
    extends Family<AsyncValue<FormTemplateVersion>> {
  /// form id could be on the format of formId-version or formId
  /// look for the latest version of the form template or the form template
  /// that matches the version
  ///
  /// Copied from [submissionVersionFormTemplate].
  const SubmissionVersionFormTemplateFamily();

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

  @override
  SubmissionVersionFormTemplateProvider getProviderOverride(
    covariant SubmissionVersionFormTemplateProvider provider,
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
  String? get name => r'submissionVersionFormTemplateProvider';
}

/// form id could be on the format of formId-version or formId
/// look for the latest version of the form template or the form template
/// that matches the version
///
/// Copied from [submissionVersionFormTemplate].
class SubmissionVersionFormTemplateProvider
    extends AutoDisposeFutureProvider<FormTemplateVersion> {
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
    FutureOr<FormTemplateVersion> Function(
            SubmissionVersionFormTemplateRef provider)
        create,
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
  AutoDisposeFutureProviderElement<FormTemplateVersion> createElement() {
    return _SubmissionVersionFormTemplateProviderElement(this);
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubmissionVersionFormTemplateRef
    on AutoDisposeFutureProviderRef<FormTemplateVersion> {
  /// The parameter `formId` of this provider.
  String get formId;
}

class _SubmissionVersionFormTemplateProviderElement
    extends AutoDisposeFutureProviderElement<FormTemplateVersion>
    with SubmissionVersionFormTemplateRef {
  _SubmissionVersionFormTemplateProviderElement(super.provider);

  @override
  String get formId => (origin as SubmissionVersionFormTemplateProvider).formId;
}

String _$formTemplateModelHash() => r'7813bef6dc376d1dd9ec3056eed96953380a3825';

/// See also [formTemplateModel].
@ProviderFor(formTemplateModel)
const formTemplateModelProvider = FormTemplateModelFamily();

/// See also [formTemplateModel].
class FormTemplateModelFamily extends Family<AsyncValue<FormFlatTemplate>> {
  /// See also [formTemplateModel].
  const FormTemplateModelFamily();

  /// See also [formTemplateModel].
  FormTemplateModelProvider call({
    required String versionIdOrFormId,
  }) {
    return FormTemplateModelProvider(
      versionIdOrFormId: versionIdOrFormId,
    );
  }

  @override
  FormTemplateModelProvider getProviderOverride(
    covariant FormTemplateModelProvider provider,
  ) {
    return call(
      versionIdOrFormId: provider.versionIdOrFormId,
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
  String? get name => r'formTemplateModelProvider';
}

/// See also [formTemplateModel].
class FormTemplateModelProvider
    extends AutoDisposeFutureProvider<FormFlatTemplate> {
  /// See also [formTemplateModel].
  FormTemplateModelProvider({
    required String versionIdOrFormId,
  }) : this._internal(
          (ref) => formTemplateModel(
            ref as FormTemplateModelRef,
            versionIdOrFormId: versionIdOrFormId,
          ),
          from: formTemplateModelProvider,
          name: r'formTemplateModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$formTemplateModelHash,
          dependencies: FormTemplateModelFamily._dependencies,
          allTransitiveDependencies:
              FormTemplateModelFamily._allTransitiveDependencies,
          versionIdOrFormId: versionIdOrFormId,
        );

  FormTemplateModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.versionIdOrFormId,
  }) : super.internal();

  final String versionIdOrFormId;

  @override
  Override overrideWith(
    FutureOr<FormFlatTemplate> Function(FormTemplateModelRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FormTemplateModelProvider._internal(
        (ref) => create(ref as FormTemplateModelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        versionIdOrFormId: versionIdOrFormId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FormFlatTemplate> createElement() {
    return _FormTemplateModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormTemplateModelProvider &&
        other.versionIdOrFormId == versionIdOrFormId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, versionIdOrFormId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FormTemplateModelRef on AutoDisposeFutureProviderRef<FormFlatTemplate> {
  /// The parameter `versionIdOrFormId` of this provider.
  String get versionIdOrFormId;
}

class _FormTemplateModelProviderElement
    extends AutoDisposeFutureProviderElement<FormFlatTemplate>
    with FormTemplateModelRef {
  _FormTemplateModelProviderElement(super.provider);

  @override
  String get versionIdOrFormId =>
      (origin as FormTemplateModelProvider).versionIdOrFormId;
}

String _$formFlatTemplateHash() => r'ec73d447ab220a3723e795ee708001fbe4c96d63';

/// See also [formFlatTemplate].
@ProviderFor(formFlatTemplate)
const formFlatTemplateProvider = FormFlatTemplateFamily();

/// See also [formFlatTemplate].
class FormFlatTemplateFamily extends Family<AsyncValue<FormFlatTemplate>> {
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
    FutureOr<FormFlatTemplate> Function(FormFlatTemplateRef provider) create,
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
  AutoDisposeFutureProviderElement<FormFlatTemplate> createElement() {
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
    r'ba1f23f32f2cd9556f84cfd8bcd88c4f605a10d1';

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
