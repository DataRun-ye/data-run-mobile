import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_by_value_label.dart';
import 'package:flutter/material.dart';

class OrgUnitDisplay extends StatelessWidget {
  const OrgUnitDisplay({
    super.key,
    required this.orgUnit,
    this.highlightText = '',
  });

  final IdentifiableModel orgUnit;
  final String highlightText;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HighlightedByValueLabel('${orgUnit.code}', highlightText),
          HighlightedByValueLabel('${orgUnit.name}', highlightText)
        ]);
  }
}
