// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$formListItemsHash() => r'9c2b01e2ad6a115c8d981f373a5e5aad1f0e4b50';

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

/// See also [formListItems].
@ProviderFor(formListItems)
const formListItemsProvider = FormListItemsFamily();

/// See also [formListItems].
class FormListItemsFamily extends Family<AsyncValue<List<FormListItemModel>>> {
  /// See also [formListItems].
  const FormListItemsFamily();

  /// See also [formListItems].
  FormListItemsProvider call(
    FormListFilter filter,
  ) {
    return FormListItemsProvider(
      filter,
    );
  }

  @override
  FormListItemsProvider getProviderOverride(
    covariant FormListItemsProvider provider,
  ) {
    return call(
      provider.filter,
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
  String? get name => r'formListItemsProvider';
}

/// See also [formListItems].
class FormListItemsProvider
    extends AutoDisposeFutureProvider<List<FormListItemModel>> {
  /// See also [formListItems].
  FormListItemsProvider(
    FormListFilter filter,
  ) : this._internal(
          (ref) => formListItems(
            ref as FormListItemsRef,
            filter,
          ),
          from: formListItemsProvider,
          name: r'formListItemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$formListItemsHash,
          dependencies: FormListItemsFamily._dependencies,
          allTransitiveDependencies:
              FormListItemsFamily._allTransitiveDependencies,
          filter: filter,
        );

  FormListItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filter,
  }) : super.internal();

  final FormListFilter filter;

  @override
  Override overrideWith(
    FutureOr<List<FormListItemModel>> Function(FormListItemsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FormListItemsProvider._internal(
        (ref) => create(ref as FormListItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filter: filter,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<FormListItemModel>> createElement() {
    return _FormListItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormListItemsProvider && other.filter == filter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FormListItemsRef
    on AutoDisposeFutureProviderRef<List<FormListItemModel>> {
  /// The parameter `filter` of this provider.
  FormListFilter get filter;
}

class _FormListItemsProviderElement
    extends AutoDisposeFutureProviderElement<List<FormListItemModel>>
    with FormListItemsRef {
  _FormListItemsProviderElement(super.provider);

  @override
  FormListFilter get filter => (origin as FormListItemsProvider).filter;
}

String _$formTemplateOptionsHash() =>
    r'e06c7407aa6932937d86084a6984b2ef873f87fe';

/// See also [formTemplateOptions].
@ProviderFor(formTemplateOptions)
const formTemplateOptionsProvider = FormTemplateOptionsFamily();

/// See also [formTemplateOptions].
class FormTemplateOptionsFamily
    extends Family<AsyncValue<Map<String, List<DataOption>>>> {
  /// See also [formTemplateOptions].
  const FormTemplateOptionsFamily();

  /// See also [formTemplateOptions].
  FormTemplateOptionsProvider call({
    required String formId,
    String? versionId,
  }) {
    return FormTemplateOptionsProvider(
      formId: formId,
      versionId: versionId,
    );
  }

  @override
  FormTemplateOptionsProvider getProviderOverride(
    covariant FormTemplateOptionsProvider provider,
  ) {
    return call(
      formId: provider.formId,
      versionId: provider.versionId,
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
    extends AutoDisposeFutureProvider<Map<String, List<DataOption>>> {
  /// See also [formTemplateOptions].
  FormTemplateOptionsProvider({
    required String formId,
    String? versionId,
  }) : this._internal(
          (ref) => formTemplateOptions(
            ref as FormTemplateOptionsRef,
            formId: formId,
            versionId: versionId,
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
          versionId: versionId,
        );

  FormTemplateOptionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.formId,
    required this.versionId,
  }) : super.internal();

  final String formId;
  final String? versionId;

  @override
  Override overrideWith(
    FutureOr<Map<String, List<DataOption>>> Function(
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
        versionId: versionId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, List<DataOption>>>
      createElement() {
    return _FormTemplateOptionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormTemplateOptionsProvider &&
        other.formId == formId &&
        other.versionId == versionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, formId.hashCode);
    hash = _SystemHash.combine(hash, versionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FormTemplateOptionsRef
    on AutoDisposeFutureProviderRef<Map<String, List<DataOption>>> {
  /// The parameter `formId` of this provider.
  String get formId;

  /// The parameter `versionId` of this provider.
  String? get versionId;
}

class _FormTemplateOptionsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, List<DataOption>>>
    with FormTemplateOptionsRef {
  _FormTemplateOptionsProviderElement(super.provider);

  @override
  String get formId => (origin as FormTemplateOptionsProvider).formId;
  @override
  String? get versionId => (origin as FormTemplateOptionsProvider).versionId;
}

String _$optionSetHash() => r'b737d88782db4f528d82344800174c7385787e5d';

/// See also [optionSet].
@ProviderFor(optionSet)
const optionSetProvider = OptionSetFamily();

/// See also [optionSet].
class OptionSetFamily extends Family<AsyncValue<DataOptionSet?>> {
  /// See also [optionSet].
  const OptionSetFamily();

  /// See also [optionSet].
  OptionSetProvider call({
    required String id,
  }) {
    return OptionSetProvider(
      id: id,
    );
  }

  @override
  OptionSetProvider getProviderOverride(
    covariant OptionSetProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'optionSetProvider';
}

/// See also [optionSet].
class OptionSetProvider extends AutoDisposeFutureProvider<DataOptionSet?> {
  /// See also [optionSet].
  OptionSetProvider({
    required String id,
  }) : this._internal(
          (ref) => optionSet(
            ref as OptionSetRef,
            id: id,
          ),
          from: optionSetProvider,
          name: r'optionSetProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$optionSetHash,
          dependencies: OptionSetFamily._dependencies,
          allTransitiveDependencies: OptionSetFamily._allTransitiveDependencies,
          id: id,
        );

  OptionSetProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<DataOptionSet?> Function(OptionSetRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OptionSetProvider._internal(
        (ref) => create(ref as OptionSetRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DataOptionSet?> createElement() {
    return _OptionSetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OptionSetProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OptionSetRef on AutoDisposeFutureProviderRef<DataOptionSet?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _OptionSetProviderElement
    extends AutoDisposeFutureProviderElement<DataOptionSet?> with OptionSetRef {
  _OptionSetProviderElement(super.provider);

  @override
  String get id => (origin as OptionSetProvider).id;
}

String _$submissionVersionFormTemplateHash() =>
    r'826ff95e5a606076c9a0f8f4863d686ff517d5bc';

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
    extends Family<AsyncValue<FormTemplateModel>> {
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
    extends AutoDisposeFutureProvider<FormTemplateModel> {
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
    FutureOr<FormTemplateModel> Function(
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
  AutoDisposeFutureProviderElement<FormTemplateModel> createElement() {
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
    on AutoDisposeFutureProviderRef<FormTemplateModel> {
  /// The parameter `formId` of this provider.
  String get formId;
}

class _SubmissionVersionFormTemplateProviderElement
    extends AutoDisposeFutureProviderElement<FormTemplateModel>
    with SubmissionVersionFormTemplateRef {
  _SubmissionVersionFormTemplateProviderElement(super.provider);

  @override
  String get formId => (origin as SubmissionVersionFormTemplateProvider).formId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
