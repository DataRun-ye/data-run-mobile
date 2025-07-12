import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final confirmationProvider = Provider<ConfirmationService>((ref) {
  return ConfirmationService(ref);
});

class ConfirmationService {

  ConfirmationService(this.ref);
  final Ref ref;

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
            child: Text('CANCEL')),
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
