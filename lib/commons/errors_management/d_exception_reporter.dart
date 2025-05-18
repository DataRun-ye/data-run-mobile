import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:datarunmobile/commons/errors_management/d_error_localization.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/features/dialog/application/dialog_service.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:intl/intl.dart';

class DExceptionReporter {
  DExceptionReporter._internal();

  static DExceptionReporter instance = DExceptionReporter._internal();
  final _dialogService = appLocator<DialogService>();

  void report(Object error, {bool showToUser = false}) {
    final message = ErrorMessage.getMessage(error);

    logException(DException(error.toString(), error));

    if (showToUser) {
      // _showUserAlert(message);
      _dialogService.showDialog(
        // variant: DialogType.infoAlert,
        title: Intl.message('error'),
        buttonTitle: S.current.ok,
        description: message,
      );

      // throw error;
    }
  }

// Future<void> _showUserAlert(String message) {
//   return showDialog(
//     context: navigatorKey.currentContext!,
//     builder: (context) => AlertDialog(
//       title: const Text('An Error Occurred'),
//       content: Text(message),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text(S.current.ok),
//         ),
//       ],
//     ),
//   );
// }
}
