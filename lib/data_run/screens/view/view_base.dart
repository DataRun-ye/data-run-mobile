import 'package:datarunmobile/data_run/screens/view/view_abstract.dart';

/// any screen ActivityGlobalAbstract
mixin ViewBase implements ViewAbstract {
  // final PinDialog pinDialog;
  void onCreate() {}

  @override
  void back() {}

  @override
  void displayMessage(String? message) {
    // if (message != null) {
    //   showToast(message);
    // }
  }

  @override
  void hideKeyboard() {}

  @override
  void setTutorial() {}

  @override
  Future<void> showDescription(String description) async {
    // final localization = AppLocalization.of(context)!;
    // return Get.defaultDialog(
    //   radius: 10,
    //   // title: localization.lookup('description'),
    //   title: 'description',
    //   content: SingleChildScrollView(
    //     child: Text(description),
    //   ),
    //   // textCancel: localization.lookup('close'),
    //   textCancel: 'close',
    //   onCancel: () {
    //     Get.back();
    //   },
    // );

    // return showDialog<String>(
    //     context: navigatorKey.currentContext!,
    //     builder: (BuildContext context) => Dialog(
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: <Widget>[
    //                 Text(description),
    //                 const SizedBox(height: 15),
    //                 TextButton(
    //                   onPressed: () {
    //                     Navigator.pop(context);
    //                   },
    //                   child: Text(AppLocalization.of(context)!.lookup('close')),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ));
  }

  @override
  Future<void> showInfoDialog(
      {required String title,
      String? prefix,
      required String message,
      String? positiveButtonText,
      String? negativeButtonText,
      void Function()? onPositiveClick,
      void Function()? onNegativeClick}) async {
    // return Get.defaultDialog(
    //   title: title,
    //   content: CopyToClipboard(
    //     prefix: prefix,
    //     value: message,
    //     child: SingleChildScrollView(
    //       child: Text(message),
    //     ),
    //   ),
    //   textConfirm: positiveButtonText ?? L('ok'),
    //   textCancel: negativeButtonText ?? L('cancel'),
    //   onConfirm: () {
    //     positiveButtonText != null ? onPositiveClick?.call() : Get.back();
    //   },
    //   onCancel: () {
    //     negativeButtonText != null ? onNegativeClick?.call() : Get.back();
    //   },
    // );
    // return showDialog<void>(
    //   context: navigatorKey.currentContext!,
    //   // barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text(title),
    //       scrollable: true,
    //       content: CopyToClipboard(
    //         prefix: prefix,
    //         value: message,
    //         child: Text(message),
    //       ),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text(positiveButtonText ?? localization.lookup('ok')),
    //           onPressed: () {
    //             positiveButtonText != null
    //                 ? onPositiveClick?.call()
    //                 : Navigator.of(context).pop();
    //           },
    //         ),
    //         TextButton(
    //           child: Text(negativeButtonText ?? localization.lookup('cancel')),
    //           onPressed: () {
    //             negativeButtonText != null
    //                 ? onNegativeClick?.call()
    //                 : Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  // @override
  // Future<void> showInfoDialogWithoutActions(String title, String message) {
  //   final localization = AppLocalization.of(navigatorKey.currentContext!)!;
  //   return showDialog<void>(
  //     context: navigatorKey.currentContext!,
  //     // barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         scrollable: true,
  //         content: Text(message),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text(localization.lookup('ok')),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text(localization.lookup('cancel')),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void showTutorial(bool shaked) {}

  @override
  Future<void> showSyncDialog<T>([T? uid]) {
    return Future.value();
  }
}
