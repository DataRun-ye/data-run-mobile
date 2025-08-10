import 'package:datarunmobile/commons/custom_widgets/exception_indicators/exception_indicator.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

/// Indicates that no items were found.
class EmptyListIndicator extends StatelessWidget {
  const EmptyListIndicator({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: S.of(context).noItemsFound,
        message:
            'We couldn\'t find any results${message != null ? ': $message' : ''}',
        // assetName: 'assets/empty-box.png',
      );
}
