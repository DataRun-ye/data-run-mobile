import 'dart:io';

import 'package:datarunmobile/commons/custom_widgets/exception_indicators/generic_error_indicator.dart';
import 'package:datarunmobile/commons/custom_widgets/exception_indicators/no_connection_indicator.dart';
import 'package:flutter/material.dart';

/// Based on the received error, displays either a [NoConnectionIndicator] or
/// a [GenericErrorIndicator].
class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    required this.error,
    this.onTryAgain,
    super.key,
  });

  final dynamic error;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => error is SocketException
      ? NoConnectionIndicator(
          onTryAgain: onTryAgain,
        )
      : GenericErrorIndicator(
          onTryAgain: onTryAgain,
        );
}
