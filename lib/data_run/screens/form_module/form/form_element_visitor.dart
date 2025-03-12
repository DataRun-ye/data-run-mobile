// // Define the visitor interface
// import 'package:datarunmobile/data_run/screens/form_module/form/form_value_cache.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_element_model/form_element_model.dart';
//
// abstract class FormElementVisitor {
//   void visitField(FieldElementModel<dynamic> field);
//
//   void visitSection(SectionElementModel section);
//
//   void visitRepeatSection(RepeatElementModel repeatSection);
//
//   void visitRepeatItem(RepeatItemElementModel repeatItem);
// }
//
// class FormUpdaterVisitor implements FormElementVisitor {
//   final FormValueCache formValueCache;
//
//   FormUpdaterVisitor(this.formValueCache);
//
//   @override
//   void visitField(FieldElementModel<dynamic> field) {
//     // Logic to update form value for a field
//     // formValueCache.setValue(field.path!, field.value);
//   }
//
//   @override
//   void visitSection(SectionElementModel section) {
//     // Logic to update metadata or context for a section
//     // Maybe traverse children and update their values too
//     for (var child in section.elements.values) {
//       child.accept(this);
//     }
//   }
//
//   @override
//   void visitRepeatSection(RepeatElementModel repeatSection) {
//     // Logic to update metadata or form values for repeat section
//     for (var item in repeatSection.elements) {
//       item.accept(this);
//     }
//   }
//
//   @override
//   void visitRepeatItem(RepeatItemElementModel repeatItem) {
//     // Logic to update metadata or context for a section
//     // Maybe traverse children and update their values too
//     for (var child in repeatItem.elements.values) {
//       child.accept(this);
//     }
//   }
// }
// //
// // void main() {
// //   // Build a simple form tree structure
// //   var formTree = SectionElementModel(templatePath: 'sectionInfo', elements: {
// //     'companyName': FieldElementModel(templatePath: 'companyName', value: 'ABC Company'),
// //     'contactName': FieldElementModel(templatePath: 'contactName', value: 'John Doe'),
// //     'contactEmail': FieldElementModel(templatePath: 'contactEmail', value: 'johndoe@example.com'),
// //     'contactPhone': FieldElementModel(templatePath: 'contactPhone', value: '1234567890'),
// //     'address': FieldElementModel(templatePath: 'address', value: '123 Main St'),
// //     'city': FieldElementModel(templatePath: 'city', value: 'Anytown'),
// //     'zip': FieldElementModel(templatePath: 'zip', value: '12345'),
// //     'country': FieldElementModel(templatePath: 'country', value: 'USA'),
// //     'stockInfo':
// //         RepeatElementModel(templatePath: 'stockInfo', elements: [
// //           RepeatItemElementModel(
// //               templatePath:'stockInfo.stockDetails',
// //               uid: CodeGenerator.generateUid(),
// //               elements: {
// //                 'stockType': FieldElementModel(templatePath:'stockType', value: 'Stock 1'),
// //                 'stockQuantity': FieldElementModel(templatePath:'stockQuantity', value: 100),
// //                 'stockPrice': FieldElementModel(templatePath:'stockPrice', value: 10.0),
// //                 'stockCurrency': FieldElementModel(templatePath:'stockCurrency', value: 'USD'),
// //               }),
// //           RepeatItemElementModel(
// //               templatePath:'stockInfo.stockDetails',
// //               uid: CodeGenerator.generateUid(), elements: {
// //                 'stockType': FieldElementModel(templatePath:'stockType', value: 'Stock 2'),
// //                 'stockQuantity': FieldElementModel(templatePath:'stockQuantity', value: 200),
// //                 'stockPrice': FieldElementModel(templatePath:'stockPrice', value: 20.0),
// //                 'stockCurrency': FieldElementModel(templatePath:'stockCurrency', value: 'USD'),
// //           }),
// //         ])
// //   });
// //
// //   // Create a visitor to update values
// //   var visitor = FormUpdaterVisitor(formValueCache);
// //
// //   // Traverse the form tree and update the form values
// //   formTree.accept(visitor);
// // }
