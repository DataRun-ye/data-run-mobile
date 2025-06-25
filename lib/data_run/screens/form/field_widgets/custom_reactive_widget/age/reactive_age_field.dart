import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:datarunmobile/data_run/screens/form/field_widgets/custom_reactive_widget/age/age_field.widget.dart';
import 'package:datarunmobile/data_run/screens/form/field_widgets/custom_reactive_widget/age/age_value.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ReactiveDobBuilder = String Function(AgeValue ageValue);

class ReactiveAgeField extends ReactiveFormField<String, String> {
  ReactiveAgeField({
    super.key,
    required String label,
    bool enabled = true,
    required DateTime referenceDate,
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
  }) : super(builder: (ReactiveFormFieldState<String, String> field) {
          final state = field;
          final effectiveDecoration = decoration
              .applyDefaults(Theme.of(state.context).inputDecorationTheme);
          final value = state.value != null
              ? DateTime.parse(state.value!).toLocal()
              : DateTime.now();
          final initValue = AgeValue(dateOfBirth: value);

          return InputDecorator(
            decoration: effectiveDecoration.copyWith(
                errorText: state.errorText, enabled: state.control.enabled),
            child: Column(
              children: [
                if (displayDob) ...[
                  const SizedBox(width: 8),
                  Text(
                    '${S.current.dateOfBirth}: ${DateFormat.yMMMd().format(initValue.dateOfBirth)}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 12),
                ],
                // what the user changes read only date of birth
                AgeFieldWidget(
                    label: label,
                    readOnly: readOnly,
                    enabled: enabled,
                    referenceDate: referenceDate,
                    initialValue: initValue,
                    onChanged: enabled && field.control.enabled && !readOnly
                        ? (value) {
                            field.didChange(
                                DateHelper.formatUtc(value.dateOfBirth));
                            onChanged?.call(field.control);
                          }
                        : null)
              ],
            ),
          );
        });

  @override
  ReactiveFormFieldState<String, String> createState() =>
      ReactiveFormFieldState<String, String>();
}
