// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_submission.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$formSubmissionsHash() => r'0ad5ad17bde0b3a9ea43e67996a06f4b2f9d735d';

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

/// See also [formSubmissions].
@ProviderFor(formSubmissions)
const formSubmissionsProvider = FormSubmissionsFamily();

/// See also [formSubmissions].
class FormSubmissionsFamily
    extends Family<AsyncValue<List<SubmissionCardSummary>>> {
  /// See also [formSubmissions].
  const FormSubmissionsFamily();

  /// See also [formSubmissions].
  FormSubmissionsProvider call({
    SubmissionsFilter? filter,
    required String formId,
  }) {
    return FormSubmissionsProvider(
      filter: filter,
      formId: formId,
    );
  }

  @override
  FormSubmissionsProvider getProviderOverride(
    covariant FormSubmissionsProvider provider,
  ) {
    return call(
      filter: provider.filter,
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
  String? get name => r'formSubmissionsProvider';
}

/// See also [formSubmissions].
class FormSubmissionsProvider
    extends AutoDisposeFutureProvider<List<SubmissionCardSummary>> {
  /// See also [formSubmissions].
  FormSubmissionsProvider({
    SubmissionsFilter? filter,
    required String formId,
  }) : this._internal(
          (ref) => formSubmissions(
            ref as FormSubmissionsRef,
            filter: filter,
            formId: formId,
          ),
          from: formSubmissionsProvider,
          name: r'formSubmissionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$formSubmissionsHash,
          dependencies: FormSubmissionsFamily._dependencies,
          allTransitiveDependencies:
              FormSubmissionsFamily._allTransitiveDependencies,
          filter: filter,
          formId: formId,
        );

  FormSubmissionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filter,
    required this.formId,
  }) : super.internal();

  final SubmissionsFilter? filter;
  final String formId;

  @override
  Override overrideWith(
    FutureOr<List<SubmissionCardSummary>> Function(FormSubmissionsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FormSubmissionsProvider._internal(
        (ref) => create(ref as FormSubmissionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filter: filter,
        formId: formId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SubmissionCardSummary>>
      createElement() {
    return _FormSubmissionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormSubmissionsProvider &&
        other.filter == filter &&
        other.formId == formId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);
    hash = _SystemHash.combine(hash, formId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FormSubmissionsRef
    on AutoDisposeFutureProviderRef<List<SubmissionCardSummary>> {
  /// The parameter `filter` of this provider.
  SubmissionsFilter? get filter;

  /// The parameter `formId` of this provider.
  String get formId;
}

class _FormSubmissionsProviderElement
    extends AutoDisposeFutureProviderElement<List<SubmissionCardSummary>>
    with FormSubmissionsRef {
  _FormSubmissionsProviderElement(super.provider);

  @override
  SubmissionsFilter? get filter => (origin as FormSubmissionsProvider).filter;
  @override
  String get formId => (origin as FormSubmissionsProvider).formId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
