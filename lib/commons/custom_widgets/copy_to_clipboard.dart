import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyToClipboard extends StatelessWidget {
  const CopyToClipboard({
    super.key,
    required this.value,
    this.children = const [],
    this.onLongPress,
    this.prefix,
  });

  final List<Widget> children;
  final String? value;
  final Function()? onLongPress;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    if ((value ?? '').isEmpty) {
      return const SizedBox();
    }

    if (children.isEmpty) {
      children.add(Text(
        prefix != null ? '$prefix: $value' : value!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ));
    }

    void onTap() => _onTap(context);

    return OverflowBar(
      spacing: 8,
      overflowSpacing: 4,
      children: [
        ...children,
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
