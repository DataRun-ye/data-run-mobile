import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/core/form/data/form_value_store.dart';
import 'package:datarunmobile/core/form/evaluation_engine/rules/rule_effect.dart';
import 'package:datarunmobile/core/form/evaluation_engine/rules/rule_utils_provider_result.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class RulesUtilsProvider {
  RuleUtilsProviderResult applyRuleEffectsForEvent({
    bool applyForEvent,
    Map<String, FieldUiModel> fieldViewModels,
    List<RuleEffect> ruleEffects,
    FormValueStore? valueStore,
  });

  void applyRuleEffectsFormStages(
    Map<String, RepeatInstance> programStages,
    Result<List<RuleEffect>, DException> calcResult,
  );
}
