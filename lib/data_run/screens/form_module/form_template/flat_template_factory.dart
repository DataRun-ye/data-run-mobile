// import 'dart:async';
//
// import 'package:d_sdk/core/form/element_template/element_template.dart';
// import 'package:d_sdk/core/form/form_traverse_extension.dart';
// import 'package:d_sdk/core/form/rule/rule_parse_extension.dart';
// import 'package:d_sdk/core/form/tree/tree_element.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
//
// class FlatTemplateFactory {
//   FlatTemplateFactory(
//       this._formVersion, IMap<String, IList<DataOption>> optionLists)
//       : this._optionLists = optionLists;
//
//   final FormTemplateVersion _formVersion;
//   IMap<String, IList<DataOption>> _optionLists;
//
//   // 3) Optional: sort each node’s children by the `order` property:
//   void sortRecursively(List<TreeElement> list) {
//     list.sort((a, b) => a.order.compareTo(b.order));
//     for (var n in list) {
//       if (n.children.isNotEmpty) sortRecursively(n.children);
//     }
//   }
//
//   FutureOr<List<FormElementTemplate>> createFlatTemplate() async {
//     List<FormElementTemplate> result = [];
//     for (var template in _formVersion.flatFields.values) {
//       result.addAll(await _flattenElementTemplate(template));
//     }
//
//     sortRecursively(result);
//     return result;
//   }
//
//   List<FormElementTemplate> _flatSectionWithPath(List<Template> templates,
//       {String? initialPath}) {
//     List<FormElementTemplate> result = [];
//     for (var template in templates) {
//       result.addAll(_flattenElementTemplate(template, prefix: initialPath));
//     }
//     return result;
//   }
//
//   List<FormElementTemplate> _flattenElementTemplate(Template template,
//       {String? prefix}) {
//     List<FormElementTemplate> result = [];
//     String fullPrefix =
//         prefix != null ? '$prefix.${template.name}' : template.name!;
//     if (template is SectionTemplate) {
//       // template as SectionTemplate;
//       result.add(SectionElementTemplate(
//           id: template.id,
//           name: template.name,
//           label: template.label.unlockView,
//           order: template.order,
//           valueTypeRendering: template.valueTypeRendering,
//           path: template.path,
//           namePath: fullPrefix,
//           properties: template.properties?.unlockView ?? {},
//           rules: template.rules,
//           itemTitle: template.itemTitle,
//           repeatable: template.repeatable,
//           // fieldValueRenderingType: template.fieldValueRenderingType,
//           ruleDependencies: template.dependencies,
//           children: _flatSectionWithPath(
//               getImmediateChildren(
//                   template.path, _formVersion.flatFields.values),
//               initialPath: fullPrefix)));
//     } else if (template is FieldTemplate) {
//       result.add(FieldElementTemplate(
//         id: template.id,
//         type: template.type,
//         optionSet: template.optionSet,
//         readOnly: template.readOnly,
//         name: template.name,
//         order: template.order,
//         listName: template.listName,
//         label: template.label.unlockView,
//         path: template.path,
//         namePath: fullPrefix,
//         mandatory: template.mandatory,
//         gs1Enabled: template.gs1Enabled,
//         mainField: template.mainField,
//         rules: template.rules,
//         choiceFilter: template.choiceFilter,
//         defaultValue: template.defaultValue,
//         options: template.optionSet != null
//             ? _optionLists[template.optionSet!] ?? []
//             : [],
//         calculation: template.calculation,
//         calculationDependencies: template.calculationDependencies,
//         scannedCodeProperties: template.scannedCodeProperties,
//         filterDependencies: template.filterDependencies,
//         ruleDependencies: template.dependencies,
//       ));
//     }
//
//     return result;
//   }
//
//   List<Template> getImmediateChildren(
//       String path, Iterable<Template> allNodes) {
//     final normalizedPath =
//         path.endsWith('.') ? path.substring(0, path.length - 1) : path;
//
//     final depth = normalizedPath.split('.').length + 1;
//     final childElements = allNodes.where((node) {
//       return node.path!.startsWith('$normalizedPath.') &&
//           node.path!.split('.').length == depth;
//     }).toList();
//     return childElements;
//   }
//
//   // static List<Template> buildTree({required List<Template> fieldsAndSections}) {
//   //   // a lookup of all nodes by their id:
//   //   final IMap<String, Template> lookup = IMap.fromIterable(fieldsAndSections,
//   //       keyMapper: (template) => template.id,
//   //       valueMapper: (template) => template);
//   //
//   //   // Link children into parents:
//   //   final List<Template> roots = [];
//   //   lookup.forEach((id, node) {
//   //     if (node.parent == null || !lookup.containsKey(node.parent)) {
//   //       // no parent in our data ⇒ this is a root
//   //       roots.add(node);
//   //     } else {
//   //       lookup[node.parent!]!.children.add(node);
//   //     }
//   //   });
//   //
//   //   // 3) Optional: sort each node’s children by the `order` property:
//   //   void sortRecursively(List<Template> list) {
//   //     list.sort((a, b) => a.order.compareTo(b.order));
//   //     for (var n in list) {
//   //       if (n.children.isNotEmpty) sortRecursively(n.children);
//   //     }
//   //   }
//   //
//   //   sortRecursively(roots);
//   //
//   //   return roots;
//   // }
// }
