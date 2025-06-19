import 'dart:async';

import 'package:datarunmobile/data_run/screens/form/field_widgets/custom_reactive_widget/age/age_value.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';

/// AgeField widget displays inline Y/M/D input fields and calculates the
/// underlying DOB
class AgeFieldWidget extends StatefulWidget {
  AgeFieldWidget(
      {super.key,
      this.label = 'Age',
      this.initialValue,
      this.readOnly = false,
      this.enabled = true,
      this.onChanged,
      DateTime? referenceDate})
      : this.referenceDate = referenceDate ?? DateTime.now();

  final String label;
  final AgeValue? initialValue; // from API as dob-based
  final bool readOnly;
  final bool enabled;
  final DateTime referenceDate;
  final ValueChanged<AgeValue>? onChanged;

  @override
  _AgeFieldWidgetState createState() => _AgeFieldWidgetState();
}

class _AgeFieldWidgetState extends State<AgeFieldWidget> {
  late AgeValue _value;
  late DateTime _ref;
  late int _years, _months, _days;
  Timer? _debounce;
  late TextEditingController _yearsController;
  late TextEditingController _monthsController;
  late TextEditingController _daysController;
  late FocusNode _yearsFocus;
  late FocusNode _monthsFocus;
  late FocusNode _daysFocus;

  @override
  void initState() {
    super.initState();
    _ref = widget.referenceDate;
    final init = widget.initialValue ?? AgeValue(dateOfBirth: _ref);
    _value = init;
    _years = _value.years(_ref);
    final totalMonths = _value.months(_ref);
    _months = (totalMonths - _years * 12).clamp(0, 11);
    _days = (_value.days(_ref) -
            _ref
                .difference(DateTime(
                    _ref.year - _years, _ref.month - _months, _ref.day))
                .inDays)
        .clamp(0, 30);

    _yearsController = TextEditingController(text: _years.toString());
    _monthsController = TextEditingController(text: _months.toString());
    _daysController = TextEditingController(text: _days.toString());
    _yearsFocus = FocusNode();
    _monthsFocus = FocusNode();
    _daysFocus = FocusNode();

    _setupFocusSelectAll(_yearsFocus, _yearsController);
    _setupFocusSelectAll(_monthsFocus, _monthsController);
    _setupFocusSelectAll(_daysFocus, _daysController);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.onChanged?.call(_value));
  }

  void _setupFocusSelectAll(FocusNode node, TextEditingController controller) {
    node.addListener(() {
      if (node.hasFocus) {
        controller.selection =
            TextSelection(baseOffset: 0, extentOffset: controller.text.length);
      }
    });
  }

  void _onFieldChanged({int? years, int? months, int? days}) {
    _years = years ?? _years;
    _months = (months ?? _months).clamp(0, 11);
    _days = (days ?? _days).clamp(0, 30);
    setState(() {
      _value = AgeValue(
          dateOfBirth: _value
              .copyWith(
                years: _years,
                months: _months,
                days: _days,
                ref: _ref,
              )
              .dateOfBirth);
    });
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onChanged?.call(_value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _yearsController.dispose();
    _monthsController.dispose();
    _daysController.dispose();
    _yearsFocus.dispose();
    _monthsFocus.dispose();
    _daysFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _numberField(S.of(context).years, _yearsController, _yearsFocus,
              (v) => _onFieldChanged(years: v)),
          const SizedBox(width: 8),
          _numberField(S.of(context).months, _monthsController, _monthsFocus,
              (v) => _onFieldChanged(months: v)),
          const SizedBox(width: 8),
          _numberField(S.of(context).days, _daysController, _daysFocus,
              (v) => _onFieldChanged(days: v)),
        ],
      ),
    );
  }

  Widget _numberField(String label, TextEditingController controller,
      FocusNode focusNode, ValueChanged<int> onChanged) {
    return SizedBox(
      width: 80,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          labelText: label,
          hintText: '0',
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        ),
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        onChanged: (s) {
          final v = int.tryParse(s);
          if (v != null && v >= 0) onChanged(v);
        },
      ),
    );
  }
}

// Demo usage
// void main() => runApp(MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: AgeFieldWidget(
//             onChanged: (v) => print('DOB: \${v.dateOfBirth}'),
//           ),
//         ),
//       ),
//     ));
