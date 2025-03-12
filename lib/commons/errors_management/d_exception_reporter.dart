import 'package:d2_remote/core/datarun/exception/exception.dart';
import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:datarunmobile/app/app.dialogs.dart';
import 'package:datarunmobile/app/app.locator.dart';
import 'package:datarunmobile/commons/errors_management/d_error_localization.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

class DExceptionReporter {
  DExceptionReporter._internal();

  static DExceptionReporter instance = DExceptionReporter._internal();
  final _dialogService = locator<DialogService>();
  void report(Object? error, {bool showToUser = false}) {
    final message = ErrorMessage.getMessage(error);

    logException(DException(error.toString(), error));

    if (showToUser) {
      // _showUserAlert(message);
      _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: Intl.message('error'),
        description: message,
      );
    }
  }

// Future<void> _showUserAlert(String message) {
//   return showDialog(
//     context: navigatorKey.currentContext!,
//     builder: (context) => AlertDialog(
//       title: Text('An Error Occurred'),
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
