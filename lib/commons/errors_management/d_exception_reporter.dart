import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/commons/errors_management/d_error_localization.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

class DExceptionReporter {
  DExceptionReporter._internal();

  static DExceptionReporter instance = DExceptionReporter._internal();
  final _dialogService = appLocator<DialogService>();

  void report(Object error, {bool showToUser = false}) {
    final message = ErrorMessage.getMessage(error);

    logException(DException(error.toString(), error));

    if (showToUser) {
      _dialogService.showDialog(
        title: Intl.message('error'),
        buttonTitle: S.current.ok,
        description: message,
      );
    }
  }
}
