// import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
// import 'package:datarunmobile/data_run/screens/form/element/members/form_element_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:reactive_forms/reactive_forms.dart';
//
// FormElementHook useFormElement(FormElementInstance<dynamic> formElement,
//     AbstractControl<dynamic> elementControl) {
//   final elementPropertiesSnapshot = useStream(formElement.propertiesChanged);
//
//   useEffect(() {
//     if (elementPropertiesSnapshot.hasData) {
//       final elementState = elementPropertiesSnapshot.data!;
//       if (formElement.hidden) {
//         elementControl.reset(disabled: true, emitEvent: false);
//       } else {
//         elementControl.markAsEnabled();
//         if (formElement.mandatory) {
//           elementControl.setValidators(
//               [...elementControl.validators]..add(Validators.required));
//         }
//
//         if (formElement.hasErrors) {
//           elementControl.setErrors(elementState.errors);
//         }
//
//         elementControl.markAsTouched();
//       }
//     }
//   }, [elementPropertiesSnapshot.data]);
//
//   return FormElementHook(
//     elementPropertiesSnapshot: elementPropertiesSnapshot,
//   );
// }
//
// class FormElementHook {
//   final AsyncSnapshot<FormElementState> elementPropertiesSnapshot;
//
//   FormElementHook({required this.elementPropertiesSnapshot});
// }
