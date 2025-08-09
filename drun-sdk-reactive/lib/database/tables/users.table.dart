import 'package:d_sdk/database/converters/converters.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

class Users extends Table with BaseTableMixin {
  TextColumn get username => text().unique()();

  TextColumn get firstName => text().nullable()();

  TextColumn get lastName => text().nullable()();

  TextColumn get mobile => text().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get langKey => text().nullable().clientDefault(() => 'ar')();

  BoolColumn get activated => boolean().clientDefault(() => false)();

  TextColumn get imageUrl => text().nullable()();

  TextColumn get authorities => text().map(const ListConverter<String>())();

  // metadata
  IntColumn get submissionCount =>
      integer().nullable().clientDefault(() => 0)();

  IntColumn get assignmentCount =>
      integer().nullable().clientDefault(() => 0)();

  IntColumn get orgUnitCount => integer().nullable().clientDefault(() => 0)();

  TextColumn get activityUIDs => text().map(const ListConverter<String>())();

  TextColumn get userTeamsUIDs => text().map(const ListConverter<String>())();

  TextColumn get managedTeamsUIDs =>
      text().map(const ListConverter<String>())();

  TextColumn get userGroupsUIDs => text().map(const ListConverter<String>())();

  TextColumn get userFormsUIDs => text().map(const ListConverter<String>())();
}
