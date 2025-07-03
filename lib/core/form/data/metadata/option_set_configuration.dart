import 'package:d_sdk/core/utilities/list_extensions.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:injectable/injectable.dart';

@injectable
class OptionSetConfigurations {
  Future<FormOption?> optionInDataSetByCode(
      String optionSetUid, String optionCode) async {
    final DataOptionSet? optionSet = await DSdk.db.managers.dataOptionSets
        .filter((f) => f.id.equals(optionSetUid))
        .getSingleOrNull();

    return optionSet!.options?.firstOrNullWhere((o) => o.code == optionCode);
  }

  Future<FormOption?> optionInDataSetByName(
      String optionSetUid, String optionName) async {
    final DataOptionSet? optionSet = await DSdk.db.managers.dataOptionSets
        .filter((f) => f.id.equals(optionSetUid))
        .getSingleOrNull();

    return optionSet!.options?.firstOrNullWhere((o) => o.name == optionName);
  }
}
