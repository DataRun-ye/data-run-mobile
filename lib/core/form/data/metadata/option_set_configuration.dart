import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:drift/drift.dart';

// @injectable
class OptionSetConfigurations {
  const OptionSetConfigurations();

  Future<DataOption?> optionInDataSetByCode(
          String optionSetUid, String optionCode) =>
      DSdk.db.managers.dataOptions
          .filter((f) => f.code(optionCode) & f.optionSet.id(optionSetUid))
          .getSingleOrNull();

  Future<DataOption?> optionInDataSetByName(
          String optionSetUid, String optionName) =>
      DSdk.db.managers.dataOptions
          .filter((f) => f.name(optionName) & f.optionSet.id(optionSetUid))
          .getSingleOrNull();
}
