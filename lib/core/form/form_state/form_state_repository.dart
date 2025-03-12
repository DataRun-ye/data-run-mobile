// import 'dart:math';
//
// import 'package:datarunmobile/core/element_instance/element_state.dart';
// import 'package:datarunmobile/core/element_instance/form_state.data.dart';
// import 'package:datarunmobile/core/form/common/form_meta.dart';
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
