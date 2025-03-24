// import 'package:d_sdk/core/config/server_config.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:d_sdk/database/data_base_connector.dart';
// import 'package:datarunmobile/core/database/platform/platform.dart';
//
// class EncryptedDataBaseManager implements AppDatabaseConnector {
//   @override
//   Future<AppDatabase> connectForUser({
//     required String userId,
//     required ServerConfig server,
//   }) async {
//     final databaseName = '${server.environment.name}_$userId';
//     return AppDatabase(e: Platform.createDatabaseConnection(databaseName));
//   }
// }
