import 'package:datarun/data_run/screens/form_ui_elements/bottom_sheet/bottom_sheet_model/bottom_sheet_content_model.dart';
import 'package:datarun/data_run/screens/form_ui_elements/bottom_sheet/bottom_sheet_model/dialog_button_style.dart';
import 'package:equatable/equatable.dart';

/// data class
class FormCompletionDialog with EquatableMixin {
  const FormCompletionDialog({
    required this.bottomSheetContentModel,
    required this.mainButton,
    required this.secondaryButton,
  });

  final DialogContentModel bottomSheetContentModel;
  final FormCompletionButton mainButton;
  final FormCompletionButton secondaryButton;

  @override
  List<Object?> get props =>
      [bottomSheetContentModel, mainButton, secondaryButton];
}

/// data class
class FormCompletionButton with EquatableMixin {
  const FormCompletionButton({
    required this.buttonStyle,
    required this.action,
  });

  final FormBottomDialogActionType action;
  final DialogButtonStyle buttonStyle;

  @override
  List<Object?> get props => [buttonStyle, action];
}

enum FormBottomDialogActionType { NotNow, MarkAsFinal, CheckFields }
