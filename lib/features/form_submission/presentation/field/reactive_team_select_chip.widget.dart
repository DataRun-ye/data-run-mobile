import 'package:d_sdk/database/shared/d_identifiable_model.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/activity/presentation/activity_inherited_widget.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_chip_option.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_choice_chips.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_metadata_inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QReactiveTeamSelectChip extends ConsumerWidget {
  QReactiveTeamSelectChip({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

    final teams = ActivityInheritedWidget.of(context).managedTeams;

    return ReactiveChoiceChips<String>(
        formControl: formInstance.form.control(element.elementPath!)
            as FormControl<String>,
        validationMessages: validationMessages(),
        selectedColor: Theme.of(context).colorScheme.error.withAlpha(100),
        options: _getChipOptions(teams),
        decoration: InputDecoration(
          enabled: element.elementControl.enabled,
          labelText: element.label,
        ));
  }

  List<ReactiveChipOption<String>> _getChipOptions(
      List<IdentifiableModel> teams) {
    return teams
        .map((IdentifiableModel team) => ReactiveChipOption<String>(
              value: team.id,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[const Icon(Icons.group), Text(team.name)]),
            ))
        .toList();
  }
}
