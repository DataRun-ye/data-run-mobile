import 'package:datarunmobile/features/custom/exception_indicators/exception_indicator.dart';
import 'package:flutter/cupertino.dart';

/// Indicates that a connection error occurred.
class NoConnectionIndicator extends StatelessWidget {
  const NoConnectionIndicator({
    super.key,
    this.onTryAgain,
  });

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: 'No connection',
        message: 'Please check internet connection and try again.',
        assetName: 'assets/frustrated-face.png',
        onTryAgain: onTryAgain,
      );
}
