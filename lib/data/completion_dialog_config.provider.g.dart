// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_dialog_config.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$formCompletionBottomSheetHash() =>
    r'95f80c3b92417c94a45fd1127666b2f9de585eb7';

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

/// See also [formCompletionBottomSheet].
@ProviderFor(formCompletionBottomSheet)
const formCompletionBottomSheetProvider = FormCompletionBottomSheetFamily();

/// See also [formCompletionBottomSheet].
class FormCompletionBottomSheetFamily extends Family<FormCompletionDialog> {
  /// See also [formCompletionBottomSheet].
  const FormCompletionBottomSheetFamily();

  /// See also [formCompletionBottomSheet].
  FormCompletionBottomSheetProvider call({
    required FormMetadata formMetadata,
  }) {
    return FormCompletionBottomSheetProvider(
      formMetadata: formMetadata,
    );
  }

  @override
  FormCompletionBottomSheetProvider getProviderOverride(
    covariant FormCompletionBottomSheetProvider provider,
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
  String? get name => r'formCompletionBottomSheetProvider';
}

/// See also [formCompletionBottomSheet].
class FormCompletionBottomSheetProvider
    extends AutoDisposeProvider<FormCompletionDialog> {
  /// See also [formCompletionBottomSheet].
  FormCompletionBottomSheetProvider({
    required FormMetadata formMetadata,
  }) : this._internal(
          (ref) => formCompletionBottomSheet(
            ref as FormCompletionBottomSheetRef,
            formMetadata: formMetadata,
          ),
          from: formCompletionBottomSheetProvider,
          name: r'formCompletionBottomSheetProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$formCompletionBottomSheetHash,
          dependencies: FormCompletionBottomSheetFamily._dependencies,
          allTransitiveDependencies:
              FormCompletionBottomSheetFamily._allTransitiveDependencies,
          formMetadata: formMetadata,
        );

  FormCompletionBottomSheetProvider._internal(
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
    FormCompletionDialog Function(FormCompletionBottomSheetRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FormCompletionBottomSheetProvider._internal(
        (ref) => create(ref as FormCompletionBottomSheetRef),
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
  AutoDisposeProviderElement<FormCompletionDialog> createElement() {
    return _FormCompletionBottomSheetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormCompletionBottomSheetProvider &&
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
mixin FormCompletionBottomSheetRef
    on AutoDisposeProviderRef<FormCompletionDialog> {
  /// The parameter `formMetadata` of this provider.
  FormMetadata get formMetadata;
}

class _FormCompletionBottomSheetProviderElement
    extends AutoDisposeProviderElement<FormCompletionDialog>
    with FormCompletionBottomSheetRef {
  _FormCompletionBottomSheetProviderElement(super.provider);

  @override
  FormMetadata get formMetadata =>
      (origin as FormCompletionBottomSheetProvider).formMetadata;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
