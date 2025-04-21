import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/features/custom/presentation/info_alert/info_alert_dialog.dart';
import 'package:datarunmobile/features/dialog/application/dialog_service.dart';

enum DialogType {
  infoAlert,
}

void setupDialogUi() {
  final dialogService = appLocator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
