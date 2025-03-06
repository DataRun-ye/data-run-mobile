import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottom_sheet_content_model.freezed.dart';

@freezed
class DialogContentModel with _$DialogContentModel {
  const factory DialogContentModel({
    required String title,
    required String subtitle,
    required IconData icon,
    required BottomSheetBodyModel body,
  }) = _DialogContentModel;
}

@freezed
abstract class BottomSheetBodyModel with _$BottomSheetBodyModel {
  factory BottomSheetBodyModel.messageBody({required String message}) =
      MessageBody;

  factory BottomSheetBodyModel.errorsBody({
    required String message,
    required Map<String, List<FieldWithIssue>> fieldsWithIssues,
  }) = ErrorsBody;
}

@freezed
class FieldWithIssue with _$FieldWithIssue {
  const factory FieldWithIssue({
    String? repeatGroupUid,
    String? rowUid,
    String? parent,
    required String fieldPath, // path to the leaf field with an error
    required String fieldUid, // path to the leaf field with an error
    required String fieldName, // name of the leaf field
    @Default(IssueType.Error) IssueType issueType,
    @Default('Error') String message,
  }) = _FieldWithIssue;
}

enum IssueType {
  Error,
  Mandatory,
  Warning,
  ErrorOnComplete,
  WarningOnComplete,
}
