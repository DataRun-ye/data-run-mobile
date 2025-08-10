import 'package:datarunmobile/commons/custom_widgets/exception_indicators/exception_indicator.dart';
import 'package:datarunmobile/generated/l10n.dart';
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
        title: S.of(context).generalErrorTitle,
        message: '${S.of(context).generalErrorMessage}\n',
        // assetName: 'assets/app/confused-face.png',
        onTryAgain: onTryAgain,
      );
}
