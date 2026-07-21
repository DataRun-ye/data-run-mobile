// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_submission_update.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(systemMetadataSubmissions)
final systemMetadataSubmissionsProvider = SystemMetadataSubmissionsFamily._();

final class SystemMetadataSubmissionsProvider extends $FunctionalProvider<
        AsyncValue<List<MetadataSubmissionUpdate>>,
        List<MetadataSubmissionUpdate>,
        FutureOr<List<MetadataSubmissionUpdate>>>
    with
        $FutureModifier<List<MetadataSubmissionUpdate>>,
        $FutureProvider<List<MetadataSubmissionUpdate>> {
  SystemMetadataSubmissionsProvider._(
      {required SystemMetadataSubmissionsFamily super.from,
      required ({
        String query,
        String submissionId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'systemMetadataSubmissionsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$systemMetadataSubmissionsHash();

  @override
  String toString() {
    return r'systemMetadataSubmissionsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<MetadataSubmissionUpdate>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<MetadataSubmissionUpdate>> create(Ref ref) {
    final argument = this.argument as ({
      String query,
      String submissionId,
    });
    return systemMetadataSubmissions(
      ref,
      query: argument.query,
      submissionId: argument.submissionId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SystemMetadataSubmissionsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$systemMetadataSubmissionsHash() =>
    r'7147267cb9b872d08f33c67b5327c2920e1d3975';

final class SystemMetadataSubmissionsFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<List<MetadataSubmissionUpdate>>,
            ({
              String query,
              String submissionId,
            })> {
  SystemMetadataSubmissionsFamily._()
      : super(
          retry: null,
          name: r'systemMetadataSubmissionsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  SystemMetadataSubmissionsProvider call({
    required String query,
    required String submissionId,
  }) =>
      SystemMetadataSubmissionsProvider._(argument: (
        query: query,
        submissionId: submissionId,
      ), from: this);

  @override
  String toString() => r'systemMetadataSubmissionsProvider';
}
