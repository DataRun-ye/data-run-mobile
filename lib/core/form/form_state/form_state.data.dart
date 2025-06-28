import 'package:datarunmobile/core/form/evaluation_engine/rules/rule_utils_provider_result.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_state.data.freezed.dart';

@freezed
abstract class FormState with _$FormState {
  const factory FormState({
    required List<FieldUiModel> fields,
    required double completionPercentage,
    required bool isLoading,
    required bool calculationLoop,
    required List<ConfigurationError> configErrors,
    required Option<String> focusedFieldId,
  }) = _FormState;

  factory FormState.initial() => const FormState(
        fields: [],
        completionPercentage: 0.0,
        isLoading: true,
        calculationLoop: false,
        configErrors: [],
        focusedFieldId: None(),
      );
}
