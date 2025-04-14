// import 'package:async/async.dart';
// import 'package:sqflite/sqflite.dart';
// import 'dart:async';
// import 'dart:io';
//
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite_sqlcipher/sqflite.dart' as cipher;
//
// class DDatabaseManager {
//   final int version = 1;
//   String databaseName = 'flutter_database.db';
//   bool inMemory = false;
//   DatabaseFactory? databaseFactory;
//   String phrase = 'e@ar3-0Fd!g34Ds-3rat3d#Str4r3&-Sdk1abl3';
//
//   static final DDatabaseManager _databaseInstance =
//       new DDatabaseManager._internal();
//
//   static Database? _database;
//   final _initDatabaseMemoizer = AsyncMemoizer<Database>();
//
//   factory DDatabaseManager({
//     String? databaseName,
//     bool? inMemory,
//     DatabaseFactory? databaseFactory,
//     String? phrase,
//   }) {
//     if (databaseName != null) {
//       _databaseInstance.databaseName = databaseName;
//     }
//
//     if (inMemory != null) {
//       _databaseInstance.inMemory = inMemory;
//     }
//
//     if (phrase != null) {
//       _databaseInstance.phrase = phrase;
//     }
//
//     _databaseInstance.databaseFactory = databaseFactory;
//
//     return _databaseInstance;
//   }
//
//   DDatabaseManager._internal();
//
//   static DDatabaseManager get instance => _databaseInstance;
//
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database as Database;
//     }
//
//     return await _initDatabaseMemoizer.runOnce(() async {
//       return await initializeDatabase();
//     });
//   }
//
//   initializeDatabase() async {
//     if (this.databaseFactory != null) {
//       // Use persistent database file for Windows instead of in-memory
//       // the current working directory of the project folder (when developing)
//       // or the executable directory when running from a release build;
//       final currentDir = Directory.current.path;
//       // String customPath = join(currentDir, databaseName + '.db');
//
//       final customDir = Directory(currentDir);
//       if (!await customDir.exists()) {
//         await customDir.create(recursive: true);
//       }
//
//       final path = join(currentDir, databaseName + '.db');
//
//       // return await databaseFactory!.openDatabase(path,
//       //     options: OpenDatabaseOptions(
//       //       version: version,
//       //       onCreate: _createDatabase,
//       //       onConfigure: _onConfigure,
//       //     ));
//       var database = inMemory
//           ? await openDatabase(
//               inMemoryDatabasePath,
//               onConfigure: _onConfigure, /*password: phrase*/
//             )
//           : await openDatabase(
//               path,
//               version: version,
//               onCreate: _createDatabase,
//               onConfigure: _onConfigure, /*password: phrase*/
//             );
//       return database;
//     }
//
//     // if (this.databaseFactory != null) {
//     //   return databaseFactory?.openDatabase(inMemoryDatabasePath);
//     // }
//     Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, databaseName + '.db');
//
//     var database = inMemory
//         ? await cipher.openDatabase(inMemoryDatabasePath,
//             onConfigure: _onConfigure, password: phrase)
//         : await cipher.openDatabase(path,
//             version: version,
//             onCreate: _createDatabase,
//             onConfigure: _onConfigure,
//             password: phrase);
//     return database;
//   }
//
//   _onConfigure(Database db) async {
//     // Add support for cascade delete
//     await db.execute("PRAGMA foreign_keys = OFF");
//
//     // Set the encryption key for the database
//     // db.execute("PRAGMA key = $phrase;");
//   }
//
//   void _createDatabase(Database database, int version) async {}
//
//   closeDatabase() async {
//     if (_database != null) {
//       await _database!.close();
//     }
//   }
// }
