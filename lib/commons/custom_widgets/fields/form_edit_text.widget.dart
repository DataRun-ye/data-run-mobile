import 'package:d2_remote/modules/datarun/common/standard_extensions.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';

import 'package:mass_pro/form/model/field_ui_model.dart';
import 'package:mass_pro/form/model/key_board_action_type.dart';
import 'package:mass_pro/form/model/ui_event_type.dart';
import 'package:mass_pro/form/ui/style/form_ui_color_type.dart';
import 'package:mass_pro/form/ui/style/form_ui_model_style.dart';
import 'package:mass_pro/utils/mass_utils/colors.dart';
// import 'package:d2_remote/modules/datarun/common/standard_extensions.dart';

/// form_edit_text_custom, form_integer, form_integer_negative
/// form_integer_positive, form_integer_zero, form_letter,
/// form_number, form_percentage, form_phone_number,
/// form_unit_interval, form_url.xml
class FormEditText extends ConsumerStatefulWidget {
  const FormEditText({super.key, this.item});

  final FieldUiModel? item;

  @override
  ConsumerState<FormEditText> createState() => _FormEditTextState();
}

class _FormEditTextState extends ConsumerState<FormEditText> {
  late final int? _maxLength;
  late final MaxLengthEnforcement? _maxLengthEnforcement;
  late final TextEditingController _fieldController;
  late final FocusNode _focusNode;

  // final _debouncer = Debouncer();

  @override
  Widget build(BuildContext context) {
    // final fieldRowItem = ref.watch(fieldRowProvider);
    // final String? error = fieldItem?.error;
    debugPrint('build(): $runtimeType, itemUid: ${widget.item?.uid}, itemValue: ${widget.item?.value}, '
        'itemLabel ${widget.item?.label}, itemMandatory ${widget.item?.mandatory}, '
        'itemError ${widget.item?.error}, itemWarning ${widget.item?.warning}');

    // final bool? focused = widget.item?.focused;

    // if (focused ?? false) {
    //   _focusNode.requestFocus();
    // }

    return Padding(
      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      padding: EdgeInsets.zero,
      child: TextFormField(
        textInputAction: _getInputAction(widget.item?.keyboardActionType),
        onEditingComplete: () {

        },
        keyboardType: _getInputType(widget.item?.valueType),
        controller: _fieldController,
        onChanged: (String value) {
          // _debouncer.run(() {
          widget.item?.onTextChange(value);
          // });
        },
        focusNode: _focusNode,
        enabled: widget.item?.editable,
        maxLength: _maxLength,
        readOnly: widget.item?.valueType?.isDateTime ?? false,
        maxLengthEnforcement: _maxLengthEnforcement,
        style: _getInputStyle(widget.item),
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: widget.item?.formattedLabel ?? '',
            suffix: _fieldController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: _getLabelTextColor(widget.item?.style)?.color,
                    ),
                    onPressed: () {
                      _fieldController.clear();
                      _focusNode.unfocus(
                          disposition:
                              UnfocusDisposition.previouslyFocusedChild);
                      widget.item?.onTextChange(null);
                      widget.item?.onClear();
                    },
                  )
                : null,
            icon: widget.item?.style?.getDescriptionIcon() != null
                ? IconButton(
                    icon: Icon(
                      widget.item?.style?.getDescriptionIcon(),
                      color: _getLabelTextColor(widget.item?.style)?.color,
                    ),
                    onPressed: () {
                      // _fieldController.text = '';
                      // show description
                    },
                  )
                : null,
            border: const UnderlineInputBorder(),
            suffixIcon: widget.item?.description != null
                ? IconButton(
                    icon: Icon(Icons.info_outline,
                        color: _getLabelTextColor(widget.item?.style)?.color),
                    onPressed: () {
                      widget.item?.invokeUiEvent(UiEventType.SHOW_DESCRIPTION);
                    },
                  )
                : null,
            hintText: widget.item?.hint,
            hintStyle: _getHintStyle(widget.item),
            errorText: widget.item?.error,
            errorStyle: widget.item?.error != null
                ? TextStyle(
                    fontSize: 10, color: convertHexStringToColor('ff6a00'))
                : null,
            focusColor: _getFocusColor(widget.item)),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fieldController.text = widget.item?.value ?? '';
  }

  void _focusListener(){
    if(_focusNode.hasFocus){
      widget.item?.onItemClick();
    }else{
      // keyboard dismissed
    }
  }

  @override
  void initState() {
    _fieldController = TextEditingController(text: widget.item?.value);
    _focusNode = FocusNode()..addListener(_focusListener);

    switch (widget.item?.valueType) {
      case ValueType.Text:
        _maxLength = 500;
        _maxLengthEnforcement = MaxLengthEnforcement.enforced;
        break;
      case ValueType.Letter:
        _maxLength = 1;
        _maxLengthEnforcement = MaxLengthEnforcement.enforced;
        break;
      case ValueType.LongText:
        _maxLength = 50000;
        _maxLengthEnforcement = MaxLengthEnforcement.enforced;
        break;
      default:
        _maxLength = 250;
        _maxLengthEnforcement = MaxLengthEnforcement.none;
        break;
    }

    // _descIcon = widget.item?.style?.getDescriptionIcon();
    // _info = widget.item?.description;
    // _inputType = _getInputType(widget.item?.valueType);
    // _inputAction = _getInputAction(widget.item?.keyboardActionType);
    // _labelStyle = _getLabelTextColor(widget.item?.style);
    // _hintStyle = _getHintStyle(widget.item);
    // _focusColor = _getFocusColor(widget.item);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _fieldController.dispose();
    _focusNode.removeListener(_focusListener);
    _focusNode.dispose();
    super.dispose();
  }

  TextStyle? _getLabelTextColor(FormUiModelStyle? style) {
    return style?.let((FormUiModelStyle it) => it
        .getColors()[FormUiColorType.FIELD_LABEL_TEXT]
        ?.let((Color color) => TextStyle(color: color)));
  }

  TextStyle? _getInputStyle(FieldUiModel? styleItem) {
    TextStyle? style;
    styleItem?.let((FieldUiModel uiModel) {
      uiModel.textColor?.let((Color it) => style = TextStyle(color: it));
      uiModel.backGroundColor?.let((Pair<List<int>, Color?> it) =>
          style = style?.copyWith(backgroundColor: it.second));
    });

    return style;
  }

  TextStyle? _getHintStyle(FieldUiModel? styleItem) {
    TextStyle? style;
    styleItem?.style?.let((FormUiModelStyle it) {
      it
          .getColors()[FormUiColorType.FIELD_LABEL_TEXT]
          ?.let((Color color) => style = TextStyle(color: color));
    });
    return style;
  }

  Color? _getFocusColor(FieldUiModel? styleItem) {
    return styleItem?.style?.let((FormUiModelStyle it) {
      return it
          .getColors()[FormUiColorType.FIELD_LABEL_TEXT]
          ?.let((Color color) => color);
    });
  }

  TextInputType? _getInputType(ValueType? valueType) {
    return when(valueType, <Object, TextInputType Function()>{
      ValueType.Text: () => TextInputType.text,
      ValueType.LongText: () => TextInputType.multiline,
      ValueType.Letter: () => TextInputType.text,
      ValueType.Number: () =>
          const TextInputType.numberWithOptions(decimal: true, signed: true),
      ValueType.UnitInterval: () =>
          const TextInputType.numberWithOptions(decimal: true),
      ValueType.Percentage: () => TextInputType.number,
      <ValueType>[ValueType.IntegerNegative, ValueType.Integer]: () =>
          const TextInputType.numberWithOptions(signed: true),
      <ValueType>[ValueType.IntegerPositive, ValueType.IntegerZeroOrPositive]: () =>
          TextInputType.number,
      ValueType.PhoneNumber: () => TextInputType.phone,
      ValueType.Email: () => TextInputType.emailAddress,
      ValueType.URL: () => TextInputType.url,
    });
  }

  TextInputAction? _getInputAction(KeyboardActionType? type) {
    if (type != null) {
      return when(type, <KeyboardActionType, TextInputAction Function()>{
        KeyboardActionType.NEXT: () => TextInputAction.next,
        KeyboardActionType.DONE: () => TextInputAction.done,
        KeyboardActionType.ENTER: () => TextInputAction.none
      });
    }
    return null;
  }
}
