import 'package:datarunmobile/core/exception/d_exception.dart';
import 'package:datarunmobile/core/exception/d_error.dart';
import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/commons/errors_management/d_error_localization.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:stacked_services/stacked_services.dart';

class DExceptionReporter {
  DExceptionReporter._internal();

  static DExceptionReporter instance = DExceptionReporter._internal();

  DialogService get _dialogService => appLocator<DialogService>();

  void report(
    Object error, {
    StackTrace? stackTrace,
    bool showToUser = false,
  }) {
    final message = ErrorMessage.getMessage(error);

    logException(
      DException(error.toString(), error),
      stackTrace: stackTrace,
    );

    final shouldShow = error is! DError || error.shouldShowMessage;
    if (showToUser && shouldShow) {
      _dialogService.showDialog(
        title: S.current.error,
        buttonTitle: S.current.ok,
        description: message,
      );
    }
  }
}
