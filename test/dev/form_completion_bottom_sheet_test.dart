import 'package:datarunmobile/data/model/bottom_sheet_content_model.data.dart';
import 'package:datarunmobile/data/model/dialog_button_style.data.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/bottom_sheet.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_completion_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('returns the selected action without popping the host route',
      (tester) async {
    FormBottomDialogActionType? selectedAction;
    final dialog = FormCompletionDialog(
      bottomSheetContentModel: DialogContentModel(
        title: 'Save submission',
        subtitle: '',
        icon: Icons.save,
        body: BottomSheetBodyModel.messageBody(message: 'Choose an action'),
      ),
      mainButton: const FormCompletionButton(
        buttonStyle: DialogButtonStyle.mainButton(text: 'Complete'),
        action: FormBottomDialogActionType.MarkAsFinal,
      ),
      secondaryButton: const FormCompletionButton(
        buttonStyle: DialogButtonStyle.secondaryButton(text: 'Save draft'),
        action: FormBottomDialogActionType.NotNow,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                selectedAction =
                    await showModalBottomSheet<FormBottomDialogActionType>(
                  context: context,
                  builder: (_) => QBottomSheetDialog(
                    completionDialogModel: dialog,
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save draft'));
    await tester.pumpAndSettle();

    expect(selectedAction, FormBottomDialogActionType.NotNow);
    expect(find.text('Open'), findsOneWidget);
  });
}
