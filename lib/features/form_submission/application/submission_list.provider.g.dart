// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_list.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(formSubmissionRepository)
final formSubmissionRepositoryProvider = FormSubmissionRepositoryProvider._();

final class FormSubmissionRepositoryProvider extends $FunctionalProvider<
    FormSubmissionRepository,
    FormSubmissionRepository,
    FormSubmissionRepository> with $Provider<FormSubmissionRepository> {
  FormSubmissionRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'formSubmissionRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$formSubmissionRepositoryHash();

  @$internal
  @override
  $ProviderElement<FormSubmissionRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FormSubmissionRepository create(Ref ref) {
    return formSubmissionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FormSubmissionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FormSubmissionRepository>(value),
    );
  }
}

String _$formSubmissionRepositoryHash() =>
    r'563d892c0f3b7f12559b16c0c0e04ed616934624';

@ProviderFor(FormSubmissions)
final formSubmissionsProvider = FormSubmissionsFamily._();

final class FormSubmissionsProvider
    extends $AsyncNotifierProvider<FormSubmissions, IList<DataInstance>> {
  FormSubmissionsProvider._(
      {required FormSubmissionsFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'formSubmissionsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$formSubmissionsHash();

  @override
  String toString() {
    return r'formSubmissionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FormSubmissions create() => FormSubmissions();

  @override
  bool operator ==(Object other) {
    return other is FormSubmissionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$formSubmissionsHash() => r'a7e0cddd7442048939cddb3dc3f2fe0471af98c5';

final class FormSubmissionsFamily extends $Family
    with
        $ClassFamilyOverride<FormSubmissions, AsyncValue<IList<DataInstance>>,
            IList<DataInstance>, FutureOr<IList<DataInstance>>, String> {
  FormSubmissionsFamily._()
      : super(
          retry: null,
          name: r'formSubmissionsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FormSubmissionsProvider call(
    String form,
  ) =>
      FormSubmissionsProvider._(argument: form, from: this);

  @override
  String toString() => r'formSubmissionsProvider';
}

abstract class _$FormSubmissions extends $AsyncNotifier<IList<DataInstance>> {
  late final _$args = ref.$arg as String;
  String get form => _$args;

  FutureOr<IList<DataInstance>> build(
    String form,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<IList<DataInstance>>, IList<DataInstance>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<IList<DataInstance>>, IList<DataInstance>>,
        AsyncValue<IList<DataInstance>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

@ProviderFor(dataInstance)
final dataInstanceProvider = DataInstanceFamily._();

final class DataInstanceProvider extends $FunctionalProvider<
        AsyncValue<DataInstance>, DataInstance, FutureOr<DataInstance>>
    with $FutureModifier<DataInstance>, $FutureProvider<DataInstance> {
  DataInstanceProvider._(
      {required DataInstanceFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'dataInstanceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dataInstanceHash();

  @override
  String toString() {
    return r'dataInstanceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<DataInstance> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<DataInstance> create(Ref ref) {
    final argument = this.argument as String;
    return dataInstance(
      ref,
      id: argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DataInstanceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dataInstanceHash() => r'70a423b295b3df9f3128fded4d9db234ff8146fd';

final class DataInstanceFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<DataInstance>, String> {
  DataInstanceFamily._()
      : super(
          retry: null,
          name: r'dataInstanceProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  DataInstanceProvider call({
    required String id,
  }) =>
      DataInstanceProvider._(argument: id, from: this);

  @override
  String toString() => r'dataInstanceProvider';
}

@ProviderFor(submissionEditStatus)
final submissionEditStatusProvider = SubmissionEditStatusFamily._();

final class SubmissionEditStatusProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  SubmissionEditStatusProvider._(
      {required SubmissionEditStatusFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'submissionEditStatusProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$submissionEditStatusHash();

  @override
  String toString() {
    return r'submissionEditStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as String;
    return submissionEditStatus(
      ref,
      submissionId: argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SubmissionEditStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$submissionEditStatusHash() =>
    r'02d9349aaea6e5b425324fcafea9817097b43533';

final class SubmissionEditStatusFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, String> {
  SubmissionEditStatusFamily._()
      : super(
          retry: null,
          name: r'submissionEditStatusProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  SubmissionEditStatusProvider call({
    required String submissionId,
  }) =>
      SubmissionEditStatusProvider._(argument: submissionId, from: this);

  @override
  String toString() => r'submissionEditStatusProvider';
}
