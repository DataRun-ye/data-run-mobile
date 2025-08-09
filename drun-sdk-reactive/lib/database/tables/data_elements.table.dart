import 'package:d_sdk/database/converters/converters.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'data_element_name_idx', columns: {#name})
class DataElements extends Table with BaseTableMixin, IdentifiableMixin {
  TextColumn get name => text()();

  TextColumn get code => text().nullable()();

  TextColumn get description => text().nullable()();

  TextColumn get type =>
      text().map(const EnumNameConverter(ValueType.values))();

  TextColumn get optionSet =>
      text().references(DataOptionSets, #id).nullable()();

  BoolColumn get mandatory => boolean().nullable()();

  TextColumn get defaultValue => text().nullable()();

  TextColumn get scannedCodeProperties =>
      text().map(const ScannedCodePropertiesConverter()).nullable()();

  BoolColumn get gs1Enabled => boolean().nullable()();

  TextColumn get resourceType => text()
      .map(const EnumNameConverter(MetadataResourceType.values))
      .nullable()();

  TextColumn get resourceMetadataSchema => text().nullable()();
}
