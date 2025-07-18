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
      lineWidth: 3.0,
      animation: true,
      animateFromLastPercent: true,
      percent: ((syncProgressInfo?.overallPercentage ?? 0) / 100),
      center: (syncProgressInfo?.overallState.isSuccess ?? false)
          ? const Icon(
              Icons.check,
              color: DColors.Orange600,
              size: 35,
            )
          : Text(
              '${(syncProgressInfo?.overallPercentage ?? 0).round()}%',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
      footer: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          syncProgressInfo?.overallState.isSuccess == false
              ? '${syncProgressInfo?.completedResources}/${syncProgressInfo?.totalResources}'
              : S.of(context).configurationReady,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize: 13.0),
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.transparent,
      progressColor: cs.primary,
    );
  }
}
