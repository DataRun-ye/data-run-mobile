// import 'package:d2_remote/modules/datarun/form/shared/dynamic_form_field.entity.dart';
// import 'package:d_sdk/database/shared/shared.dart';
// import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_element_model/form_element_model.dart';
//
// /// from template wit value, use [FormTemplateControlFactory]
// /// for adding new control with saved value
//
// /// Form Elements Factory form elements
// /// ([FieldInstance], [SectionInstance], [RepeatSectionInstance],
// /// and [RepeatItemInstance])
// class FromElementModelFactory {
//   static Map<String, FormElementModel<dynamic>> formElementsModels(
//       List<FieldTemplate> templates, Map<String, dynamic>? initialValue) {
//     final Map<String, FormElementModel<dynamic>> elements = {};
//     for (var template in templates) {
//       elements[template.name] =
//           createElementModel(template, initialValue: initialValue?[template.name]);
//     }
//     return elements;
//   }
//
//   static FormElementModel<dynamic> createElementModel(FieldTemplate elementTemplate,
//       {dynamic initialValue}) {
//     if (elementTemplate.type.isSection) {
//       return createSectionElementModel(elementTemplate, initialValue: initialValue);
//     } else if (elementTemplate.type.isRepeatSection) {
//       return createRepeatElementModel(elementTemplate, initialValue: initialValue);
//     } else {
//       return createFieldInstance(elementTemplate, initialValue: initialValue);
//     }
//   }
//
//   static SectionElementModel createSectionElementModel(FieldTemplate elementTemplate,
//       {dynamic initialValue}) {
//     final Map<String, FormElementModel<dynamic>> elements = {};
//     elementTemplate.fields.sort((a, b) => (a.order).compareTo(b.order));
//
//     final section =
//         SectionElementModel(name: elementTemplate.name);
//
//     for (var childTemplate in elementTemplate.fields) {
//       elements[childTemplate.name] = createElementModel(childTemplate,
//           initialValue: initialValue?[childTemplate.name]);
//     }
//     section.addAll(elements);
//
//     return section;
//   }
//
//   static RepeatItemElementModel createRepeatItem(FieldTemplate elementTemplate,
//       {Map<String, Object?>? initialValue}) {
//     final Map<String, FormElementModel<dynamic>> elements = {};
//
//     elementTemplate.fields.sort((a, b) => (a.order).compareTo(b.order));
//     for (var childTemplate in elementTemplate.fields) {
//       elements[childTemplate.name] = createElementModel(childTemplate,
//           initialValue: initialValue?[childTemplate.name]);
//     }
//     final repeatedSection =
//         RepeatItemElementModel(name: elementTemplate.name, elements: elements);
//
//     return repeatedSection;
//   }
//
//   static RepeatElementModel createRepeatElementModel(FieldTemplate elementTemplate,
//       {List<dynamic>? initialValue}) {
//     final repeatInstance = RepeatElementModel(
//         name: elementTemplate.name,
//         elements: initialValue
//                 ?.map<RepeatItemElementModel>(
//                     (value) => createRepeatItem(elementTemplate, initialValue: value))
//                 .toList() ??
//             []);
//
//     return repeatInstance;
//   }
//
//   static FieldElementModel<dynamic> createFieldInstance(
//       FieldTemplate elementTemplate,
//       {dynamic initialValue}) {
//     switch (elementTemplate.type) {
//       case ValueType.SelectOne:
//         return FieldElementModel<String>(
//             name: elementTemplate.name, value: initialValue);
//       case ValueType.SelectMulti:
//         return FieldElementModel<List<String>>(
//             name: elementTemplate.name, value: initialValue);
//       case ValueType.Attribute:
//         return FieldElementModel<String>(
//             name: elementTemplate.name, value: initialValue);
//       case ValueType.Text:
//       case ValueType.LongText:
//       case ValueType.Letter:
//       case ValueType.FullName:
//         return FieldElementModel<String>(
//             name: elementTemplate.name, value: initialValue);
//       case ValueType.Date:
//       case ValueType.Time:
//       case ValueType.DateTime:
//         return FieldElementModel<String>(
//             name: elementTemplate.name, value: initialValue);
//
//       case ValueType.OrganisationUnit:
//         return FieldElementModel<String>(
//             name: elementTemplate.name, value: initialValue);
//
//       case ValueType.Integer:
//       case ValueType.IntegerPositive:
//       case ValueType.IntegerNegative:
//       case ValueType.IntegerZeroOrPositive:
//         return FieldElementModel<int>(
//             name: elementTemplate.name, value: initialValue);
//
//       case ValueType.Number:
//       case ValueType.UnitInterval:
//       case ValueType.Percentage:
//       case ValueType.Age:
//         return FieldElementModel<double>(
//             name: elementTemplate.name, value: initialValue);
//       case ValueType.Boolean:
//       case ValueType.TrueOnly:
//       case ValueType.YesNo:
//         return FieldElementModel<bool>(
//             name: elementTemplate.name, value: initialValue);
//       default:
//         throw Exception('Unsupported element type: ${elementTemplate.type}');
//     }
//   }
// }
