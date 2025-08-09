// import 'dart:async';
//
// import 'package:d_sdk/core/sync/model/sync_config.dart';
// import 'package:d_sdk/core/sync/sync_command.dart';
// import 'package:d_sdk/datasource/abstract_datasource.dart';
// import 'package:d_sdk/di/injection.dart';
// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
//
// /// ---------- Data Sources ----------
//
// /// RemoteDataSource: fetches metadata from server
// abstract class RemoteDataSource {
//   Future<int> fetchCurrentVersion();
//
//   Future<List<Map<String, dynamic>>> fetchWithETag(
//       String endpoint, String? etag);
// }
//
// /// LocalDataSource: reads/writes metadata locally
// abstract class LocalDataSource {
//   int? get localVersion;
//
//   Future<void> saveVersion(int version);
//
//   Future<void> upsertBatch(String endpoint, List<Map<String, dynamic>> items);
// }
//
// /// ---------- Sync Orchestrator ----------
//
// class SyncOrchestrator {
//   SyncOrchestrator()
//       : _dataSourceMap = IMap.fromIterable(
//           rSdkLocator.getAll<AbstractDatasource<dynamic>>(),
//           keyMapper: (resource) => resource.resourceName,
//           valueMapper: (resource) => resource,
//         ) {
//     _cmdController.stream
//         .where((c) => c is StartSync)
//         .cast<StartSync>()
//         .listen((cmd) => _runSync(cmd));
//   }
//
//   /// <resourcePath, endpoint implementation of DataSource>
//   /// dataSource handles both local and remote
//   final IMap<String, AbstractDatasource<dynamic>> _dataSourceMap;
//
//   final _cmdController = StreamController<SyncCommand>();
//   final _eventController = StreamController<SyncEvent>.broadcast();
//
//   /// Exposed to UI or background task
//   void handle(SyncCommand cmd) => _cmdController.add(cmd);
//
//   /// UI/background listens here
//   Stream<SyncEvent> get events => _eventController.stream;
//
//   Future<void> _runSync(StartSync cmd) async {
//     _eventController.add(SyncInProgress());
//     try {
//       final dataSource = _dataSourceMap.get(cmd.resourceName);
//
//       final serverVersion =
//           await _dataSourceMap.get(cmd.resourceName)!.syncWithRemote(progressCallback: );
//       // 2) Compare with local
//       if (serverVersion > (cmd.localVersion ?? -1)) {
//         // 3) Perform per-endpoint ETag sync (later)
//         _eventController.add(SyncCompleted(serverVersion));
//         await local.saveVersion(serverVersion);
//       } else {
//         // nothing to do
//         _eventController.add(SyncCompleted(cmd.localVersion ?? serverVersion));
//       }
//     } catch (e) {
//       _eventController.add(SyncFailed(e));
//     }
//   }
// }
//
// /// ---------- Usage Example ----------
//
// void main() {
//   // TODO: provide implementations for remote & local
//   final orchestrator = SyncOrchestrator(
//     remote: /* your RemoteDataSource impl */ throw UnimplementedError(),
//     local: /* your LocalDataSource impl  */ throw UnimplementedError(),
//   );
//
//   // Listen to sync events
//   orchestrator.events.listen((event) {
//     if (event is SyncInProgress) print('Sync started...');
//     if (event is SyncCompleted)
//       print('Sync completed to version: \${event.newVersion}');
//     if (event is SyncFailed) print('Sync failed: \${event.error}');
//   });
//
//   // Trigger a sync
//   orchestrator.handle(StartSync(orchestrator.local.localVersion));
// }
