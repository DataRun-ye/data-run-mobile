import 'package:datarunmobile/commons/errors_management/d_error_localization.dart';
import 'package:datarunmobile/core/exception/failure_snapshot.dart';
import 'package:datarunmobile/generated/l10n.dart';

String submissionSyncFailureMessage(String? storedFailure) {
  final failure = FailureSnapshot.tryDecode(storedFailure);
  return failure == null
      ? S.current.syncFailed
      : ErrorMessage.getMessage(failure);
}
