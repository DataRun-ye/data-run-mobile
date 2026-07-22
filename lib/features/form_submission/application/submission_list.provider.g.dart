// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_list.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
