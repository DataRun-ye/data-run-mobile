// import 'dart:math';
//
// import 'package:datarun/core/element_instance/element_state.dart';
// import 'package:datarun/core/element_instance/form_state.dart';
// import 'package:datarun/core/form/common/form_meta.dart';
//
// class FormStateRepository {
//   final List<Map<String, ElementStat<dynamic>>> _history = [];
//   final Set<String> modifiedFields = {};
//   final FormMeta meta = FormMeta(meta: {});
//
//   final _stateController = BehaviorSubject<FormState>();
//
//   Stream<FormState> get stateStream => _stateController.stream;
//
//   void commitUpdate(FormState newState) {
//     _history.add(newState);
//     _stateController.add(newState);
//   }
//
//   FormState rollback(int stepsBack) {
//     final index = max(0, _history.length - 1 - stepsBack);
//     return _history[index];
//   }
// }
