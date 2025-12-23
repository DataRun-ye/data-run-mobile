import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/q_age_field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/q_barcode_reader_field.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/q_drop_down_with_search_field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/q_reactive_date_time_field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/q_reactive_multi_select_field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/q_reactive_single_select_field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/q_switch_field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/q_text_type_field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reactive_progress_select_chip.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reactive_team_select_chip.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reactive_yes_no_choice_chips.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reference_search/q_reference_drop_down_search_field.widget.dart';
import 'package:flutter/material.dart';
//
// /// Factory that instantiate form input fields based on a dynamic element tree
// class PopupFormElementWidgetFactory {
//   static Widget createWidget(
//       FormElementInstance<dynamic> element, FieldContextRegistry registry) {
//     return switch (element) {
//       FieldInstance() => FieldWidget(
//           key: registry.getOrCreateKey(element.elementPath!), element: element),
//       RepeatSection() => RepeatTable(
//           key: Key(element.elementPath!),
//           repeatInstance: element,
//         ),
//       Section() => PopupSectionWidget(
//           key: ValueKey(element.elementPath), element: element),
//       // // TODO: Handle this case.
//       // RepeatScanInstance() => throw UnimplementedError(),
//       // TODO: Handle this case.
//       // RepeatScanInstance() => throw UnimplementedError(),
//     };
//   }
// }

/// a Factory that is called by the [FieldWidget] to create the input widget based on ValueType of element
class FieldFactory {
  static Widget fromType<T>(FieldInstance<T> element) {
    switch (element.type) {
      case ValueType.Text:
      case ValueType.LongText:
      case ValueType.Letter:
      case ValueType.Email:
      case ValueType.FullName:
      case ValueType.Integer:
      case ValueType.IntegerPositive:
      case ValueType.IntegerNegative:
      case ValueType.IntegerZeroOrPositive:
      case ValueType.Number:
        return QTextTypeField(element: element);
      case ValueType.Age:
        return QReactiveAgeField(element: element as FieldInstance<String>);
      case ValueType.Calculated:
        return const SizedBox.shrink();
      case ValueType.Date:
      case ValueType.Time:
      case ValueType.DateTime:
        return QReactiveDateTimeFormField(
            element: element as FieldInstance<String>);
      case ValueType.Boolean:
      case ValueType.YesNo:
        return ReactiveYesNoChoiceChips(
            element: element as FieldInstance<bool>);
      case ValueType.TrueOnly:
        return QSwitchField(element: element as FieldInstance<bool>);
      // case ValueType.OrganisationUnit:
      //   return QReactiveOrgUnitSelectField(
      //       element: element as FieldInstance<String>);
      case ValueType.Progress:
        return QReactiveProgressSelectChip(
            element: element as FieldInstance<String>);
      case ValueType.Team:
        return QReactiveTeamSelectChip(
            element: element as FieldInstance<String>);
      case ValueType.SelectOne:
        if ((element.choiceFilter?.options ?? element.visibleOption).length <=
            8) {
          return QReactiveSingleSelectField(
              element: element as FieldInstance<String>);
        } else {
          return QDropDownWithSearchField(
              element: element as FieldInstance<String>);
        }

      case ValueType.SelectMulti:
        return QReactiveMultiSelectSearchField(
            element: element as FieldInstance<List<String>>);
      case ValueType.ScannedCode:
        // return QTextTypeField(element: element);
        return QBarcodeReaderField(element: element as FieldInstance<String>);
      case ValueType.Reference:
        return QReferenceDropDownSearchField(
            element: element as FieldInstance<String>);
      default:
        return Text('Unsupported element type: ${element.type}');
    }
  }
}
