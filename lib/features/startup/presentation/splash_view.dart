import 'package:datarunmobile/features/common_ui_element/common/ui_helpers.dart';
import 'package:datarunmobile/features/startup/presentation/splash_viewmodel.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StackedView<StartupViewModel> {
  const SplashView({Key? key}) : super(key: key);
  static String get path => '/splash';

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).datarun,
                style: TextStyle(
                    fontSize: 40, fontWeight: FontWeight.w900, color: cs.surface),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(S.of(context).checkingSession,
                      style: TextStyle(fontSize: 16, color: cs.surfaceDim)),
                  horizontalSpaceSmall,
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.orangeAccent[400]!),
                      strokeWidth: 6,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
