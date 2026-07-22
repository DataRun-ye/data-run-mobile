import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/sync/sync_scheduler.dart';
import 'package:datarunmobile/features/common_ui_element/common/ui_helpers.dart';
import 'package:datarunmobile/features/startup/application/startup_coordinator.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static String get path => '/splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final StartupCoordinator _coordinator = StartupCoordinator(
    authManager: appLocator<AuthManager>(),
    syncScheduler: appLocator<SyncScheduler>(),
    navigationService: appLocator<NavigationService>(),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _coordinator.run());
  }

  @override
  Widget build(BuildContext context) {
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
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: cs.surface),
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
}
