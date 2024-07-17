import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mass_pro/data_run/form/form.dart';
import 'package:mass_pro/data_run/screens/data_submission_form/model/q_field.model.dart';
import 'package:mass_pro/data_run/screens/project_details/entity_creation_dialog/dynamic_form_field.widget.dart';
import 'package:mass_pro/data_run/screens/project_details/project_detail_item.model.dart';
import 'package:mass_pro/generated/l10n.dart';

class EntityCreationDialog extends ConsumerStatefulWidget {
  // final FormListItemModel formListModel;

  const EntityCreationDialog({super.key, required this.formModel});

  final FormListItemModel formModel;

  @override
  EntityCreationDialogState createState() => EntityCreationDialogState();
}

class EntityCreationDialogState extends ConsumerState<EntityCreationDialog> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  Future<String?> _createEntity(FormListItemModel formModel) async {
    final syncableEntityInitialRepository = ref.read(
        syncableEntityInitialRepositoryProvider(formCode: formModel.formCode));

    return syncableEntityInitialRepository.createSyncable(
        activityUid: formModel.activity!,
        teamUid: formModel.team!,
        mainFieldValues: formModel.fields);
  }

  Future<void> createAndPopupWithResult(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    String? syncableId;
    try {
      if (_formKey.currentState?.validate() ?? false) {
        // Call the function to create entity
        _formKey.currentState!.save();
        final updatedFields = widget.formModel.fields
            ?.map((QFieldModel field) => field.setValue(
                _formKey.currentState!.value[field.uid] ?? field.value))
            .toList();
        final updatedModel = widget.formModel.copyWith(fields: updatedFields);

        syncableId = await _createEntity(updatedModel);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop(syncableId);
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }

      // // After adding the entity, close the dialog
      // // Check if the context is still mounted
      // if (!context.mounted) {
      //   return;
      // }
      // Close the dialog if entity creation is successful
    } catch (e) {
      // Handle the error here, show a snackbar, or set an error state
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).errorOpeningNewForm}: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      shadowColor: Theme.of(context).colorScheme.shadow,
      title: Text(S.of(context).openNewForm),
      content: SingleChildScrollView(
        child: Column(
          children: [
            //
            FormBuilder(
              key: _formKey,
              clearValueOnUnregister: true,
              onPopInvoked: (bool value) {
                /// show confirm, save, complete
                debugPrint('showDialog onPopInvoked ');
              },
              onChanged: () {
                _formKey.currentState!.save();
                debugPrint(
                    'form _formKey State Changed: ${_formKey.currentState!.value.toString()}');
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.formModel.fields
                        ?.map((QFieldModel fieldModel) =>
                            DynamicFormFieldWidget(fieldModel: fieldModel))
                        .toList() ??
                    [],
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(S.of(context).cancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(S.of(context).open),
          onPressed:
              _isLoading ? null : () => createAndPopupWithResult(context),
        ),
      ],
    );
  }
}
