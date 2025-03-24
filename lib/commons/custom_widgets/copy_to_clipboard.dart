import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyToClipboard extends StatelessWidget {
  const CopyToClipboard({
    super.key,
    required this.value,
    this.child,
    this.onLongPress,
    this.prefix,
  });

  final Widget? child;
  final String? value;
  final Function()? onLongPress;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    if ((value ?? '').isEmpty) {
      return const SizedBox();
    }

    final Widget widget = child ??
        Text(
          prefix != null ? '$prefix: $value' : value!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );

    void onTap() => _onTap(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget,
        IconButton(
          onPressed: onTap,
          icon: const Icon(Icons.copy),
          tooltip: S.of(context).copyToClipboard,
        )
      ],
    );
  }

  void _onTap(BuildContext context) {
    Clipboard.setData(ClipboardData(text: value ?? ''));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(S.of(context).copiedToClipboard(value ?? '')),
    ));
  }
}
