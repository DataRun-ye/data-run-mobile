// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$formVersionAsyncHash() => r'6380fa983f0b3bbef3f2a269359dbf1b8f844a9c';

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

/// See also [formVersionAsync].
@ProviderFor(formVersionAsync)
const formVersionAsyncProvider = FormVersionAsyncFamily();

/// See also [formVersionAsync].
class FormVersionAsyncFamily extends Family {
  /// See also [formVersionAsync].
  const FormVersionAsyncFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'formVersionAsyncProvider';

  /// See also [formVersionAsync].
  FormVersionAsyncProvider call({
    required String form,
    required int version,
  }) {
    return FormVersionAsyncProvider(
      form: form,
      version: version,
    );
  }

  @visibleForOverriding
  @override
  FormVersionAsyncProvider getProviderOverride(
    covariant FormVersionAsyncProvider provider,
  ) {
    return call(
      form: provider.form,
      version: provider.version,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<FormVersion> Function(FormVersionAsyncRef ref) create) {
    return _$FormVersionAsyncFamilyOverride(this, create);
  }
}

class _$FormVersionAsyncFamilyOverride implements FamilyOverride {
  _$FormVersionAsyncFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<FormVersion> Function(FormVersionAsyncRef ref) create;

  @override
  final FormVersionAsyncFamily overriddenFamily;

  @override
  FormVersionAsyncProvider getProviderOverride(
    covariant FormVersionAsyncProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [formVersionAsync].
class FormVersionAsyncProvider extends AutoDisposeFutureProvider<FormVersion> {
  /// See also [formVersionAsync].
  FormVersionAsyncProvider({
    required String form,
    required int version,
  }) : this._internal(
          (ref) => formVersionAsync(
            ref as FormVersionAsyncRef,
            form: form,
            version: version,
          ),
          from: formVersionAsyncProvider,
          name: r'formVersionAsyncProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$formVersionAsyncHash,
          dependencies: FormVersionAsyncFamily._dependencies,
          allTransitiveDependencies:
              FormVersionAsyncFamily._allTransitiveDependencies,
          form: form,
          version: version,
        );

  FormVersionAsyncProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.form,
    required this.version,
  }) : super.internal();

  final String form;
  final int version;

  @override
  Override overrideWith(
    FutureOr<FormVersion> Function(FormVersionAsyncRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FormVersionAsyncProvider._internal(
        (ref) => create(ref as FormVersionAsyncRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        form: form,
        version: version,
      ),
    );
  }

  @override
  ({
    String form,
    int version,
  }) get argument {
    return (
      form: form,
      version: version,
    );
  }

  @override
  AutoDisposeFutureProviderElement<FormVersion> createElement() {
    return _FormVersionAsyncProviderElement(this);
  }

  FormVersionAsyncProvider _copyWith(
    FutureOr<FormVersion> Function(FormVersionAsyncRef ref) create,
  ) {
    return FormVersionAsyncProvider._internal(
      (ref) => create(ref as FormVersionAsyncRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      form: form,
      version: version,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FormVersionAsyncProvider &&
        other.form == form &&
        other.version == version;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, form.hashCode);
    hash = _SystemHash.combine(hash, version.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FormVersionAsyncRef on AutoDisposeFutureProviderRef<FormVersion> {
  /// The parameter `form` of this provider.
  String get form;

  /// The parameter `version` of this provider.
  int get version;
}

class _FormVersionAsyncProviderElement
    extends AutoDisposeFutureProviderElement<FormVersion>
    with FormVersionAsyncRef {
  _FormVersionAsyncProviderElement(super.provider);

  @override
  String get form => (origin as FormVersionAsyncProvider).form;
  @override
  int get version => (origin as FormVersionAsyncProvider).version;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
