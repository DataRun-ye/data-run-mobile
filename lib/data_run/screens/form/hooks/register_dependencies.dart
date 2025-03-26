import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:datarunmobile/data_run/form/form_dependency_manager.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';

void useRegisterDependencies<E extends FormElementInstance<dynamic>>(
    E element) {
  final binder =
      useMemoized(() => DependencyBinder(element: element), [element]);

  useEffect(() {
    binder.bind();
    return binder.dispose;
  }, [binder]);

  // /// bind dependencies
  // useEffect(() {
  //   logDebug('run effect, re-evaluating state: ${element.name}');
  //   final currentState = element.elementState.value.copyWith();
  //   element.evaluateDependencies();
  //   if (element.elementState != currentState) {
  //     logDebug('effect changed state of: ${element.name}');
  //     elementState.value = element.elementState;
  //     element.elementControl?.updateValueAndValidity();
  //   }
  //   return null;
  // }, [element.elementContext]);
  //
  // return elementState;
}
