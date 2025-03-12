import 'package:flutter/material.dart';

class ImprovedExpansionTile extends StatelessWidget {
  ImprovedExpansionTile(
      {super.key,
      this.title,
      this.titleWidget,
      required this.child,
      this.enabled = true,
      this.children = const <Widget>[],
      this.initiallyExpanded = false,
      this.onExpansionChanged,
      this.maintainState = false,
      this.leading});

  final String? title;
  final Widget? titleWidget;
  final bool enabled;
  final Widget child;
  final ValueChanged<bool>? onExpansionChanged;
  final bool initiallyExpanded;
  final bool maintainState;
  final Widget? leading;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      shadowColor: Theme.of(context).colorScheme.shadow,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(12),
      // ),
      child: ExpansionTile(
        leading: leading,
        enableFeedback: true,
        maintainState: maintainState,
        enabled: enabled,
        onExpansionChanged: onExpansionChanged,
        initiallyExpanded: initiallyExpanded,
        tilePadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        title: titleWidget != null
            ? titleWidget!
            : Text(
                title ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: !isDarkMode ? Colors.amber[900] : null,
                ),
              ),
        // backgroundColor: !isDarkMode ? Colors.blue.shade50 : null,
        trailing: AnimatedRotation(
          turns: initiallyExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 100),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.amber[900],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ],
      ),
    );
  }
}
