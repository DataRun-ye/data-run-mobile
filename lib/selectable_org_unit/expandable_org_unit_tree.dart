import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A slick, reusable reactive form field for picking a single node from a TreeSliver.
class ReactiveTreePickerField<T> extends ReactiveFormField<T, T> {
  ReactiveTreePickerField({
    Key? key,
    required String formControlName,
    required this.nodes,
    this.controller,
    this.onNodeTap,
    this.searchHint = 'Search…',
    this.dialogTitle = 'Select Item',
    this.hintText,
    this.dialogHeight = 400,
  }) : super(
          key: key,
          formControlName: formControlName,
          builder: (field) {
            final state = field as _ReactiveTreePickerFieldState<T>;
            return InputDecorator(
              decoration: InputDecoration(
                hintText: hintText,
                errorText: field.errorText,
                suffixIcon: const Icon(Icons.arrow_drop_down),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              isEmpty: field.value == null,
              child: InkWell(
                onTap: state._openDialog,
                child: Text(
                  field.value?.toString() ?? '',
                  style: TextStyle(
                    color: field.value == null
                        ? Colors.grey.shade600
                        : Colors.black,
                  ),
                ),
              ),
            );
          },
        );

  /// Pre-built tree structure for display.
  final List<TreeSliverNode<T>> nodes;

  /// Optional controller to manage expand/collapse state.
  final TreeSliverController? controller;

  /// Callback when a selectable node is tapped.
  final ValueChanged<T>? onNodeTap;

  /// Placeholder text for the search field inside the dialog.
  final String searchHint;
  final String dialogTitle;
  final String? hintText;

  /// Initial height of the modal sheet.
  final double dialogHeight;

  @override
  ReactiveFormFieldState<T, T> createState() =>
      _ReactiveTreePickerFieldState<T>();
}

class _ReactiveTreePickerFieldState<T> extends ReactiveFormFieldState<T, T> {
  late final TreeSliverController _controller;

  @override
  void initState() {
    super.initState();
    _controller = (widget as ReactiveTreePickerField<T>).controller ??
        TreeSliverController();
  }

  Future<void> _openDialog() async {
    final picker = widget as ReactiveTreePickerField<T>;
    final result = await showModalBottomSheet<T>(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        builder: (c, scroll) {
          final theme = Theme.of(c);
          return Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(picker.dialogTitle,
                        style: Theme.of(c).textTheme.headlineMedium),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
              ),
              // Search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: picker.searchHint,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onChanged: (q) {
                    // TODO: implement filtering of nodes
                  },
                ),
              ),
              const SizedBox(height: 8),
              // TreeSliver
              Expanded(
                child: CustomScrollView(
                  controller: scroll,
                  slivers: [
                    TreeSliver<T>(
                      tree: picker.nodes,
                      controller: _controller,
                      treeNodeBuilder: (BuildContext context,
                          TreeSliverNode<Object?> node, AnimationStyle anim) {
                        final content = node.content as T;
                        final isActive = _controller.isActive(node);
                        final base = TreeSliver.defaultTreeNodeBuilder(
                            context, node, anim);
                        return GestureDetector(
                          onTap: () {
                            if (picker.onNodeTap != null) {
                              picker.onNodeTap!(content);
                            }
                            Navigator.of(ctx).pop(content);
                          },
                          child: DecoratedBox(
                            decoration: isActive
                                ? BoxDecoration(
                                    color:
                                        theme.chipTheme.secondarySelectedColor,
                                    borderRadius: BorderRadius.circular(4),
                                  )
                                : BoxDecoration(
                                    color: theme.colorScheme.surfaceContainer,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                            child: base,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    if (result != null) {
      control.value = result;
      control.markAsTouched();
    }
  }
}
