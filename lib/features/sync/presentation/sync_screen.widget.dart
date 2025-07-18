// import 'package:d2_remote/modules/datarun_shared/sync/call/d2_progress.dart';
// import 'package:d_sdk/core/sync/d2_progress.dart';
// import 'package:datarun/core/sync_manager/nmc_worker/sync_progress.dart';
// import 'package:datarun/core/sync_manager/nmc_worker/work_info.dart';
// import 'package:datarun/core/sync_manager/sync_service.dart';
// import 'package:datarun/data_run/screens/home_screen/home_screen.widget.dart';
// import 'package:datarun/generated/l10n.dart';
// import 'package:datarun/utils/mass_utils/utils.dart';
// import 'package:datarun/utils/navigator_key.dart';
// import 'package:datarunmobile/commons/helpers/colors.dart';
// import 'package:datarunmobile/core/sync_manager/nmc_worker/sync_progress.provider.dart';
// import 'package:datarunmobile/core/sync_manager/sync_service.provider.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
//
// class SyncScreen extends ConsumerStatefulWidget {
//   const SyncScreen({super.key});
//
//   static const String routeName = '/syncScreen';
//
//   @override
//   ConsumerState<SyncScreen> createState() => _SyncScreenState();
// }
//
// class _SyncScreenState extends ConsumerState<SyncScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final syncProgressInfo = ref.watch(syncProgressProvider);
//
//     return Scaffold(
//       body: ColoredBox(
//           color: convertHexStringToColor('#2C98F0')!,
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SyncProgressCircularIndicator(
//                   syncProgressInfo: syncProgressInfo),
//             ),
//           )),
//     );
//   }
//
//   D2Progress syncingProgress = D2Progress();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _sync();
//     });
//   }
//
//   Future<void> _sync() async {
//     final syncService = ref.read(syncServiceProvider.notifier);
//     final syncProgressNotifier = ref.read(syncProgressProvider.notifier);
//
//     syncProgressNotifier.update((state) => state.copyWith(
//           state: WorkInfoState.RUNNING,
//           message: S.of(context).startingSync,
//           progress: 0,
//         ));
//
//     await syncService.performSync(
//       onProgressUpdate: (progress) {
//         syncProgressNotifier.update((state) => state.copyWith(
//               state: WorkInfoState.RUNNING,
//               message: S.of(context).startingSync,
//               progress: progress?.percentage ?? 0,
//             ));
//       },
//       onFinish: (message) {
//         syncProgressNotifier.update((state) => state.copyWith(
//               state: WorkInfoState.SUCCEEDED,
//               message: S.of(context).configurationReady,
//               progress: 100,
//             ));
//       },
//       onFailure: (message) {
//         syncProgressNotifier.update((state) => state.copyWith(
//               state: WorkInfoState.FAILED,
//               message: message,
//               progress: 0,
//             ));
//       },
//     );
//     goToMain();
//   }
//
//   void goToMain() {
//     Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
//         MaterialPageRoute<void>(
//             builder: (BuildContext context) => HomeScreen(refresh: true)),
//         (route) => false);
//   }
// }
