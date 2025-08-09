import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

enum WorkInfoState {
  ENQUEUED,
  RUNNING,
  SUCCEEDED,
  FAILED,
  BLOCKED,
  CANCELLED;

  bool isFinished() {
    return this == SUCCEEDED || this == FAILED || this == CANCELLED;
  }
}

class D2Progress with EquatableMixin {
  D2Progress({
    String? message,
    String? serverMessage,
    this.progressState = WorkInfoState.ENQUEUED,
    bool? isComplete,
    this.totalCalls,
    int? percentage,
    IList<String>? doneCalls,
  })  : message = message ?? '',
        serverMessage = serverMessage ?? '',
        isComplete = isComplete ?? false,
        percentage = percentage ?? 0,
        doneCalls = IList.orNull(doneCalls) ?? IList();

  static D2Progress empty(int? totalCalls) {
    if (totalCalls != null && totalCalls < 0) {
      throw ArgumentError('Negative total calls');
    }
    return D2Progress(
        progressState: WorkInfoState.CANCELLED,
        isComplete: totalCalls != null && totalCalls == 0,
        totalCalls: totalCalls,
        doneCalls: IList());
  }

  final String? message;
  final String? serverMessage;
  final WorkInfoState progressState;
  final bool? isComplete;
  final int? totalCalls;
  final IList<String>? doneCalls;

  D2Progress copyWith({
    String? message,
    WorkInfoState? progressState,
    String? serverMessage,
    bool? isComplete,
    int? totalCalls,
    int? percentage,
    IList<String>? doneCalls,
  }) {
    return D2Progress(
        message: message ?? this.message,
        progressState: progressState ?? this.progressState,
        serverMessage: serverMessage ?? this.serverMessage,
        isComplete: isComplete ?? this.isComplete,
        totalCalls: totalCalls ?? this.totalCalls,
        percentage: percentage ?? this.percentage,
        doneCalls: IList.orNull(doneCalls) ?? this.doneCalls);
  }

  String? get lastCall {
    if (doneCalls?.isNotEmpty ?? false) {
      return doneCalls![doneCalls!.length - 1];
    }
    return null;
  }

  final int percentage;

  @override
  List<Object?> get props => [
        message,
        serverMessage,
        progressState,
        isComplete,
        totalCalls,
        doneCalls,
        percentage
      ];
}
