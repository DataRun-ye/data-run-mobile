import 'dart:async';

import 'package:datarunmobile/core/form/data/form_value_store.dart';
import 'package:datarunmobile/core/form/evaluation_engine/rules/rule_effect.dart';
import 'package:datarunmobile/core/form/evaluation_engine/rules/rule_utils_provider_result.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';

abstract class RulesUtilsProvider {
  Future<RuleUtilsProviderResult> applyRuleEffects({
    required bool applyForEvent,
    required Map<String, FieldUiModel> fieldViewModels,
    required List<RuleEffect> calcResult,
    FormValueStore? valueStore,
  });

  // void applyRuleEffectsFormStages(
  //   Map<String, RepeatInstance> programStages,
  //   Result<List<RuleEffect>, DException> calcResult,
  // );
}
