// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_integrity_check_notifier.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FormIntegrityCheckNotifier)
final formIntegrityCheckProvider = FormIntegrityCheckNotifierProvider._();

final class FormIntegrityCheckNotifierProvider extends $NotifierProvider<
    FormIntegrityCheckNotifier, DataIntegrityCheckResult?> {
  FormIntegrityCheckNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'formIntegrityCheckProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$formIntegrityCheckNotifierHash();

  @$internal
  @override
  FormIntegrityCheckNotifier create() => FormIntegrityCheckNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DataIntegrityCheckResult? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DataIntegrityCheckResult?>(value),
    );
  }
}

String _$formIntegrityCheckNotifierHash() =>
    r'f38b35432e3e138feb96059d0f3ba547cf11f457';

abstract class _$FormIntegrityCheckNotifier
    extends $Notifier<DataIntegrityCheckResult?> {
  DataIntegrityCheckResult? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<DataIntegrityCheckResult?, DataIntegrityCheckResult?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DataIntegrityCheckResult?, DataIntegrityCheckResult?>,
        DataIntegrityCheckResult?,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
