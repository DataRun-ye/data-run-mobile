import 'dart:async';

import 'package:collection/collection.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:datarunmobile/core/sync/model/resource_progress.data.dart';
import 'package:datarunmobile/core/sync/model/resource_state.dart';
import 'package:datarunmobile/core/sync/model/sync_progress.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton()
class SyncProgressNotifier {
  final BehaviorSubject<SyncProgress> _progress =
      BehaviorSubject<SyncProgress>.seeded(SyncProgress.idle());
  final _resourceController = StreamController<ResourceProgress>.broadcast();
  final List<ResourceProgress> _resourceHistory = [];

  Stream<SyncProgress> get progress => _progress.stream;

  Stream<ResourceProgress> get resourceUpdates => _resourceController.stream;

  List<ResourceProgress> get resourceHistory =>
      UnmodifiableListView(_resourceHistory);

  Future<void> wrapOperation({
    required Future<void> Function() operation,
    int totalResources = 1,
  }) async {
    try {
      _updateProgress(SyncProgress.starting(totalResources));
      await operation();
      _updateProgress(SyncProgress.complete());
    } catch (e, stack) {
      _updateProgress(SyncProgress.failed(e));
      _logError(e, stack);
      rethrow;
    }
  }

  Future<T?> trackResource<T>(
    String resourceName,
    Future<T> Function() operation, {
    double weight = 1,
  }) async {
    try {
      _addResourceProgress(ResourceProgress.starting(resourceName));

      final result = await operation();

      _addResourceProgress(ResourceProgress.success(
          resourceName, result is List ? result.length : 0));
      return result;
    } catch (e) {
      _addResourceProgress(ResourceProgress.failure(resourceName, e));
      return null;
      // rethrow;
    }
  }

  void _updateProgress(SyncProgress newProgress) {
    _progress.add(newProgress);
  }

  void _addResourceProgress(ResourceProgress progress) {
    _resourceHistory.add(progress);
    _resourceController.add(progress);
    _updatePercentage(progress);
  }

  void _updatePercentage(ResourceProgress progress) {
    if (progress.state is ResourceStarting) {
      final completed = _resourceHistory
          .where(
              (p) => p.state is ResourceSucceeded || p.state is ResourceFailed)
          .length;

      final total =
          _resourceHistory.where((p) => p.state is! ResourceStarting).length;

      final double percentage = total > 0 ? (completed / total) * 100 : 0;
      _progress.add(SyncProgress.running(percentage));
    }
  }

  void _logError(Object error, StackTrace stack) {
    logError(error.toString());
    debugPrintStack(stackTrace: stack);
  }

  void reset() {
    _resourceHistory.clear();
    _progress.add(SyncProgress.idle());
  }

  @disposeMethod
  void dispose() {
    _progress.close();
    _resourceController.close();
  }
}
