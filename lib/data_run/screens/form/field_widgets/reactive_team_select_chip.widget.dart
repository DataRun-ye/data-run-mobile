import 'package:datarun/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarun/data_run/d_team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
import 'package:datarun/data_run/screens/form/element/validation/form_element_validator.dart';
import 'package:datarun/data_run/screens/form/field_widgets/custom_reactive_widget/reactive_chip_option.dart';
import 'package:datarun/data_run/screens/form/field_widgets/custom_reactive_widget/reactive_choice_chips.dart';
import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
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

    final teams = ActivityInheritedWidget.of(context).managedTeams.unlock;

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

  List<ReactiveChipOption<String>> _getChipOptions(List<TeamModel> teams) {
    return teams
        .map((TeamModel team) => ReactiveChipOption<String>(
              value: team.id!,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[Icon(Icons.group), Text(team.name!)]),
            ))
        .toList();
  }
}
