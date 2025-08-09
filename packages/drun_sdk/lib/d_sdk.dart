library d_sdk;

import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/di/injection.dart';

import 'database/dao/dao.dart';

class DSdk {
  static DbManager get dbManager => rSdkLocator<DbManager>();

  static AppDatabase get db => dbManager.db;

  // db DAOs:
  static ActivitiesDao get activity => db.activitiesDao;

  static AssignmentsDao get assignment => db.assignmentsDao;

  static OrgUnitsDao get orgUnit => db.orgUnitsDao;

  static TeamsDao get team => db.teamsDao;

  static UsersDao get user => db.usersDao;

  @Deprecated("use DataFormTemplateVersionsDao")
  static FormTemplateVersionsDao get formVersion => db.formTemplateVersionsDao;

  static FormTemplateVersionsDao get formTemplate => db.formTemplateVersionsDao;

  static DataInstancesDao get dataInstance => db.dataInstancesDao;

  static DataElementsDao get dataElement => db.dataElementsDao;

  static DataOptionSetsDao get dataOptionSet => db.dataOptionSetsDao;

  static DataValuesDao get dataValue => db.dataValuesDao;

  static RepeatInstancesDao get repeatInstance => db.repeatInstancesDao;
}
