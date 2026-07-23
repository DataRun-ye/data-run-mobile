// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// form id could be on the format of formId-version or formId
/// look for the latest version of the form template or the form template
/// that matches the version

@ProviderFor(formTemplate)
final formTemplateProvider = FormTemplateFamily._();

/// form id could be on the format of formId-version or formId
/// look for the latest version of the form template or the form template
/// that matches the version

final class FormTemplateProvider extends $FunctionalProvider<
        AsyncValue<FormTemplateModel>,
        FormTemplateModel,
        FutureOr<FormTemplateModel>>
    with
        $FutureModifier<FormTemplateModel>,
        $FutureProvider<FormTemplateModel> {
  /// form id could be on the format of formId-version or formId
  /// look for the latest version of the form template or the form template
  /// that matches the version
  FormTemplateProvider._(
      {required FormTemplateFamily super.from,
      required ({
        String? formId,
        String? versionId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'formTemplateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$formTemplateHash();

  @override
  String toString() {
    return r'formTemplateProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<FormTemplateModel> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<FormTemplateModel> create(Ref ref) {
    final argument = this.argument as ({
      String? formId,
      String? versionId,
    });
    return formTemplate(
      ref,
      formId: argument.formId,
      versionId: argument.versionId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FormTemplateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$formTemplateHash() => r'976dd3516dba95565f2b714c7b543a8cec6fcb17';

/// form id could be on the format of formId-version or formId
/// look for the latest version of the form template or the form template
/// that matches the version

final class FormTemplateFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<FormTemplateModel>,
            ({
              String? formId,
              String? versionId,
            })> {
  FormTemplateFamily._()
      : super(
          retry: null,
          name: r'formTemplateProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// form id could be on the format of formId-version or formId
  /// look for the latest version of the form template or the form template
  /// that matches the version

  FormTemplateProvider call({
    String? formId,
    String? versionId,
  }) =>
      FormTemplateProvider._(argument: (
        formId: formId,
        versionId: versionId,
      ), from: this);

  @override
  String toString() => r'formTemplateProvider';
}
