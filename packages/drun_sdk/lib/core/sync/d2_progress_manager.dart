import 'd2_progress.dart';

// part 'd2_progress_manager.g.dart';

// @riverpod
// D2ProgressManager d2ProgressManager(D2ProgressManagerRef ref, int? totalCalls) {
//   return D2ProgressManager(totalCalls);
// }

class D2ProgressManager {
  D2ProgressManager({int? totalCalls})
      : _progress = D2Progress.empty(totalCalls);

  D2Progress _progress;

  D2Progress getProgress() {
    return _progress;
  }

  // set process(D2Progress process) {
  //   _progress = process;
  // }

  D2Progress increaseProgress(
      {required String resourceName,
      required bool isComplete,
      String? message,
      int? percentage}) {
    _progress = _progress.copyWith(
        doneCalls: _progress.doneCalls?.add(resourceName),
        isComplete: isComplete,
        message: message,
        percentage: percentage);
    return _progress;
  }

// D2Progress increaseProgressFromRequestProgress(
//         RequestProgress requestProgress) =>
//     increaseProgress(
//         resourceName: requestProgress.resourceName,
//         message: requestProgress.message,
//         isComplete: requestProgress.percentage == 100,
//         percentage: requestProgress.percentage);
}
