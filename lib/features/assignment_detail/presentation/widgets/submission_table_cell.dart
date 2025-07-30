import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/datasource/util/field_value.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/assignment/presentation/build_status.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/widgets/multi_option_cell.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/widgets/numeric_cell.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/widgets/option_cell.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/widgets/team_cell.dart';
import 'package:datarunmobile/features/form/application/map_value_to_display.dart';
import 'package:datarunmobile/features/form/presentation/widgets/value_type_value_display.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SubmissionTableCell extends StatelessWidget {
  const SubmissionTableCell({
    super.key,
    this.fieldValue,
  });

  final FieldValue? fieldValue;

  @override
  Widget build(BuildContext context) {
    if (this.fieldValue == null || this.fieldValue!.value == null)
      return Text('');

    final fieldValue = this.fieldValue!;
    switch (fieldValue.valueType) {
      case ValueType.Progress:
        final AssignmentStatus? value =
            AssignmentStatus.getType(fieldValue.value.toString());
        return value != null
            ? buildStatusBadge(
                value,
                0,
                ValueKey(fieldValue.id),
              )
            : const Text('');
      case ValueType.FullName:
      case ValueType.Text:
      case ValueType.PhoneNumber:
      case ValueType.Email:
      case ValueType.LongText:
      case ValueType.Username:
      case ValueType.Coordinate:
        final value = (fieldValue.value?.toString().length ?? 0) > 20
            ? fieldValue.value.toString().substring(0, 20)
            : fieldValue.value?.toString() ?? '';
        return Text(key: ValueKey(fieldValue.id), value);
      case ValueType.Letter:
        return Text(
            key: ValueKey(fieldValue.id), fieldValue.value?.toString() ?? '');
      case ValueType.Boolean:
      case ValueType.TrueOnly:
        return ValueTypeValueDisplay(
          key: ValueKey(fieldValue.id),
          valueType: fieldValue.valueType,
          value: fieldValue.value,
        );
      case ValueType.Date:
      case ValueType.DateTime:
      case ValueType.Time:
        return Text(
            key: ValueKey(fieldValue.id),
            appLocator<MapValueToDisplay>().getDateValue(
              fieldValue.valueType,
              fieldValue.value,
            ));
      case ValueType.Number:
      case ValueType.UnitInterval:
      case ValueType.Percentage:
      case ValueType.Integer:
      case ValueType.IntegerPositive:
      case ValueType.IntegerNegative:
      case ValueType.IntegerZeroOrPositive:
      case ValueType.Age:
        return NumericCell(
          key: ValueKey(fieldValue.id),
          value: fieldValue.value?.toString(),
        );
      case ValueType.OrganisationUnit:
        final orgUnitId = fieldValue.value?.toString();
        return ValueTypeValueDisplay(
          key: ValueKey(fieldValue.id),
          valueType: ValueType.OrganisationUnit,
          value: orgUnitId,
        );
      case ValueType.Team:
        return TeamCell(
          key: ValueKey(fieldValue.id),
          team: fieldValue.value?.toString(),
        );
      case ValueType.SelectMulti:
        return MultiOptionCell(
          key: ValueKey(fieldValue.id),
          optionIds: fieldValue.value,
        );
      case ValueType.SelectOne:
        return OptionCell(
          key: ValueKey(fieldValue.id),
          optionId: fieldValue.value?.toString(),
        );
      case ValueType.YesNo:
        return ValueTypeValueDisplay(
          key: ValueKey(fieldValue.id),
          valueType: ValueType.OrganisationUnit,
          value: fieldValue.value,
        );
      case ValueType.ScannedCode:
        return fieldValue.value != null
            ? Row(
                key: ValueKey(fieldValue.id),
                children: [
                  Icon(MdiIcons.barcode),
                  const SizedBox(width: 4),
                  Text(fieldValue.value!.toString().substring(0, 10)),
                ],
              )
            : Text('');
      case ValueType.Section:
      case ValueType.RepeatableSection:
      case ValueType.Attribute:
      case ValueType.TrackerAssociate:
      case ValueType.Reference:
      case ValueType.URL:
      case ValueType.FileResource:
      case ValueType.Image:
      case ValueType.GeoJson:
      case ValueType.Calculated:
        final value = (fieldValue.value?.toString().length ?? 0) > 20
            ? fieldValue.value.toString().substring(0, 20)
            : fieldValue.value?.toString() ?? '';
        return Text(key: ValueKey(fieldValue.id), value);
    }
  }
}
