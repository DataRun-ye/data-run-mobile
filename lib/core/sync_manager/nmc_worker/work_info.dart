import 'package:d_sdk/core/sync/d2_progress.dart';
import 'package:equatable/equatable.dart';

class WorkInfo with EquatableMixin {
  WorkInfo(
      {this.progress = 0,
      this.state = WorkInfoState.ENQUEUED,
      this.message = ''});

  final String message;
  final WorkInfoState state;
  final int progress;

  WorkInfo copyWith({String? message, WorkInfoState? state, int? progress}) {
    return WorkInfo(
        progress: progress ?? this.progress,
        state: state ?? this.state,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [message, state, progress];
}
