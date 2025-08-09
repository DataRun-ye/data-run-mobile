import 'package:d_sdk/database/converters/converters.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

class MetadataSubmissions extends Table with BaseTableMixin {
  TextColumn get resourceType =>
      text().map(const EnumNameConverter(MetadataResourceType.values))();

  TextColumn get metadataSchema => text()();

  IntColumn get serialNumber => integer()();

  IntColumn get version => integer()();

  TextColumn get resourceId => text()();

  TextColumn get formData =>
      text().map(const NullAwareMapConverter()).nullable()();

  TextColumn get createdBy => text().nullable()();

  TextColumn get lastModifiedBy => text().nullable()();
}
