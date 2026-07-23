import 'dart:async';

import 'package:datarunmobile/core/exception/session_expired_exception.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SessionOperationTracker {
  var _activeOperations = 0;
  var _acceptingOperations = true;
  Completer<void>? _idleCompleter;

  Future<T> track<T>(Future<T> Function() operation) async {
    if (!_acceptingOperations) {
      throw SessionExpiredException('The active session is ending');
    }

    _activeOperations++;
    try {
      return await operation();
    } finally {
      _activeOperations--;
      if (_activeOperations == 0) {
        _idleCompleter?.complete();
        _idleCompleter = null;
      }
    }
  }

  Future<void> stopAndWaitForIdle() {
    _acceptingOperations = false;
    if (_activeOperations == 0) return Future.value();
    return (_idleCompleter ??= Completer<void>()).future;
  }

  void resume() {
    if (_activeOperations != 0) {
      throw StateError('Cannot start a session while operations are active');
    }
    _acceptingOperations = true;
  }
}
