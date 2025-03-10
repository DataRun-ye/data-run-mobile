import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:datarun/data_run/screens/form/field_widgets/code_scanner/barcode_scanner_widget.dart';
import 'package:datarun/data_run/screens/form_module/form/code_generator.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef OnScan = void Function(String code);

class ReactiveCodeScanField<T> extends ReactiveFormField<T, String> {
  ReactiveCodeScanField({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    InputDecoration? decoration,
    TextStyle? style,
    bool showClearIcon = false,
    Widget clearIcon = const Icon(Icons.clear),
    OnScan? onScan,
  }) : super(
          builder: (field) {
            Widget? suffixIcon = decoration?.suffixIcon;
            final isEmptyValue = field.value == null || field.value == null;

            if (showClearIcon && !isEmptyValue) {
              suffixIcon = InkWell(
                borderRadius: BorderRadius.circular(25),
                child: clearIcon,
                onTap: () async {
                  field.control.markAsTouched();
                  field.didChange(null);
                },
              );
            }

            final InputDecoration effectiveDecoration =
                (decoration ?? const InputDecoration())
                    .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                    .copyWith(
                        suffixIcon: suffixIcon,
                        prefixIcon: Icon(Icons.qr_code_scanner));

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Opacity(
                opacity: field.control.enabled ? 1 : 0.5,
                child: GestureDetector(
                  onTap: () async {
                    // Open the mobile scanner dialog
                    final rawScannedCode = await Navigator.push<String?>(
                      field.context,
                      MaterialPageRoute(
                        builder: (_) => BarcodeScannerWidget(
                          key: Key(
                              'BarcodeScannerWidget_${CodeGenerator.generateUid()}'),
                          initialRawCode: field.value,
                        ),
                      ),
                    );

                    if (rawScannedCode != null) {
                      logDebug(rawScannedCode);
                      field.didChange(rawScannedCode);
                      onScan?.call(rawScannedCode);
                    }
                  },
                  child: InputDecorator(
                    decoration: effectiveDecoration.copyWith(
                      errorText: field.errorText,
                      enabled: field.control.enabled,
                    ),
                    isFocused: field.control.hasFocus,
                    isEmpty: isEmptyValue,
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            field.value ?? '',
                            style: Theme.of(field.context)
                                .textTheme
                                .titleMedium
                                ?.merge(style),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
}
