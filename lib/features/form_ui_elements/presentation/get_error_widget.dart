import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:datarunmobile/commons/custom_widgets/exception_indicators/exception_indicator.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';

Widget getErrorWidget(Object? error, StackTrace? stackTrace) {
  logError('error: $error');
  debugPrintStack(stackTrace: stackTrace, label: error.toString());
  final message =
      error != null ? error.toString() : S.current.generalErrorMessage;
  return Center(
      child: ExceptionIndicator(
    title: S.current.generalErrorTitle,
    message: '${message}\n',
    assetName: 'assets/app/confused-face.svg',
  ));
}

Widget getErrorWidget2(Object? error, StackTrace? stackTrace) {
  logError('error: $error');
  debugPrintStack(stackTrace: stackTrace, label: error.toString());
  final message =
      error != null ? error.toString() : S.current.generalErrorMessage;
  return Center(
      child: ExceptionIndicator(
    title: S.current.generalErrorTitle,
    message: '${message}\n',
    assetName: 'assets/app/confused-face.png',
  ));
}
