// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$formRepositoryHash() => r'bad59b19f4f202d6b4c5e8c06a3748526f5ea359';

/// See also [formRepository].
@ProviderFor(formRepository)
final formRepositoryProvider = AutoDisposeProvider<FormRepository>.internal(
  formRepository,
  name: r'formRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$formRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FormRepositoryRef = AutoDisposeProviderRef<FormRepository>;
String _$submissionFormFlatTemplateHash() =>
    r'0cd8a1df49affd581d325b1e909eb282c06ab8cd';

/// See also [submissionFormFlatTemplate].
@ProviderFor(submissionFormFlatTemplate)
final submissionFormFlatTemplateProvider =
    AutoDisposeProvider<FormFlatTemplate>.internal(
  submissionFormFlatTemplate,
  name: r'submissionFormFlatTemplateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$submissionFormFlatTemplateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SubmissionFormFlatTemplateRef
    = AutoDisposeProviderRef<FormFlatTemplate>;
String _$formNotifierHash() => r'cccfef5efde0463976657912490817fcb65cd16f';

/// See also [FormNotifier].
@ProviderFor(FormNotifier)
final formNotifierProvider =
    AutoDisposeAsyncNotifierProvider<FormNotifier, FormState>.internal(
  FormNotifier.new,
  name: r'formNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$formNotifierHash,
  dependencies: <ProviderOrFamily>[submissionFormFlatTemplateProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    submissionFormFlatTemplateProvider,
    ...?submissionFormFlatTemplateProvider.allTransitiveDependencies
  },
);

typedef _$FormNotifier = AutoDisposeAsyncNotifier<FormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
