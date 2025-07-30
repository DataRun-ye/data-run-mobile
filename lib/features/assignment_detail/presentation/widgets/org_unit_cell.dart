import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/form/presentation/widgets/value_type_value_display.dart';
import 'package:flutter/material.dart';

class OrgUnitCell extends StatelessWidget {
  const OrgUnitCell({
    super.key,
    required this.orgUnitId,
  });

  final String orgUnitId;

  @override
  Widget build(BuildContext context) {
    return ValueTypeValueDisplay(
      valueType: ValueType.OrganisationUnit,
      value: orgUnitId,
    );
  }
}
