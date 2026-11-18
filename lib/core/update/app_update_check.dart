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
///
/// The restart offer is a bar on the screen this widget wraps (the home
/// screen), not a snack bar over whatever screen is open: restarting drops
/// anything not yet saved, so it is offered only where no form is open.
class AppUpdateCheck extends StatefulWidget {
  const AppUpdateCheck({super.key, required this.child});

  final Widget child;

  static bool _checkedThisRun = false;

  @override
  State<AppUpdateCheck> createState() => AppUpdateCheckState();
}

class AppUpdateCheckState extends State<AppUpdateCheck> {
  StreamSubscription<InstallStatus>? _installStates;
  bool _updateReady = false;

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
            if (status == InstallStatus.downloaded) offerRestart();
          });
          await InAppUpdate.startFlexibleUpdate();
        case AppUpdateAction.install:
          offerRestart();
      }
    } catch (error) {
      logInfo('In-app update check skipped: $error');
    }
  }

  /// Shows the restart bar once Google Play has downloaded the update.
  @visibleForTesting
  void offerRestart() {
    if (!mounted || _updateReady) return;
    setState(() => _updateReady = true);
  }

  Future<void> _restart() async {
    try {
      await InAppUpdate.completeFlexibleUpdate();
    } catch (error) {
      logInfo('In-app update restart failed: $error');
    }
  }

  @override
  void dispose() {
    _installStates?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: widget.child),
        if (_updateReady) UpdateReadyBar(onRestart: _restart),
      ],
    );
  }
}

/// "Update ready - RESTART", at the bottom of the home screen.
class UpdateReadyBar extends StatelessWidget {
  const UpdateReadyBar({super.key, required this.onRestart});

  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.inverseSurface,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 8, 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                S.of(context).updateReadyToInstall,
                style: TextStyle(color: colors.onInverseSurface),
              ),
            ),
            TextButton(
              onPressed: onRestart,
              child: Text(
                S.of(context).restartToUpdate,
                style: TextStyle(color: colors.inversePrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
