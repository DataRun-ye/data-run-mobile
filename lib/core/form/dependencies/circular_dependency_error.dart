import 'package:d2_remote/core/datarun/exception/exception.dart';

class CircularDependencyError extends DException {
  CircularDependencyError(this.fieldId, this.evaluationStack)
      : super('Field:$fieldId',
            'Evaluation Stace: ${evaluationStack.toString()}');

  final String fieldId;
  final List<String> evaluationStack;
}
