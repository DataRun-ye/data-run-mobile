import 'package:datarunmobile/commons/custom_widgets/exception_indicators/exception_indicator.dart';
import 'package:datarunmobile/generated/l10n.dart';
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
        title: S.of(context).noConnection,
        message: S.of(context).noConnectionMessage,
        // assetName: 'assets/app/offline.svg',
        onTryAgain: onTryAgain,
      );
}
