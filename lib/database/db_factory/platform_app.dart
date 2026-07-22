import 'dart:io';

import 'package:datarunmobile/core/util/user_file_manager.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

class PlatformInterface {
  static QueryExecutor createDatabaseConnection(String userId) {
    return LazyDatabase(() async {
      // final currentDir = Directory.current.path;
      // final customDir = Directory(currentDir);
      // if (!await customDir.exists()) {
      //   await customDir.create(recursive: true);
      // }
      // final dbPath = p.join(
      //   currentDir,
      //   'datarun_$userId.db',
      // );
      // final file = File(dbPath);

      final File file =
          await UserFileManager(userId).getUserFile('datarun_$userId.db');

      // return NativeDatabase(file);

      // This is the key change: open the NativeDatabase in a background isolate.
      // return NativeDatabase.createInBackground(file);
      return NativeDatabase.createBackgroundConnection(file);
    });
  }
}
