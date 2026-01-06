import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/form_option.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_chip_option.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_choice_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QReactiveSingleSelectField extends ConsumerWidget {
  QReactiveSingleSelectField({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = appLocator<FormInstance>();
    final theme = Theme.of(context);
    final chipTheme = theme.chipTheme;
    // 1. Find the longest label string
    final String longestLabel = element.visibleOption.isNotEmpty
        ? element.visibleOption
            .map((o) => getItemLocalString(o.label))
            .reduce((a, b) => a.length > b.length ? a : b)
        : '';
    // 2. Measure the width of the longest label using TextPainter
    final textPainter = TextPainter(
      text: TextSpan(
        text: longestLabel,
        style: chipTheme.labelStyle ?? theme.textTheme.bodyLarge,
      ),
      textDirection: Directionality.of(context),
    )..layout();
    final double labelPadding = chipTheme.labelPadding?.horizontal ?? 0.0;
    final double chipPadding = chipTheme.padding?.horizontal ?? 0.0;
    final double consistentWidth =
        textPainter.width + labelPadding + chipPadding;

    // If the calculated width is too small, provide a minimum
    const double minWidth = 100.0;
    final double finalWidth =
        consistentWidth > minWidth ? consistentWidth : minWidth;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final spacing = 4.0;
        int chipsPerRow = 1;
        for (int i = 1; i <= element.visibleOption.length; i++) {
          final totalSpacingWidth = (i - 1) * spacing;
          final availableWidth = constraints.maxWidth - totalSpacingWidth;
          final calculatedChipWidth = availableWidth / i;

          // Check if the calculated width is sufficient for the longest label
          if (calculatedChipWidth >= consistentWidth) {
            chipsPerRow = i;
          } else {
            // We've found the max number of chips per row that works
            break;
          }
        }

        final double chipWidth =
            (constraints.maxWidth - (chipsPerRow - 1) * spacing) /
                chipsPerRow;


        return ReactiveChoiceChips<String>(
          visualDensity: VisualDensity.compact,
          elevation: 2,
          pressElevation: 2,
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.start,
          formControl: formInstance.form.control(element.elementPath!)
              as FormControl<String>,
          confirmChangingValue: element.dependents.length > 0,
          validationMessages: validationMessages(),
          options: _getChipOptions(element.visibleOption, chipWidth),
          decoration: InputDecoration(
            enabled: element.elementControl.enabled,
            labelText: element.label,
          ),
        );
      }
    );
  }

  List<ReactiveChipOption<String>> _getChipOptions(
      List<FormOption> options, double consistentWidth) {
    return options
        .map((FormOption option) => ReactiveChipOption<String>(
              value: option.code,
              child: SizedBox(
                width: consistentWidth - 20, // Use the calculated consistent width
                child: Text(
                  getItemLocalString(option.label),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ))
        .toList();
  }
}
