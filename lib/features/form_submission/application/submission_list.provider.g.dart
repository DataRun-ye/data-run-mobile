// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_list.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$formSubmissionRepositoryHash() =>
    r'563d892c0f3b7f12559b16c0c0e04ed616934624';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FormSubmissionRepositoryRef
    = AutoDisposeProviderRef<FormSubmissionRepository>;
String _$submissionEditStatusHash() =>
    r'02d9349aaea6e5b425324fcafea9817097b43533';

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
class SubmissionEditStatusFamily extends Family<AsyncValue<bool>> {
  /// See also [submissionEditStatus].
  const SubmissionEditStatusFamily();

  /// See also [submissionEditStatus].
  SubmissionEditStatusProvider call({
    required String submissionId,
  }) {
    return SubmissionEditStatusProvider(
      submissionId: submissionId,
    );
  }

  @override
  SubmissionEditStatusProvider getProviderOverride(
    covariant SubmissionEditStatusProvider provider,
  ) {
    return call(
      submissionId: provider.submissionId,
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
  String? get name => r'submissionEditStatusProvider';
}

/// See also [submissionEditStatus].
class SubmissionEditStatusProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [submissionEditStatus].
  SubmissionEditStatusProvider({
    required String submissionId,
  }) : this._internal(
          (ref) => submissionEditStatus(
            ref as SubmissionEditStatusRef,
            submissionId: submissionId,
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
          submissionId: submissionId,
        );

  SubmissionEditStatusProvider._internal(
    super._createNotifier, {
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
    FutureOr<bool> Function(SubmissionEditStatusRef provider) create,
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
        submissionId: submissionId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _SubmissionEditStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubmissionEditStatusProvider &&
        other.submissionId == submissionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, submissionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubmissionEditStatusRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `submissionId` of this provider.
  String get submissionId;
}

class _SubmissionEditStatusProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with SubmissionEditStatusRef {
  _SubmissionEditStatusProviderElement(super.provider);

  @override
  String get submissionId =>
      (origin as SubmissionEditStatusProvider).submissionId;
}

String _$formSubmissionsHash() => r'5480ac4cc116eb8a7442729b67fa3f92adac3706';

abstract class _$FormSubmissions
    extends BuildlessAutoDisposeAsyncNotifier<IList<DataInstance>> {
  late final String form;

  FutureOr<IList<DataInstance>> build(
    String form,
  );
}

/// See also [FormSubmissions].
@ProviderFor(FormSubmissions)
const formSubmissionsProvider = FormSubmissionsFamily();

/// See also [FormSubmissions].
class FormSubmissionsFamily extends Family<AsyncValue<IList<DataInstance>>> {
  /// See also [FormSubmissions].
  const FormSubmissionsFamily();

  /// See also [FormSubmissions].
  FormSubmissionsProvider call(
    String form,
  ) {
    return FormSubmissionsProvider(
      form,
    );
  }

  @override
  FormSubmissionsProvider getProviderOverride(
    covariant FormSubmissionsProvider provider,
  ) {
    return call(
      provider.form,
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
  String? get name => r'formSubmissionsProvider';
}

/// See also [FormSubmissions].
class FormSubmissionsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    FormSubmissions, IList<DataInstance>> {
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
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.form,
  }) : super.internal();

  final String form;

  @override
  FutureOr<IList<DataInstance>> runNotifierBuild(
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
  AutoDisposeAsyncNotifierProviderElement<FormSubmissions, IList<DataInstance>>
      createElement() {
    return _FormSubmissionsProviderElement(this);
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FormSubmissionsRef
    on AutoDisposeAsyncNotifierProviderRef<IList<DataInstance>> {
  /// The parameter `form` of this provider.
  String get form;
}

class _FormSubmissionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FormSubmissions,
        IList<DataInstance>> with FormSubmissionsRef {
  _FormSubmissionsProviderElement(super.provider);

  @override
  String get form => (origin as FormSubmissionsProvider).form;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
