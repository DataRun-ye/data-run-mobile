import 'package:datarunmobile/features/custom/exception_indicators/exception_indicator.dart';
import 'package:flutter/cupertino.dart';

/// Indicates that an unknown error occurred.
class GenericErrorIndicator extends StatelessWidget {
  const GenericErrorIndicator({
    super.key,
    this.onTryAgain,
  });

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: 'Something went wrong',
        message: 'The application has encountered an unknown error.\n'
            'Please try again later.',
        assetName: 'assets/confused-face.png',
        onTryAgain: onTryAgain,
      );
}
