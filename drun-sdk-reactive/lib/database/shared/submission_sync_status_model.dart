import 'package:d_sdk/database/shared/shared.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class SubmissionSyncStatusModel with EquatableMixin {
  final InstanceSyncStatus syncState;
  final int count;

  SubmissionSyncStatusModel({required this.syncState, required this.count});

  @override
  List<Object?> get props => [syncState, count];
}
