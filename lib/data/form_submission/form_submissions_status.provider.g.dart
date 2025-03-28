// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_submissions_status.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$formSubmissionsStatusHash() =>
    r'073c20d896e342a6166193375fdaded46b87b798';

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

/// See also [formSubmissionsStatus].
@ProviderFor(formSubmissionsStatus)
const formSubmissionsStatusProvider = FormSubmissionsStatusFamily();

/// See also [formSubmissionsStatus].
class FormSubmissionsStatusFamily extends Family {
  /// See also [formSubmissionsStatus].
  const FormSubmissionsStatusFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'formSubmissionsStatusProvider';

  /// See also [formSubmissionsStatus].
  FormSubmissionsStatusProvider call(
    String form,
  ) {
    return FormSubmissionsStatusProvider(
      form,
    );
  }

  @visibleForOverriding
  @override
  FormSubmissionsStatusProvider getProviderOverride(
    covariant FormSubmissionsStatusProvider provider,
  ) {
    return call(
      provider.form,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<FormSubmissionsStatus> Function(FormSubmissionsStatusRef ref)
          create) {
    return _$FormSubmissionsStatusFamilyOverride(this, create);
  }
}

class _$FormSubmissionsStatusFamilyOverride implements FamilyOverride {
  _$FormSubmissionsStatusFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<FormSubmissionsStatus> Function(FormSubmissionsStatusRef ref)
      create;

  @override
  final FormSubmissionsStatusFamily overriddenFamily;

  @override
  FormSubmissionsStatusProvider getProviderOverride(
    covariant FormSubmissionsStatusProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [formSubmissionsStatus].
class FormSubmissionsStatusProvider
    extends AutoDisposeFutureProvider<FormSubmissionsStatus> {
  /// See also [formSubmissionsStatus].
  FormSubmissionsStatusProvider(
    String form,
  ) : this._internal(
          (ref) => formSubmissionsStatus(
            ref as FormSubmissionsStatusRef,
            form,
          ),
          from: formSubmissionsStatusProvider,
          name: r'formSubmissionsStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$formSubmissionsStatusHash,
          dependencies: FormSubmissionsStatusFamily._dependencies,
          allTransitiveDependencies:
              FormSubmissionsStatusFamily._allTransitiveDependencies,
          form: form,
        );

  FormSubmissionsStatusProvider._internal(
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
  Override overrideWith(
    FutureOr<FormSubmissionsStatus> Function(FormSubmissionsStatusRef ref)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FormSubmissionsStatusProvider._internal(
        (ref) => create(ref as FormSubmissionsStatusRef),
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
  AutoDisposeFutureProviderElement<FormSubmissionsStatus> createElement() {
    return _FormSubmissionsStatusProviderElement(this);
  }

  FormSubmissionsStatusProvider _copyWith(
    FutureOr<FormSubmissionsStatus> Function(FormSubmissionsStatusRef ref)
        create,
  ) {
    return FormSubmissionsStatusProvider._internal(
      (ref) => create(ref as FormSubmissionsStatusRef),
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
    return other is FormSubmissionsStatusProvider && other.form == form;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, form.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FormSubmissionsStatusRef
    on AutoDisposeFutureProviderRef<FormSubmissionsStatus> {
  /// The parameter `form` of this provider.
  String get form;
}

class _FormSubmissionsStatusProviderElement
    extends AutoDisposeFutureProviderElement<FormSubmissionsStatus>
    with FormSubmissionsStatusRef {
  _FormSubmissionsStatusProviderElement(super.provider);

  @override
  String get form => (origin as FormSubmissionsStatusProvider).form;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
