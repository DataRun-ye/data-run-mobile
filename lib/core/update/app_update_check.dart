import 'dart:async';
import 'dart:io' show Platform;

import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

/// What the app does with Google Play's answer about updates.
enum AppUpdateAction { none, offer, require, install }

/// Releases rolled out with this in-app update priority or higher must be
/// installed before the app can be used. Priority (0-5) can only be set through
/// the Google Play Developer API when the release is rolled out; releases
/// published from the Play Console have priority 0.
const int requiredUpdatePriority = 4;

AppUpdateAction decideAppUpdate({
  required UpdateAvailability availability,
  required InstallStatus installStatus,
  required int priority,
  required bool immediateAllowed,
  required bool flexibleAllowed,
}) {
  if (installStatus == InstallStatus.downloaded) {
    return AppUpdateAction.install;
  }
  if (availability == UpdateAvailability.developerTriggeredUpdateInProgress) {
    return AppUpdateAction.require;
  }
  if (availability != UpdateAvailability.updateAvailable) {
    return AppUpdateAction.none;
  }
  if (priority >= requiredUpdatePriority && immediateAllowed) {
    return AppUpdateAction.require;
  }
  return flexibleAllowed ? AppUpdateAction.offer : AppUpdateAction.none;
}

/// Asks Google Play once per app start whether a newer version exists, then
/// offers it, requires it, or asks to restart into a downloaded one; see
/// [decideAppUpdate]. Installs that did not come from Google Play, and phones
/// without a connection, skip the check silently.
class AppUpdateCheck extends StatefulWidget {
  const AppUpdateCheck({super.key, required this.child});

  final Widget child;

  static bool _checkedThisRun = false;

  @override
  State<AppUpdateCheck> createState() => _AppUpdateCheckState();
}

class _AppUpdateCheckState extends State<AppUpdateCheck> {
  StreamSubscription<InstallStatus>? _installStates;

  @override
  void initState() {
    super.initState();
    if (!AppUpdateCheck._checkedThisRun && Platform.isAndroid) {
      AppUpdateCheck._checkedThisRun = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _check());
    }
  }

  Future<void> _check() async {
    try {
      final info = await InAppUpdate.checkForUpdate();
      final action = decideAppUpdate(
        availability: info.updateAvailability,
        installStatus: info.installStatus,
        priority: info.updatePriority,
        immediateAllowed: info.immediateUpdateAllowed,
        flexibleAllowed: info.flexibleUpdateAllowed,
      );
      switch (action) {
        case AppUpdateAction.none:
          return;
        case AppUpdateAction.require:
          await InAppUpdate.performImmediateUpdate();
        case AppUpdateAction.offer:
          _installStates ??= InAppUpdate.installUpdateListener.listen((status) {
            if (status == InstallStatus.downloaded) _offerRestart();
          });
          await InAppUpdate.startFlexibleUpdate();
        case AppUpdateAction.install:
          _offerRestart();
      }
    } catch (error) {
      logInfo('In-app update check skipped: $error');
    }
  }

  void _offerRestart() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(days: 1),
        content: Text(S.of(context).updateReadyToInstall),
        action: SnackBarAction(
          label: S.of(context).restartToUpdate,
          onPressed: InAppUpdate.completeFlexibleUpdate,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _installStates?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
