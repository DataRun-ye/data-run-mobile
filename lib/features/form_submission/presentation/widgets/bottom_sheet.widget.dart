import 'package:datarunmobile/features/form_submission/presentation/widgets/form_completion_dialog.dart';
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
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            completionDialogModel.bottomSheetContentModel.icon,
            size: 30,
            color: cs.error,
          ),
          const SizedBox(height: 8),
          Text(
            completionDialogModel.bottomSheetContentModel.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 30),
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
                          .map((sectionEntry) {
                        final sectionName = sectionEntry.key;
                        final fieldErrors = sectionEntry.value;

                        return ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            sectionName,
                            style: TextStyle(
                                color: cs.error, fontWeight: FontWeight.bold),
                          ),
                          children: fieldErrors.map((fieldEntry) {
                            return ListTile(
                              dense: true,
                              leading: Icon(Icons.error, color: cs.error),
                              title: GestureDetector(
                                onTap: () {
                                  Feedback.wrapForTap(
                                      onItemWithErrorClicked
                                          ?.call(fieldEntry.fieldPath),
                                      context);
                                  // onItemWithErrorClicked
                                  //     ?.call(fieldEntry.fieldPath);
                                },
                                child: Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: [
                                    Text('${fieldEntry.fieldName}: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge),
                                    Text('${fieldEntry.message}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: cs.error)),
                                  ],
                                ),
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
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 4,
            runSpacing: 4,
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
