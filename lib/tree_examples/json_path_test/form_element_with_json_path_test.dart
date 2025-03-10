// import 'package:json_path/json_path.dart';
//
// class FormElement {
//   final String name;
//   final String path;
//   final Map<String, dynamic> attributes;
//   final List<FormElement> children;
//   final bool isRepeated;
//
//   FormElement(this.name, this.path, {
//     this.attributes = const {},
//     this.children = const [],
//     this.isRepeated = false,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'path': path,
//       'attributes': attributes,
//       'children': children.map((child) => child.toJson()).toList(),
//       'isRepeated': isRepeated,
//     };
//   }
// }
//
// class DependencyManager {
//   final Map<String, Set<String>> _dependencies = {};
//   final List<FormElement> _elements = [];
//
//   void addElement(FormElement element) {
//     _elements.add(element);
//   }
//
//   void addDependency(String targetPath, String dependencyPath) {
//     _dependencies.putIfAbsent(targetPath, () => {}).add(dependencyPath);
//   }
//
//   Set<String> getDependents(String path) {
//     return _dependencies.entries
//         .where((entry) => entry.value.contains(path))
//         .map((entry) => entry.key)
//         .toSet();
//   }
//
//   List<FormElement> queryElements(String jsonPath) {
//     final expression = JsonPath(jsonPath);
//     final jsonElements = _elements.map((e) => e.toJson()).toList();
//     final results = expression.read(jsonElements);
//     return results.map((r) => _findElementRecursive(r.value['path'] as String, _elements)).whereType<FormElement>().toList();
//   }
//
//   FormElement? getElement(String path) {
//     return _findElementRecursive(path, _elements);
//   }
//
//   List<FormElement> getChildElements(String parentPath) {
//     final parent = getElement(parentPath);
//     return parent?.children ?? [];
//   }
//
//   void updateElementAttribute(String path, String key, dynamic value) {
//     final element = getElement(path);
//     if (element != null) {
//       element.attributes[key] = value;
//     }
//   }
//
//   FormElement? _findElementRecursive(String path, List<FormElement> elements) {
//     for (var element in elements) {
//       if (element.path == path) {
//         return element;
//       }
//       if (element.children.isNotEmpty) {
//         final found = _findElementRecursive(path, element.children);
//         if (found != null) {
//           return found;
//         }
//       }
//     }
//     return null;
//   }
// }
//
// void main() {
//   final manager = DependencyManager();
//
//   // Add form elements with nested structure and repeated elements
//   manager.addElement(FormElement('personalInfo', 'personalInfo', children: [
//     FormElement('name', 'personalInfo.name', attributes: {'type': 'text'}),
//     FormElement('email', 'personalInfo.email', attributes: {'type': 'email'}),
//     FormElement('age', 'personalInfo.age', attributes: {'type': 'number'}),
//     FormElement('addresses', 'personalInfo.addresses', isRepeated: true, children: [
//       FormElement('street', 'personalInfo.addresses.street', attributes: {'type': 'text'}),
//       FormElement('city', 'personalInfo.addresses.city', attributes: {'type': 'text'}),
//       FormElement('country', 'personalInfo.addresses.country', attributes: {'type': 'text'}),
//     ]),
//   ]));
//
//   // Add dependencies
//   manager.addDependency('personalInfo.email', 'personalInfo.name');
//
//   // Query elements using JsonPath
//   final textFields = manager.queryElements(r'$..children[?(@.attributes.type=="text")]');
//   print('Text fields: ${textFields.map((e) => e.name).join(', ')}');
//
//   // Get child elements
//   final personalInfoFields = manager.getChildElements('personalInfo');
//   print('Personal info fields: ${personalInfoFields.map((e) => e.name).join(', ')}');
//
//   // Update an element's attribute
//   manager.updateElementAttribute('personalInfo.age', 'required', true);
//
//   // Get dependents
//   final nameFieldDependents = manager.getDependents('personalInfo.name');
//   print('Fields depending on name: $nameFieldDependents');
//
//   // Complex JsonPath query for nested repeated elements
//   final repeatedFields = manager.queryElements(r'$..children[?(@.isRepeated==true)]');
//   print('Repeated fields: ${repeatedFields.map((e) => e.name).join(', ')}');
//
//   // Query for nested elements within repeated sections
//   final nestedRepeatedFields = manager.queryElements(r'$..children[?(@.isRepeated==true)].children[*]');
//   print('Nested fields in repeated sections: ${nestedRepeatedFields.map((e) => e.name).join(', ')}');
// }
