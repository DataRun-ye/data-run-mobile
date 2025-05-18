import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/utilities/date_helper.dart';
import 'package:datarunmobile/data/form_instance.provider.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QDatePickerField<T> extends ConsumerWidget {
  const QDatePickerField({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;
    formInstance.form.control(element.elementPath!) as FormControl<T>;
    return ReactiveTextField<String>(
      // formControl: element.elementControl,
      formControl: formInstance.form.control(element.elementPath!)
          as FormControl<String>,
      readOnly: true,
      valueAccessor: QDateTimeValueAccessor(),
      decoration: InputDecoration(
        enabled: element.elementControl.enabled,
        labelText: element.label,
        suffixIcon: ReactiveDatePicker<String?>(
          formControl: element.elementControl as FormControl<String?>,
          firstDate: DateTime(2015, 1, 1),
          lastDate: DateTime(2040, 1, 1),
          builder: (context, picker, child) {
            return IconButton(
              onPressed:
                  element.elementControl.enabled ? picker.showPicker : null,
              icon: const Icon(Icons.date_range),
            );
          },
        ),
      ),
    );
  }
}

class QDateTimeValueAccessor<T> extends ControlValueAccessor<String, String> {
  /// Returns the value that must be supplied to the [control].
  ///
  /// Converts value from UI data type to [control] data type.
  @override
  String? modelToViewValue(String? modelValue) {
    if (modelValue == null) {
      return null;
    }

    String? value;
    try {
      // to local formated for the ui
      value = DateHelper.fromDbUtcToUiLocalFormat(modelValue);
    } on FormatException catch (e) {
      logError('Date format Exception, date: $modelValue, $e');
    }

    // return modelValue == null ? null : sdk.DDateUtils.format(modelValue);
    return value;
  }

  /// Returns the value that must be supplied to the UI widget.
  ///
  /// Converts value from [control] data type to UI data type.
  @override
  String? viewToModelValue(String? viewValue) {
    // if picked value is not null convert from local to utc string for db
    return viewValue != null
        ? DateHelper.fromUiLocalToDbUtcFormat(viewValue)
        : viewValue;
  }
}
