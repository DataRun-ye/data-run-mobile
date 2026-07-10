// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(formListItems)
final formListItemsProvider = FormListItemsFamily._();

final class FormListItemsProvider extends $FunctionalProvider<
        AsyncValue<List<FormListItemModel>>,
        List<FormListItemModel>,
        FutureOr<List<FormListItemModel>>>
    with
        $FutureModifier<List<FormListItemModel>>,
        $FutureProvider<List<FormListItemModel>> {
  FormListItemsProvider._(
      {required FormListItemsFamily super.from,
      required FormListFilter super.argument})
      : super(
          retry: null,
          name: r'formListItemsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$formListItemsHash();

  @override
  String toString() {
    return r'formListItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<FormListItemModel>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<FormListItemModel>> create(Ref ref) {
    final argument = this.argument as FormListFilter;
    return formListItems(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FormListItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$formListItemsHash() => r'caefe3a46771712441487eec1c6c42aecee5cb28';

final class FormListItemsFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<FormListItemModel>>,
            FormListFilter> {
  FormListItemsFamily._()
      : super(
          retry: null,
          name: r'formListItemsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FormListItemsProvider call(
    FormListFilter filter,
  ) =>
      FormListItemsProvider._(argument: filter, from: this);

  @override
  String toString() => r'formListItemsProvider';
}

@ProviderFor(availableUserFormTemplates)
final availableUserFormTemplatesProvider = AvailableUserFormTemplatesFamily._();

final class AvailableUserFormTemplatesProvider extends $FunctionalProvider<
        AsyncValue<List<Pair<AssignmentForm, bool>>>,
        List<Pair<AssignmentForm, bool>>,
        FutureOr<List<Pair<AssignmentForm, bool>>>>
    with
        $FutureModifier<List<Pair<AssignmentForm, bool>>>,
        $FutureProvider<List<Pair<AssignmentForm, bool>>> {
  AvailableUserFormTemplatesProvider._(
      {required AvailableUserFormTemplatesFamily super.from,
      required String? super.argument})
      : super(
          retry: null,
          name: r'availableUserFormTemplatesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$availableUserFormTemplatesHash();

  @override
  String toString() {
    return r'availableUserFormTemplatesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Pair<AssignmentForm, bool>>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Pair<AssignmentForm, bool>>> create(Ref ref) {
    final argument = this.argument as String?;
    return availableUserFormTemplates(
      ref,
      assignmentId: argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AvailableUserFormTemplatesProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$availableUserFormTemplatesHash() =>
    r'dec7515c5cb3d95e5373a3762ceef19c64f434ea';

final class AvailableUserFormTemplatesFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<Pair<AssignmentForm, bool>>>,
            String?> {
  AvailableUserFormTemplatesFamily._()
      : super(
          retry: null,
          name: r'availableUserFormTemplatesProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AvailableUserFormTemplatesProvider call({
    String? assignmentId,
  }) =>
      AvailableUserFormTemplatesProvider._(argument: assignmentId, from: this);

  @override
  String toString() => r'availableUserFormTemplatesProvider';
}

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
