import 'dart:async';

import 'package:d2_remote/core/datarun/exception/d_exception.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/repeat_instance.entity.dart';
import 'package:datarunmobile/core/form/data/form_value_store.dart';
import 'package:datarunmobile/core/form/evaluation_engine/rules/rule_effect.dart';
import 'package:datarunmobile/core/form/evaluation_engine/rules/rule_utils_provider_result.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class RulesUtilsProvider {
  Future<RuleUtilsProviderResult> applyRuleEffects({
    required  bool applyForEvent,
    required  Map<String, FieldUiModel> fieldViewModels,
    required  List<RuleEffect> calcResult,
    FormValueStore? valueStore,
  });

  // void applyRuleEffectsFormStages(
  //   Map<String, RepeatInstance> programStages,
  //   Result<List<RuleEffect>, DException> calcResult,
  // );
}
