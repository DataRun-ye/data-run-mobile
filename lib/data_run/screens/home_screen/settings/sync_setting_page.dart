// import 'package:datarunmobile/di/injection.dart';
// import 'package:datarunmobile/core/services/user_session_manager.service.dart';
// import 'package:datarunmobile/core/sync_manager/sync_service.provider.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//
// class SyncSettingTab extends HookConsumerWidget {
//   const SyncSettingTab({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userSessionManager = appLocator<UserSessionService>();
//     final selectedInterval = useState(userSessionManager.getSyncInterval());
//
//     return ListView(
//       padding: const EdgeInsets.all(16.0),
//       children: [
//         Text(S.of(context).syncSettings,
//             style: Theme.of(context).textTheme.titleLarge),
//
//         Card(
//           child: ListTile(
//             leading: Icon(
//               MdiIcons.update,
//             ),
//             title: Text(S.of(context).syncInterval),
//             subtitle: DropdownButton<SyncInterval>(
//               value: selectedInterval.value,
//               items: SyncInterval.values.map((interval) {
//                 return DropdownMenuItem(
//                   value: interval,
//                   child: Text(interval.localLabel),
//                 );
//               }).toList(),
//               onChanged: (newInterval) async {
//                 if (newInterval != null) {
//                   await userSessionManager.setSyncInterval(newInterval);
//                   selectedInterval.value = newInterval;
//                 }
//               },
//             ),
//           ),
//         ),
//
//         // const SizedBox(height: 10),
//         //
//         // Card(
//         //   child: ListTile(
//         //     title: Text(S.of(context).lastConfigurationSyncTime),
//         //     subtitle: Text(userSessionManager.lastSyncTime.toString()),
//         //     trailing: FilledButton(
//         //         onPressed: () {
//         //           ref.read(syncServiceProvider.notifier).performSync(
//         //                 onFinish: (message) =>
//         //                     ScaffoldMessenger.of(context).showSnackBar(
//         //                   SnackBar(content: Text(message ?? '')),
//         //                 ),
//         //               );
//         //         },
//         //         child: Text(S.of(context).syncNow)),
//         //   ),
//         // ),
//         // Sync Status Card
//         Card(
//           child: ListTile(
//             leading: Icon(Icons.check_circle,
//                 color: userSessionManager.syncDone ? Colors.green : Colors.red),
//             title: Text(S.of(context).lastSyncStatus),
//             subtitle: Text(userSessionManager.syncDone
//                 ? S.of(context).done
//                 : S.of(context).failed),
//           ),
//         ),
//       ],
//     );
//   }
// }
