import 'package:datarun/data_run/screens/form_ui_elements/bottom_sheet/form_completion_dialog_config/form_completion_dialog.dart';
import 'package:flutter/material.dart';

class QBottomSheetDialog extends StatelessWidget {
  const QBottomSheetDialog({
    super.key,
    required this.completionDialogModel,
    this.onButtonClicked,
    this.onItemWithErrorClicked,
  });

  final FormCompletionDialog completionDialogModel;
  final Function(FormBottomDialogActionType? action)? onButtonClicked;
  final Function(String? path)? onItemWithErrorClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Icon and Title
          Icon(completionDialogModel.bottomSheetContentModel.icon, size: 30),
          const SizedBox(height: 10),
          Text(
            completionDialogModel.bottomSheetContentModel.title,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          const SizedBox(height: 10),
          Text(
            completionDialogModel.bottomSheetContentModel.subtitle,
            style: const TextStyle(fontSize: 12.0),
          ),
          const SizedBox(height: 10),
          // Scrollable Error Body with max height
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children:
                      completionDialogModel.bottomSheetContentModel.body.when(
                    messageBody: (messageBody) => [
                      Text(
                        messageBody,
                        style: const TextStyle(fontSize: 16.0),
                      )
                    ],
                    errorsBody: (message, fieldsWithIssues) {
                      return fieldsWithIssues.entries
                          .toList()
                          .reversed
                          .map((sectionEntry) {
                        final sectionName = sectionEntry.key;
                        final fieldErrors = sectionEntry.value.reversed;

                        return ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            sectionName,
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          children: fieldErrors.map((fieldEntry) {
                            return GestureDetector(
                              onTap: () => onItemWithErrorClicked
                                  ?.call(fieldEntry.fieldPath),
                              child: ListTile(
                                dense: true,
                                leading:
                                    const Icon(Icons.error, color: Colors.red),
                                title: Text(
                                    '${fieldEntry.fieldName}: ${fieldEntry.message}'),
                              ),
                            );
                          }).toList(),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Buttons with spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton(context, completionDialogModel.secondaryButton),
              _buildButton(context, completionDialogModel.mainButton),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, FormCompletionButton button) {
    return ElevatedButton.icon(
      onPressed: () {
        onButtonClicked?.call(button.action);
        Navigator.pop(context);
      },
      icon: button.buttonStyle.iconData != null
          ? Icon(button.buttonStyle.iconData)
          : const SizedBox.shrink(),
      label: Text(button.buttonStyle.text),
      style: ElevatedButton.styleFrom(
        foregroundColor: button.buttonStyle.color,
        backgroundColor: button.buttonStyle.backgroundColor,
      ),
    );
  }
}
