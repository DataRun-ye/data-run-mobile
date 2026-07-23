import 'package:datarunmobile/core/exception/failure_snapshot.dart';
import 'package:datarunmobile/core/sync/sync_summary_model.dart';

enum SubmissionUploadOutcome {
  nothingToUpload,
  complete,
  partial,
  rejected,
  requestFailure,
}

final class SubmissionUploadResult {
  const SubmissionUploadResult._({
    required this.outcome,
    required this.attemptedIds,
    required this.summary,
    required this.unresolvedIds,
    this.failure,
  });

  factory SubmissionUploadResult.nothingToUpload() {
    return SubmissionUploadResult._(
      outcome: SubmissionUploadOutcome.nothingToUpload,
      attemptedIds: const {},
      summary: ImportSummaryModel.empty(),
      unresolvedIds: const {},
    );
  }

  factory SubmissionUploadResult.fromSummary({
    required Iterable<String> attemptedIds,
    required ImportSummaryModel summary,
  }) {
    final attempted = Set<String>.unmodifiable(attemptedIds);
    final successful = {
      ...summary.created,
      ...summary.updated,
    }.intersection(attempted);
    final failed = summary.failed.keys.toSet().intersection(attempted);
    final unresolved = attempted.difference(successful).difference(failed);

    final outcome = successful.length == attempted.length
        ? SubmissionUploadOutcome.complete
        : successful.isNotEmpty
            ? SubmissionUploadOutcome.partial
            : SubmissionUploadOutcome.rejected;

    return SubmissionUploadResult._(
      outcome: outcome,
      attemptedIds: attempted,
      summary: summary,
      unresolvedIds: Set.unmodifiable(unresolved),
    );
  }

  factory SubmissionUploadResult.requestFailure({
    required Iterable<String> attemptedIds,
    required FailureSnapshot failure,
  }) {
    final attempted = Set<String>.unmodifiable(attemptedIds);
    return SubmissionUploadResult._(
      outcome: SubmissionUploadOutcome.requestFailure,
      attemptedIds: attempted,
      summary: ImportSummaryModel.empty(),
      unresolvedIds: attempted,
      failure: failure,
    );
  }

  final SubmissionUploadOutcome outcome;
  final Set<String> attemptedIds;
  final ImportSummaryModel summary;
  final Set<String> unresolvedIds;
  final FailureSnapshot? failure;
}
