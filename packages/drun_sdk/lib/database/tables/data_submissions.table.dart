import 'package:d_sdk/database/converters/converters.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

/// each submission, referencing either FORM_TEMPLATE if single‐submission,
/// or DATA_STAGE if staged
@TableIndex(name: 'data_instance_status_idx', columns: {#syncState})
class DataInstances extends Table with BaseTableMixin {
  BoolColumn get deleted => boolean().clientDefault(() => false)();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  /// analogous to program
  @ReferenceName("templateDataInstances")
  TextColumn get formTemplate => text().references(FormTemplates, #id)();

  @ReferenceName("VersionDataInstances")
  TextColumn get templateVersion =>
      text().references(FormTemplateVersions, #id)();

  /// analogous to enrollment
  @ReferenceName("assignmentDataInstances")
  TextColumn get assignment => text().references(Assignments, #id).nullable()();

  // /// who
  // @ReferenceName("teamDataInstances")
  // TextColumn get team => text().references(Teams, #id).nullable()();

  // /// where
  // @ReferenceName("ouDataInstances")
  // TextColumn get orgUnit => text().references(OrgUnits, #id).nullable()();

  DateTimeColumn get startEntryTime =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();

  DateTimeColumn get finishedEntryTime => dateTime().nullable()();

  TextColumn get formData =>
      text().map(const NullAwareMapConverter()).nullable()();

  // DateTimeColumn get updatedAtClient =>
  //     dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAtClient => dateTime().nullable()();

  //<editor-fold desc=" local states">
  TextColumn get syncState =>
      text().map(const EnumNameConverter(InstanceSyncStatus.values))();

  DateTimeColumn get lastSyncDate => dateTime().nullable()();

  TextColumn get lastSyncMessage => text().nullable()();

  /// is already synced to server
  BoolColumn get isToUpdate => boolean()();

//</editor-fold>
}
