import 'package:d2_remote/modules/datarun_shared/sync/call/d2_progress.dart';
import 'package:datarunmobile/app/app.locator.dart';
import 'package:datarunmobile/app/app.router.dart';
import 'package:datarunmobile/core/sync_manager/nmc_worker/sync_progress.provider.dart';
import 'package:datarunmobile/core/sync_manager/nmc_worker/work_info.dart';
import 'package:datarunmobile/core/sync_manager/sync_service.provider.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stacked_services/stacked_services.dart';

class SyncScreen extends ConsumerStatefulWidget {
  const SyncScreen({super.key});

  static const String routeName = '/syncScreen';

  @override
  ConsumerState<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends ConsumerState<SyncScreen> {
  @override
  Widget build(BuildContext context) {
    final syncProgressInfo = ref.watch(syncProgressProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: ColoredBox(
          color: cs.surface,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SyncProgressCircularIndicator(
                  syncProgressInfo: syncProgressInfo),
            ),
          )),
    );
  }

  D2Progress syncingProgress = D2Progress();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sync();
    });
  }

  Future<void> _sync() async {
    final syncService = ref.read(syncServiceProvider.notifier);
    final syncProgressNotifier = ref.read(syncProgressProvider.notifier);

    syncProgressNotifier.update((state) => state.copyWith(
          state: WorkInfoState.RUNNING,
          message: S.of(context).startingSync,
          progress: 0,
        ));

    await syncService.performSync(
      onProgressUpdate: (progress) {
        syncProgressNotifier.update((state) => state.copyWith(
              state: WorkInfoState.RUNNING,
              message: S.of(context).startingSync,
              progress: progress?.percentage ?? 0,
            ));
      },
      onFinish: (message) {
        syncProgressNotifier.update((state) => state.copyWith(
              state: WorkInfoState.SUCCEEDED,
              message: S.of(context).configurationReady,
              progress: 100,
            ));
      },
      onFailure: (message) {
        syncProgressNotifier.update((state) => state.copyWith(
              state: WorkInfoState.FAILED,
              message: message,
              progress: 0,
            ));
      },
    );
    goToMain();
  }

  void goToMain() async {
    final _navigationService = locator<NavigationService>();
    await _navigationService.replaceWithHomeScreen();
    // Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
    //     MaterialPageRoute<void>(
    //         builder: (BuildContext context) => HomeScreen(refresh: true)),
    //     (route) => false);
  }
}

class SyncProgressCircularIndicator extends StatelessWidget {
  const SyncProgressCircularIndicator({
    super.key,
    required this.syncProgressInfo,
  });

  final WorkInfo syncProgressInfo;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CircularPercentIndicator(
      radius: 40.0,
      lineWidth: 3.0,
      animation: true,
      animateFromLastPercent: true,
      percent: syncProgressInfo.progress / 100,
      center: syncProgressInfo.state == WorkInfoState.SUCCEEDED
          ? const Icon(
              Icons.check,
              color: Color(0xffffad30),
              size: 35,
            )
          : Text(
              '${syncProgressInfo.progress}%',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: cs.onSurfaceVariant),
            ),
      footer: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          syncProgressInfo.state != WorkInfoState.SUCCEEDED
              ? syncProgressInfo.message
              : S.of(context).configurationReady,
          style: const TextStyle(fontSize: 13.0, color: Colors.white),
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.transparent,
      progressColor: Colors.amber,
    );
  }
}
