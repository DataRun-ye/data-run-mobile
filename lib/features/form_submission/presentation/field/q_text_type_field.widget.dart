import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QTextTypeField<T> extends StatefulHookConsumerWidget {
  const QTextTypeField({super.key, required this.element});

  final FieldInstance<T> element;

  @override
  QTextTypeFieldState<T> createState() => QTextTypeFieldState();
}

class QTextTypeFieldState<T> extends ConsumerState<QTextTypeField<T>> {
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final text = _controller.text;
      final endPos = TextPosition(offset: text.length);
      if (_controller.selection.baseOffset != text.length ||
          _controller.selection.extentOffset != text.length) {
        _controller.selection = TextSelection.fromPosition(endPos);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formInstance = ref
        .watch(
        formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;
    final elementPath = widget.element.elementPath!;
    final control = formInstance.form.control(elementPath) as FormControl<T>;

    return ReactiveTextField<T>(
      controller: _controller,
      onTapOutside: control.hasFocus
          ? (event) {
        control.markAsTouched();
        control.unfocus();
      }
          : null,
      formControl: control,
      maxLength: widget.element.maxLength,
      maxLines: widget.element.maxLines,
      textInputAction: formInstance.fieldInputAction(elementPath),
      keyboardType: widget.element.inputType,
      textAlign:
          widget.element.template.type.isNumeric ? TextAlign.end : TextAlign.start,
      validationMessages: validationMessages(),
      decoration: InputDecoration(
          errorMaxLines: 2,
          enabled: control.enabled,
          labelText: widget.element.label,
          hintText: appLocator<HintProvider>().provideHint(
              widget.element.type)),
      onSubmitted: (control) => formInstance.moveToNextElement(elementPath),
    );
  }
}

