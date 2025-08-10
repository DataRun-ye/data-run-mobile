import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_by_value_label.dart';
import 'package:datarunmobile/features/form/application/value_display.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrgUnitDisplay extends ConsumerWidget {
  OrgUnitDisplay({
    super.key,
    this.orgUnit,
    this.id,
    this.highlightText = '',
  }) {
    assert(orgUnit != null || id != null);
  }

  final IdentifiableModel? orgUnit;
  final String? id;
  final String highlightText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (orgUnit != null) {
      return HighlightedByValueLabel('${orgUnit!.code}-${orgUnit!.name}', highlightText);
    }

    final displayValueAsync = ref.watch(
        valueDisplayProvider(valueType: ValueType.OrganisationUnit, value: id));

    return AsyncValueWidget(
      value: displayValueAsync,
      valueBuilder: (String? display) {
        return HighlightedByValueLabel('${display}', highlightText);
      },
    );
  }
}
