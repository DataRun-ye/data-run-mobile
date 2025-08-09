import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/features/data_instance/application/table.providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ActionFAB extends ConsumerWidget {
  const ActionFAB(
      {super.key,
      required this.onAddNew,
      required this.onDelete,
      required this.onBulkSync});

  final VoidCallback? onAddNew;
  final VoidCallback? onDelete;
  final VoidCallback? onBulkSync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final direction = Intl.getCurrentLocale() == 'ar'
        ? SpeedDialDirection.left
        : SpeedDialDirection.right;
    return Consumer(
      builder: (context, ref, child) {
        final selectedItems = ref.watch(selectedItemsProvider);
        final selectedFinalizedItemsAsync =
            ref.watch(selectedFinalizedItemProvider);
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (child, anim) {
            return ScaleTransition(
              scale: anim,
              child: child,
            );
          },
          child: selectedItems.isEmpty
              ? FloatingActionButton(
                  heroTag: 'add_speed-dial-hero-tag',
                  key: ValueKey('add'),
                  onPressed: onAddNew,
                  child: Icon(Icons.add),
                  backgroundColor: cs.primary,
                  elevation: 8.0,
                )
              : AsyncValueWidget(
                  loadingBuilder: () => const Center(
                    heightFactor: 3,
                    widthFactor: 3,
                    child: CircularProgressIndicator(),
                  ),
                  value: selectedFinalizedItemsAsync,
                  valueBuilder: (finalizedItems) {
                    return SpeedDial(
                      key: ValueKey('${finalizedItems.isNotEmpty}-speed-dial'),
                      isOpenOnStart: true,
                      closeDialOnPop: true,
                      heroTag: 'speed-dial-hero-tag',
                      animatedIcon: AnimatedIcons.menu_close,
                      overlayOpacity: 0.0,
                      backgroundColor: cs.error,
                      spacing: 3,
                      childPadding: const EdgeInsets.all(5),
                      spaceBetweenChildren: 4,
                      animationCurve: Curves.elasticInOut,
                      childMargin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      buttonSize: const Size(56.0, 56.0),
                      childrenButtonSize: const Size(56.0, 56.0),
                      direction: direction,
                      closeManually: true,
                      renderOverlay: false,
                      children: [
                        SpeedDialChild(
                          child: finalizedItems.isNotEmpty
                              ? const Icon(Icons.cloud_upload)
                              : const Icon(Icons.cloud_off),
                          backgroundColor: finalizedItems.isEmpty
                              ? Colors.grey
                              : Colors.green,
                          foregroundColor: Colors.white,
                          onTap: finalizedItems.isEmpty ? null : onBulkSync,
                        ),
                        SpeedDialChild(
                          child: const Icon(Icons.delete),
                          onTap: onDelete,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          onLongPress: onDelete,
                        ),
                      ],
                    );
                  },
                ),
        );
      },
    );
  }
}
