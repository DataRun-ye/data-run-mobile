import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:datarunmobile/data_run/screens/form/field_widgets/custom_reactive_widget/age/age_field.widget.dart';
import 'package:datarunmobile/data_run/screens/form/field_widgets/custom_reactive_widget/age/age_value.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ReactiveDobBuilder = String Function(AgeValue ageValue);

class ReactiveAgeField extends ReactiveFormField<String, AgeValue> {
  ReactiveAgeField({
    super.key,
    required String label,
    bool enabled = true,
    DateTime? referenceDate,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    bool displayDob = false,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.formControlName,
    super.formControl,
    ReactiveDobBuilder? dobBuilder,
    bool autofocus = false,
    super.focusNode,
    ReactiveFormFieldCallback<String>? onChanged,
  }) : super(builder: (ReactiveFormFieldState<String, AgeValue> field) {
          final state = field;
          final effectiveDecoration = decoration
              .applyDefaults(Theme.of(state.context).inputDecorationTheme);
          final initValue = state.value;

          return InputDecorator(
            decoration: effectiveDecoration.copyWith(
                errorText: state.errorText, enabled: state.control.enabled),
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (displayDob)
                    Text(initValue != null
                        ? DateHelper.formatForUi(initValue.dateOfBirth)
                        : ''),
                  const SizedBox(width: 4),
                  AgeFieldWidget(
                      label: label,
                      readOnly: readOnly,
                      enabled: enabled,
                      referenceDate: referenceDate,
                      initialValue: initValue != null
                          ? AgeValue(dateOfBirth: initValue.dateOfBirth)
                          : AgeValue(dateOfBirth: DateTime.now()),
                      onChanged: enabled && field.control.enabled && !readOnly
                          ? (value) {
                              field.didChange(value);
                              onChanged?.call(field.control);
                            }
                          : null)
                ],
              ),
            ),
          );
        });

  @override
  ReactiveFormFieldState<String, AgeValue> createState() =>
      ReactiveFormFieldState<String, AgeValue>();
}
