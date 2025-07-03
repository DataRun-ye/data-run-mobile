import 'package:auto_route/annotations.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:datarunmobile/ui/common/ui_helpers.dart';
import 'package:datarunmobile/features/startup_splash/presentation/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class SplashView extends StackedView<SplashViewModel> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SplashViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'DATARUN',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(S.of(context).loading,
                    style: const TextStyle(fontSize: 16)),
                horizontalSpaceSmall,
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 6,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  SplashViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SplashViewModel();

  @override
  void onViewModelReady(SplashViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
