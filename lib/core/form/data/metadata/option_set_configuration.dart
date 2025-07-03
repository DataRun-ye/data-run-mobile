import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/metadatarun/option_set/entities/option.entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class OptionSetConfigurations {
  const OptionSetConfigurations();

  Future<Option?> optionInDataSetByCode(
          String optionSetUid, String optionCode) =>
      D2Remote.optionSetModule.option
          .byOptionSet(optionSetUid)
          .where(attribute: 'code', value: optionCode)
          .getOne();

  Future<Option?> optionInDataSetByName(
          String optionSetUid, String optionName) =>
      D2Remote.optionSetModule.option
          .byOptionSet(optionSetUid)
          .where(attribute: 'name', value: optionName)
          .getOne();
}
