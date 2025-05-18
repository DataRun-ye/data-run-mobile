import 'dart:async';

import 'package:datarunmobile/app_routes/app_routes.dart';
import 'package:datarunmobile/core/models/models.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/features/dialog/presentation/platform_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

typedef DialogBuilder = Widget Function(
  BuildContext context,
  DialogRequest<dynamic> request,
  void Function(DialogResponse<dynamic> response) completer,
);

/// A DialogService that uses the Get package to show dialogs from the business logic
@lazySingleton
class DialogService {
  Map<dynamic, DialogBuilder>? _dialogBuilders;
  AppRouter _appRouter = appLocator<AppRouter>();

  void registerCustomDialogBuilders(Map<dynamic, DialogBuilder> builders) {
    _dialogBuilders = {...?_dialogBuilders, ...builders};
  }

  Map<dynamic, DialogBuilder> _customDialogBuilders =
      Map<dynamic, DialogBuilder>();

  /// Shows a dialog to the user
  ///
  /// It will show a platform specific dialog by default. This can be changed by setting [dialogPlatform]
  Future<DialogResponse<dynamic>?> showDialog({
    String? title,
    String? description,
    String? cancelTitle,
    Color? cancelTitleColor,
    String buttonTitle = 'Ok',
    Color? buttonTitleColor,
    bool barrierDismissible = false,
    RouteSettings? routeSettings,
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    return _showDialog(
      title: title,
      description: description,
      cancelTitle: cancelTitle,
      cancelTitleColor: cancelTitleColor,
      buttonTitle: buttonTitle,
      buttonTitleColor: buttonTitleColor,
      barrierDismissible: barrierDismissible,
      routeSettings: routeSettings,
      navigatorKey: navigatorKey,
    );
  }

  Future<DialogResponse<dynamic>?> _showDialog({
    String? title,
    String? description,
    String? cancelTitle,
    Color? cancelTitleColor,
    String? buttonTitle,
    Color? buttonTitleColor,
    bool barrierDismissible = false,
    RouteSettings? routeSettings,
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    var isConfirmationDialog = cancelTitle != null;
    return appLocator<AppRouter>()
        .push<DialogResponse<dynamic>>(PlatformDialogRoute(
      key: const Key('dialog_view'),
      title: title,
      content: description,
      actions: <Widget>[
        if (isConfirmationDialog)
          PlatformButton(
            key: const Key('dialog_touchable_cancel'),
            textChildKey: const Key('dialog_text_cancelButtonText'),
            // dialogPlatform: dialogPlatform,
            text: cancelTitle,
            cancelBtnColor: cancelTitleColor,
            isCancelButton: true,
            onPressed: () {
              completeDialog(
                DialogResponse(
                  confirmed: false,
                ),
              );
            },
          ),
        PlatformButton(
          key: const Key('dialog_touchable_confirm'),
          textChildKey: const Key('dialog_text_confirmButtonText'),
          text: buttonTitle!,
          confirmationBtnColor: buttonTitleColor,
          onPressed: () {
            completeDialog(
              DialogResponse(
                confirmed: true,
              ),
            );
          },
        ),
      ],
    ));
  }

  /// Creates a popup with the given widget, a scale animation, and faded background.
  ///
  /// The first generic type argument will be the [DialogResponse]
  /// while the second generic type argument is the [DialogRequest]
  ///
  /// e.g.
  /// ```dart
  /// await _dialogService.showCustomDialog<GenericDialogResponse, GenericDialogRequest>();
  /// ```
  ///
  /// Where [GenericDialogResponse] is a defined model response,
  /// and [GenericDialogRequest] is the request model.
  Future<DialogResponse<T>?> showCustomDialog<T, R>({
    dynamic variant,
    String? title,
    String? description,
    bool hasImage = false,
    String? imageUrl,
    bool showIconInMainButton = false,
    String? mainButtonTitle,
    bool showIconInSecondaryButton = false,
    String? secondaryButtonTitle,
    bool showIconInAdditionalButton = false,
    String? additionalButtonTitle,
    bool takesInput = false,
    Color barrierColor = Colors.black54,
    bool barrierDismissible = false,
    String barrierLabel = '',
    bool useSafeArea = true,
    RouteSettings? routeSettings,
    GlobalKey<NavigatorState>? navigatorKey,
    RouteTransitionsBuilder? transitionBuilder,
    R? data,
  }) {
    assert(
      _dialogBuilders != null,
      'You have to call registerCustomDialogBuilder to use this function. Look at the custom dialog UI section in the stacked_services readme.',
    );

    final customDialogUI = _dialogBuilders![variant];

    assert(
      customDialogUI != null,
      'You have to call registerCustomDialogBuilder to use this function. Look at the custom dialog UI section in the stacked_services readme.',
    );

    return Get.generalDialog<DialogResponse<T>>(
      barrierColor: barrierColor,
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      routeSettings: routeSettings,
      navigatorKey: navigatorKey,
      transitionBuilder: transitionBuilder,
      pageBuilder: (BuildContext buildContext, _, __) {
        final child = Builder(
          key: useSafeArea ? null : const Key('dialog_view'),
          builder: (BuildContext context) => customDialogUI!(
            context,
            DialogRequest<R>(
              title: title,
              description: description,
              hasImage: hasImage,
              imageUrl: imageUrl,
              showIconInMainButton: showIconInMainButton,
              mainButtonTitle: mainButtonTitle,
              showIconInSecondaryButton: showIconInSecondaryButton,
              secondaryButtonTitle: secondaryButtonTitle,
              showIconInAdditionalButton: showIconInAdditionalButton,
              additionalButtonTitle: additionalButtonTitle,
              takesInput: takesInput,
              data: data,
              variant: variant,
            ),
            completeDialog,
          ),
        );
        if (!useSafeArea) return child;
        return SafeArea(key: const Key('dialog_view'), child: child);
      },
    );
  }

  /// Shows a confirmation dialog with title and description
  Future<DialogResponse<dynamic>?> showConfirmationDialog({
    String? title,
    String? description,
    String cancelTitle = 'Cancel',
    Color? cancelTitleColor,
    String confirmationTitle = 'Ok',
    Color? confirmationTitleColor,
    bool barrierDismissible = false,
    RouteSettings? routeSettings,
  }) =>
      showDialog(
          title: title,
          description: description,
          buttonTitle: confirmationTitle,
          buttonTitleColor: confirmationTitleColor,
          cancelTitle: cancelTitle,
          cancelTitleColor: cancelTitleColor,
          barrierDismissible: barrierDismissible,
          routeSettings: routeSettings);

  /// Completes the dialog and passes the [response] to the caller
  void completeDialog(DialogResponse<dynamic> response) {
    _appRouter.pop(response);
  }
}
