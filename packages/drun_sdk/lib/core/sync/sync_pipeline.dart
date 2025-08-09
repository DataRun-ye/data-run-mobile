// import 'dart:async';
//
// import 'package:d_sdk/core/sync/sync_command.dart';
// import 'package:drift/drift.dart';
//
// /// Emits either SnapshotFetch or DeltaFetch actions
// final versionCheck = StreamTransformer<SyncTrigger, FetchAction>.fromHandlers(
//   handleData: (trigger, sink) async {
//     final serverVersion = await remote.fetchCurrentVersion();
//     if (trigger.localVersion == null) {
//       sink.add(SnapshotFetch());
//     } else if (serverVersion > trigger.localVersion!) {
//       sink.add(DeltaFetch(since: trigger.localVersion!));
//     } else {
//       sink.add(NoOp());
//     }
//   },
// );
//
// /// Performs HTTP call based on action
// final fetchStage = StreamTransformer<FetchAction, RawJson>.fromHandlers(
//   handleData: (action, sink) async {
//     switch (action) {
//       case SnapshotFetch _:
//         sink.add(await remote.fetchSnapshotJson());
//         break;
//       case DeltaFetch d:
//         sink.add(await remote.fetchDeltaJson(d.since));
//         break;
//       case NoOp _:
//         sink.add(''); // or skip
//         break;
//     }
//   },
// );
//
// /// Parses, diffs, transforms to domain
// final parseAndTransform = StreamTransformer<RawJson, List<Insertable<DataClass>>>.fromHandlers(
//   handleData: (json, sink) {
//     final parsed = jsonDecode(json) as List<Map<String, dynamic>>;
//     // if server didn’t pre‑diff, diff here
//     final models = parsed.map((m) => DomainModel.fromJson(m)).toList();
//     sink.add(models);
//   },
// );
//
// /// Writes to DB in batch (on a separate isolate)
// final writeStage = StreamTransformer<List<DomainModel>, SyncResult>.fromHandlers(
//   handleData: (models, sink) async {
//     final result = await compute(_batchWrite, models);
//     sink.add(result);
//   },
// );
//
// /// Your helper that runs in an isolate
// SyncResult _batchWrite(List<DomainModel> models) {
//   final db = DriftDatabase(); // or injected
//   return db.transaction(() {
//     for (var m in models) {
//       db.upsertMetadata(m);
//     }
//     return SyncResult.success();
//   });
// }