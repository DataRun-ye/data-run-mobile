import 'package:datarunmobile/core/sync_manager/sync_progress_global_state.dart';
import 'package:datarunmobile/features/common_ui_element/common/app_colors.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SyncProgressCircularIndicator extends StatelessWidget {
  const SyncProgressCircularIndicator({
    super.key,
    required this.syncProgressInfo,
  });

  final SyncProgressGlobalState? syncProgressInfo;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return CircularPercentIndicator(
      radius: 40.0,
      lineWidth: 9.0,
      animation: true,
      animateFromLastPercent: true,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.transparent,
      progressColor: cs.inversePrimary,
      percent: ((syncProgressInfo?.overallPercentage ?? 0) / 100),
      center: (syncProgressInfo?.completed ?? false)
          ? const Icon(
              Icons.check,
              color: DColors.Orange600,
              size: 40,
            )
          : Text(
              syncProgressInfo?.overallState.isSuccess == false
                  ? '${syncProgressInfo?.completedResources}/${syncProgressInfo?.totalResources}'
                  : S.of(context).configurationReady,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: cs.onPrimary),
            ),
    );
  }
}
