// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_list.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$formSubmissionRepositoryHash() =>
    r'fa5d6d41063e018ffd5c882c0407f719aa770d3a';

/// See also [formSubmissionRepository].
@ProviderFor(formSubmissionRepository)
final formSubmissionRepositoryProvider =
    AutoDisposeProvider<FormSubmissionRepository>.internal(
  formSubmissionRepository,
  name: r'formSubmissionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$formSubmissionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FormSubmissionRepositoryRef
    = AutoDisposeProviderRef<FormSubmissionRepository>;
String _$submissionEditStatusHash() =>
    r'18e9fee46f97118ffd5559546279dde53446eebb';

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

/// See also [submissionEditStatus].
@ProviderFor(submissionEditStatus)
const submissionEditStatusProvider = SubmissionEditStatusFamily();

/// See also [submissionEditStatus].
class SubmissionEditStatusFamily extends Family {
  /// See also [submissionEditStatus].
  const SubmissionEditStatusFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'submissionEditStatusProvider';

  /// See also [submissionEditStatus].
  SubmissionEditStatusProvider call({
    required FormMetadata formMetadata,
  }) {
    return SubmissionEditStatusProvider(
      formMetadata: formMetadata,
    );
  }

  @visibleForOverriding
  @override
  SubmissionEditStatusProvider getProviderOverride(
    covariant SubmissionEditStatusProvider provider,
  ) {
    return call(
      formMetadata: provider.formMetadata,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<bool> Function(SubmissionEditStatusRef ref) create) {
    return _$SubmissionEditStatusFamilyOverride(this, create);
  }
}

class _$SubmissionEditStatusFamilyOverride implements FamilyOverride {
  _$SubmissionEditStatusFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<bool> Function(SubmissionEditStatusRef ref) create;

  @override
  final SubmissionEditStatusFamily overriddenFamily;

  @override
  SubmissionEditStatusProvider getProviderOverride(
    covariant SubmissionEditStatusProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [submissionEditStatus].
class SubmissionEditStatusProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [submissionEditStatus].
  SubmissionEditStatusProvider({
    required FormMetadata formMetadata,
  }) : this._internal(
          (ref) => submissionEditStatus(
            ref as SubmissionEditStatusRef,
            formMetadata: formMetadata,
          ),
          from: submissionEditStatusProvider,
          name: r'submissionEditStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$submissionEditStatusHash,
          dependencies: SubmissionEditStatusFamily._dependencies,
          allTransitiveDependencies:
              SubmissionEditStatusFamily._allTransitiveDependencies,
          formMetadata: formMetadata,
        );

  SubmissionEditStatusProvider._internal(
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
    FutureOr<bool> Function(SubmissionEditStatusRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubmissionEditStatusProvider._internal(
        (ref) => create(ref as SubmissionEditStatusRef),
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
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _SubmissionEditStatusProviderElement(this);
  }

  SubmissionEditStatusProvider _copyWith(
    FutureOr<bool> Function(SubmissionEditStatusRef ref) create,
  ) {
    return SubmissionEditStatusProvider._internal(
      (ref) => create(ref as SubmissionEditStatusRef),
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
    return other is SubmissionEditStatusProvider &&
        other.formMetadata == formMetadata;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, formMetadata.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SubmissionEditStatusRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `formMetadata` of this provider.
  FormMetadata get formMetadata;
}

class _SubmissionEditStatusProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with SubmissionEditStatusRef {
  _SubmissionEditStatusProviderElement(super.provider);

  @override
  FormMetadata get formMetadata =>
      (origin as SubmissionEditStatusProvider).formMetadata;
}

String _$formSubmissionDataHash() =>
    r'629104e5aee562e4b2fe6325049bf5ac7a2a8f31';

/// See also [formSubmissionData].
@ProviderFor(formSubmissionData)
const formSubmissionDataProvider = FormSubmissionDataFamily();

/// See also [formSubmissionData].
class FormSubmissionDataFamily extends Family {
  /// See also [formSubmissionData].
  const FormSubmissionDataFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'formSubmissionDataProvider';

  /// See also [formSubmissionData].
  FormSubmissionDataProvider call({
    required String submissionId,
  }) {
    return FormSubmissionDataProvider(
      submissionId: submissionId,
    );
  }

  @visibleForOverriding
  @override
  FormSubmissionDataProvider getProviderOverride(
    covariant FormSubmissionDataProvider provider,
  ) {
    return call(
      submissionId: provider.submissionId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<IMap<String, dynamic>> Function(FormSubmissionDataRef ref)
          create) {
    return _$FormSubmissionDataFamilyOverride(this, create);
  }
}

class _$FormSubmissionDataFamilyOverride implements FamilyOverride {
  _$FormSubmissionDataFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<IMap<String, dynamic>> Function(FormSubmissionDataRef ref)
      create;

  @override
  final FormSubmissionDataFamily overriddenFamily;

  @override
  FormSubmissionDataProvider getProviderOverride(
    covariant FormSubmissionDataProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [formSubmissionData].
class FormSubmissionDataProvider
    extends AutoDisposeFutureProvider<IMap<String, dynamic>> {
  /// See also [formSubmissionData].
  FormSubmissionDataProvider({
    required String submissionId,
  }) : this._internal(
          (ref) => formSubmissionData(
            ref as FormSubmissionDataRef,
            submissionId: submissionId,
          ),
          from: formSubmissionDataProvider,
          name: r'formSubmissionDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$formSubmissionDataHash,
          dependencies: FormSubmissionDataFamily._dependencies,
          allTransitiveDependencies:
              FormSubmissionDataFamily._allTransitiveDependencies,
          submissionId: submissionId,
        );

  FormSubmissionDataProvider._internal(
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
  Override overrideWith(
    FutureOr<IMap<String, dynamic>> Function(FormSubmissionDataRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FormSubmissionDataProvider._internal(
        (ref) => create(ref as FormSubmissionDataRef),
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
  ({
    String submissionId,
  }) get argument {
    return (submissionId: submissionId,);
  }

  @override
  AutoDisposeFutureProviderElement<IMap<String, dynamic>> createElement() {
    return _FormSubmissionDataProviderElement(this);
  }

  FormSubmissionDataProvider _copyWith(
    FutureOr<IMap<String, dynamic>> Function(FormSubmissionDataRef ref) create,
  ) {
    return FormSubmissionDataProvider._internal(
      (ref) => create(ref as FormSubmissionDataRef),
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
    return other is FormSubmissionDataProvider &&
        other.submissionId == submissionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, submissionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FormSubmissionDataRef
    on AutoDisposeFutureProviderRef<IMap<String, dynamic>> {
  /// The parameter `submissionId` of this provider.
  String get submissionId;
}

class _FormSubmissionDataProviderElement
    extends AutoDisposeFutureProviderElement<IMap<String, dynamic>>
    with FormSubmissionDataRef {
  _FormSubmissionDataProviderElement(super.provider);

  @override
  String get submissionId =>
      (origin as FormSubmissionDataProvider).submissionId;
}

String _$submissionFilteredByStateHash() =>
    r'bf5de42d1a449188a5fa4e0822a5ebb1ec802989';

/// See also [submissionFilteredByState].
@ProviderFor(submissionFilteredByState)
const submissionFilteredByStateProvider = SubmissionFilteredByStateFamily();

/// See also [submissionFilteredByState].
class SubmissionFilteredByStateFamily extends Family {
  /// See also [submissionFilteredByState].
  const SubmissionFilteredByStateFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'submissionFilteredByStateProvider';

  /// See also [submissionFilteredByState].
  SubmissionFilteredByStateProvider call({
    required String form,
    SyncStatus? status,
    String sortBy = 'name',
  }) {
    return SubmissionFilteredByStateProvider(
      form: form,
      status: status,
      sortBy: sortBy,
    );
  }

  @visibleForOverriding
  @override
  SubmissionFilteredByStateProvider getProviderOverride(
    covariant SubmissionFilteredByStateProvider provider,
  ) {
    return call(
      form: provider.form,
      status: provider.status,
      sortBy: provider.sortBy,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<DataFormSubmission>> Function(
              SubmissionFilteredByStateRef ref)
          create) {
    return _$SubmissionFilteredByStateFamilyOverride(this, create);
  }
}

class _$SubmissionFilteredByStateFamilyOverride implements FamilyOverride {
  _$SubmissionFilteredByStateFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<DataFormSubmission>> Function(
      SubmissionFilteredByStateRef ref) create;

  @override
  final SubmissionFilteredByStateFamily overriddenFamily;

  @override
  SubmissionFilteredByStateProvider getProviderOverride(
    covariant SubmissionFilteredByStateProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [submissionFilteredByState].
class SubmissionFilteredByStateProvider
    extends AutoDisposeFutureProvider<List<DataFormSubmission>> {
  /// See also [submissionFilteredByState].
  SubmissionFilteredByStateProvider({
    required String form,
    SyncStatus? status,
    String sortBy = 'name',
  }) : this._internal(
          (ref) => submissionFilteredByState(
            ref as SubmissionFilteredByStateRef,
            form: form,
            status: status,
            sortBy: sortBy,
          ),
          from: submissionFilteredByStateProvider,
          name: r'submissionFilteredByStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$submissionFilteredByStateHash,
          dependencies: SubmissionFilteredByStateFamily._dependencies,
          allTransitiveDependencies:
              SubmissionFilteredByStateFamily._allTransitiveDependencies,
          form: form,
          status: status,
          sortBy: sortBy,
        );

  SubmissionFilteredByStateProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.form,
    required this.status,
    required this.sortBy,
  }) : super.internal();

  final String form;
  final SyncStatus? status;
  final String sortBy;

  @override
  Override overrideWith(
    FutureOr<List<DataFormSubmission>> Function(
            SubmissionFilteredByStateRef ref)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubmissionFilteredByStateProvider._internal(
        (ref) => create(ref as SubmissionFilteredByStateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        form: form,
        status: status,
        sortBy: sortBy,
      ),
    );
  }

  @override
  ({
    String form,
    SyncStatus? status,
    String sortBy,
  }) get argument {
    return (
      form: form,
      status: status,
      sortBy: sortBy,
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DataFormSubmission>> createElement() {
    return _SubmissionFilteredByStateProviderElement(this);
  }

  SubmissionFilteredByStateProvider _copyWith(
    FutureOr<List<DataFormSubmission>> Function(
            SubmissionFilteredByStateRef ref)
        create,
  ) {
    return SubmissionFilteredByStateProvider._internal(
      (ref) => create(ref as SubmissionFilteredByStateRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      form: form,
      status: status,
      sortBy: sortBy,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SubmissionFilteredByStateProvider &&
        other.form == form &&
        other.status == status &&
        other.sortBy == sortBy;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, form.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);
    hash = _SystemHash.combine(hash, sortBy.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SubmissionFilteredByStateRef
    on AutoDisposeFutureProviderRef<List<DataFormSubmission>> {
  /// The parameter `form` of this provider.
  String get form;

  /// The parameter `status` of this provider.
  SyncStatus? get status;

  /// The parameter `sortBy` of this provider.
  String get sortBy;
}

class _SubmissionFilteredByStateProviderElement
    extends AutoDisposeFutureProviderElement<List<DataFormSubmission>>
    with SubmissionFilteredByStateRef {
  _SubmissionFilteredByStateProviderElement(super.provider);

  @override
  String get form => (origin as SubmissionFilteredByStateProvider).form;
  @override
  SyncStatus? get status =>
      (origin as SubmissionFilteredByStateProvider).status;
  @override
  String get sortBy => (origin as SubmissionFilteredByStateProvider).sortBy;
}

String _$submissionInfoHash() => r'e0be77a427cde38d871e92ed76044eae802b9c85';

/// See also [submissionInfo].
@ProviderFor(submissionInfo)
const submissionInfoProvider = SubmissionInfoFamily();

/// See also [submissionInfo].
class SubmissionInfoFamily extends Family {
  /// See also [submissionInfo].
  const SubmissionInfoFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'submissionInfoProvider';

  /// See also [submissionInfo].
  SubmissionInfoProvider call({
    required FormMetadata formMetadata,
  }) {
    return SubmissionInfoProvider(
      formMetadata: formMetadata,
    );
  }

  @visibleForOverriding
  @override
  SubmissionInfoProvider getProviderOverride(
    covariant SubmissionInfoProvider provider,
  ) {
    return call(
      formMetadata: provider.formMetadata,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<SubmissionItemSummaryModel> Function(SubmissionInfoRef ref)
          create) {
    return _$SubmissionInfoFamilyOverride(this, create);
  }
}

class _$SubmissionInfoFamilyOverride implements FamilyOverride {
  _$SubmissionInfoFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<SubmissionItemSummaryModel> Function(SubmissionInfoRef ref)
      create;

  @override
  final SubmissionInfoFamily overriddenFamily;

  @override
  SubmissionInfoProvider getProviderOverride(
    covariant SubmissionInfoProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [submissionInfo].
class SubmissionInfoProvider
    extends AutoDisposeFutureProvider<SubmissionItemSummaryModel> {
  /// See also [submissionInfo].
  SubmissionInfoProvider({
    required FormMetadata formMetadata,
  }) : this._internal(
          (ref) => submissionInfo(
            ref as SubmissionInfoRef,
            formMetadata: formMetadata,
          ),
          from: submissionInfoProvider,
          name: r'submissionInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$submissionInfoHash,
          dependencies: SubmissionInfoFamily._dependencies,
          allTransitiveDependencies:
              SubmissionInfoFamily._allTransitiveDependencies,
          formMetadata: formMetadata,
        );

  SubmissionInfoProvider._internal(
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
    FutureOr<SubmissionItemSummaryModel> Function(SubmissionInfoRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubmissionInfoProvider._internal(
        (ref) => create(ref as SubmissionInfoRef),
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
  AutoDisposeFutureProviderElement<SubmissionItemSummaryModel> createElement() {
    return _SubmissionInfoProviderElement(this);
  }

  SubmissionInfoProvider _copyWith(
    FutureOr<SubmissionItemSummaryModel> Function(SubmissionInfoRef ref) create,
  ) {
    return SubmissionInfoProvider._internal(
      (ref) => create(ref as SubmissionInfoRef),
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
    return other is SubmissionInfoProvider &&
        other.formMetadata == formMetadata;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, formMetadata.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SubmissionInfoRef
    on AutoDisposeFutureProviderRef<SubmissionItemSummaryModel> {
  /// The parameter `formMetadata` of this provider.
  FormMetadata get formMetadata;
}

class _SubmissionInfoProviderElement
    extends AutoDisposeFutureProviderElement<SubmissionItemSummaryModel>
    with SubmissionInfoRef {
  _SubmissionInfoProviderElement(super.provider);

  @override
  FormMetadata get formMetadata =>
      (origin as SubmissionInfoProvider).formMetadata;
}

String _$formSubmissionsHash() => r'6fe5490fe2f0ea8cc28fae0588121bb0ce7766b7';

abstract class _$FormSubmissions
    extends BuildlessAutoDisposeAsyncNotifier<IList<DataFormSubmission>> {
  late final String form;

  FutureOr<IList<DataFormSubmission>> build(
    String form,
  );
}

/// See also [FormSubmissions].
@ProviderFor(FormSubmissions)
const formSubmissionsProvider = FormSubmissionsFamily();

/// See also [FormSubmissions].
class FormSubmissionsFamily extends Family {
  /// See also [FormSubmissions].
  const FormSubmissionsFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'formSubmissionsProvider';

  /// See also [FormSubmissions].
  FormSubmissionsProvider call(
    String form,
  ) {
    return FormSubmissionsProvider(
      form,
    );
  }

  @visibleForOverriding
  @override
  FormSubmissionsProvider getProviderOverride(
    covariant FormSubmissionsProvider provider,
  ) {
    return call(
      provider.form,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(FormSubmissions Function() create) {
    return _$FormSubmissionsFamilyOverride(this, create);
  }
}

class _$FormSubmissionsFamilyOverride implements FamilyOverride {
  _$FormSubmissionsFamilyOverride(this.overriddenFamily, this.create);

  final FormSubmissions Function() create;

  @override
  final FormSubmissionsFamily overriddenFamily;

  @override
  FormSubmissionsProvider getProviderOverride(
    covariant FormSubmissionsProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [FormSubmissions].
class FormSubmissionsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    FormSubmissions, IList<DataFormSubmission>> {
  /// See also [FormSubmissions].
  FormSubmissionsProvider(
    String form,
  ) : this._internal(
          () => FormSubmissions()..form = form,
          from: formSubmissionsProvider,
          name: r'formSubmissionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$formSubmissionsHash,
          dependencies: FormSubmissionsFamily._dependencies,
          allTransitiveDependencies:
              FormSubmissionsFamily._allTransitiveDependencies,
          form: form,
        );

  FormSubmissionsProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.form,
  }) : super.internal();

  final String form;

  @override
  FutureOr<IList<DataFormSubmission>> runNotifierBuild(
    covariant FormSubmissions notifier,
  ) {
    return notifier.build(
      form,
    );
  }

  @override
  Override overrideWith(FormSubmissions Function() create) {
    return ProviderOverride(
      origin: this,
      override: FormSubmissionsProvider._internal(
        () => create()..form = form,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        form: form,
      ),
    );
  }

  @override
  (String,) get argument {
    return (form,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FormSubmissions,
      IList<DataFormSubmission>> createElement() {
    return _FormSubmissionsProviderElement(this);
  }

  FormSubmissionsProvider _copyWith(
    FormSubmissions Function() create,
  ) {
    return FormSubmissionsProvider._internal(
      () => create()..form = form,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      form: form,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FormSubmissionsProvider && other.form == form;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, form.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FormSubmissionsRef
    on AutoDisposeAsyncNotifierProviderRef<IList<DataFormSubmission>> {
  /// The parameter `form` of this provider.
  String get form;
}

class _FormSubmissionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FormSubmissions,
        IList<DataFormSubmission>> with FormSubmissionsRef {
  _FormSubmissionsProviderElement(super.provider);

  @override
  String get form => (origin as FormSubmissionsProvider).form;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
