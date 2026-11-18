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
      // Summed progress can land a hair above 100 (1.0000000000000002), and
      // the indicator throws outside 0..1.
      percent: ((syncProgressInfo?.overallPercentage ?? 0) / 100)
          .clamp(0.0, 1.0)
          .toDouble(),
      center: (syncProgressInfo?.completed ?? false)
          ? Icon(
              syncProgressInfo?.overallState.isSuccess == true
                  ? Icons.check
                  : Icons.error_outline,
              color: syncProgressInfo?.overallState.isSuccess == true
                  ? DColors.Orange600
                  : cs.error,
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
