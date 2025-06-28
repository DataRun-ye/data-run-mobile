import 'package:d2_remote/core/utilities/list_extensions.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/metadatarun/option_set/entities/option.entity.dart';
import 'package:d2_remote/modules/metadatarun/option_set/entities/option_set.entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class OptionSetConfigurations {
  const OptionSetConfigurations();

  Future<Option?> optionInDataSetByCode(
      String optionSetUid, String optionCode) async {
    final OptionSet optionSet =
        await D2Remote.optionSetModule.optionSet.byId(optionSetUid).getOne();
    return optionSet.options?.firstOrNullWhere((o) => o.code == optionCode);
  }

  Future<Option?> optionInDataSetByName(
      String optionSetUid, String optionName) async {
    final OptionSet optionSet =
        await D2Remote.optionSetModule.optionSet.byId(optionSetUid).getOne();
    return optionSet.options?.firstOrNullWhere((o) => o.name == optionName);
  }
}
