import 'dart:io';

import 'package:d_sdk/core/util/user_file_manager.dart';
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

// class PlatformInterface {
//   static QueryExecutor createDatabaseConnection(String userId) {
//     return LazyDatabase(() async {
//       final file = await rSdkLocator<UserFileManager>(param1: userId)
//           .getUserFile('db_user_$userId.db');
//       return NativeDatabase(file);
//     });
//   }
// }
//   static QueryExecutor _openDatabase(String databaseName) {
//     return LazyDatabase(() async {
//       final appDir = await getApplicationDocumentsDirectory();
//       final dbPath = p.join(
//         appDir.path,
//         'databases',
//         '$databaseName.enc.sqlite',
//       );
//
//       return NativeDatabase.createInBackground(
//         File(dbPath),
//         isolateSetup: () async {
//           open
//             ..overrideFor(OperatingSystem.android, openCipherOnAndroid)
//             ..overrideFor(OperatingSystem.linux,
//                 () => DynamicLibrary.open('libsqlcipher.so'))
//             ..overrideFor(OperatingSystem.windows,
//                 () => DynamicLibrary.open('sqlcipher.dll'));
//         },
//         setup: (db) {
//           // Check that we're actually running with SQLCipher by quering the
//           // cipher_version pragma.
//           final result = db.select('pragma cipher_version');
//           if (result.isEmpty) {
//             throw UnsupportedError(
//               'This database needs to run with SQLCipher, but that library is '
//               'not available!',
//             );
//           }
//
//           // Then, apply the key to encrypt the database. Unfortunately, this
//           // pragma doesn't seem to support prepared statements so we inline the
//           // key.
//           final escapedKey = _encryptionPassword.replaceAll("'", "''");
//           db.execute("pragma key = '$escapedKey'");
//
//           // Test that the key is correct by selecting from a table
//           db.execute('select count(*) from sqlite_master');
//         },
//       );
//     });
//   }
// }

// const _encryptionPassword = 'drift.example.unsafe_password';
