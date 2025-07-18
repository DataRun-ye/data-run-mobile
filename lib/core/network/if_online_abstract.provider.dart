import 'dart:async';

import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/network/reactive_connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'if_online_abstract.provider.g.dart';

/// a StreamProvider that emits true/false as the internet comes and goes
@riverpod
Stream<bool> isOnline(Ref ref) {
  final conn = appLocator<ConnectivityService>();
  return conn.onStatusChange
      .map((status) => status == InternetStatus.connected);
}

/// Example:
/// ```dart
/// final didSubmit = await ifOnlineDo(
///   ref: ref,
///   context: context,
///   action: () => formController.save(),
/// );
/// ```
Future<bool> ifOnlineDoAction({
  required BuildContext context,
  required FutureOr<void> Function() action,
  FutureOr<void> Function()? elseAction,
  bool showAlertDialog = true,
  String offlineMessage = 'No internet connection. Please try again later.',
}) async {
  final conn = appLocator<ConnectivityService>();
  if (await conn.isOnline) {
    await action();
    return true;
  } else {
    if (showAlertDialog) {
      await showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Offline'),
          content: Text(offlineMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    if (elseAction != null) {
      await elseAction();
    }
  }

  return false;
}
