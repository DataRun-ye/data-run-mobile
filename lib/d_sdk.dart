library d_sdk;

import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/dbManager.dart';
import 'package:datarunmobile/di/injection.dart';

class DSdk {
  static DbManager get dbManager => rSdkLocator<DbManager>();

  static AppDatabase get db => dbManager.db;
}
