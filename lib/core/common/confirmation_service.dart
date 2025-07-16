import 'dart:async';

import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ConfirmationService {
  Future<bool> confirmAndExecute({
    required BuildContext context,
    required String title,
    required String body,
    required String confirmLabel,
    required FutureOr<void> Function() action,
  }) =>
      withConfirmation(
        context: context,
        title: title,
        body: body,
        confirmLabel: confirmLabel,
        onConfirmed: action,
      );
}

/// Shows a confirmation dialog and, if confirmed, runs [onConfirmed].
/// Returns true if the action ran, false otherwise.
Future<bool> withConfirmation({
  required BuildContext context,
  required String title,
  required String body,
  required String confirmLabel,
  required FutureOr<void> Function() onConfirmed,
}) async {
  final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(S.of(context).cancel)),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(confirmLabel)),
          ],
        ),
      ) ??
      false;

  if (confirmed) {
    await onConfirmed();
    return true;
  }
  return false;
}
