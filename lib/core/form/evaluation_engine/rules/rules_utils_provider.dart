import 'package:d2_remote/core/datarun/exception/d_exception.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/repeat_instance.entity.dart';
import 'package:datarun/core/form/data/form_value_store.dart';
import 'package:datarun/core/form/evaluation_engine/rules/rule_effect.dart';
import 'package:datarun/core/form/evaluation_engine/rules/rule_utils_provider_result.dart';
import 'package:datarun/core/form/model/field_ui_model.dart';
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
