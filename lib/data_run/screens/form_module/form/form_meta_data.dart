// import 'package:datarunmobile/data_run/screens/form_module/form/code_generator.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form/form_value_cache.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
//
// /// **FormMetadata:** metadata about the repeat section's items, such as their
// /// current position in the list, order, or any other state attributes
// /// (e.g., "is deleted," "is added") (e.g., stockInfo.stockDetails might
// /// have a metadata map).
// ///
// /// **How It Fits:**
// ///
// /// - Centralized State Management: Keeps track of the order and other
// /// attributes of items centrally, so you can easily update the form without
// /// manually recalculating paths or indices.
// /// - Dynamic Path Updates: When an item is removed, the metadata updates
// /// the state of the list, and the paths are recalculated accordingly.
// /// - Fewer Recalculations: Metadata abstracts away the need for complex path
// /// recalculation, making updates simpler.
// ///
// /// ```dart
// /// Map<String, Map<String, dynamic>> repeatSectionMetadata = {
// ///   'stockInfo.stockDetails': {
// ///     'order': [0, 1, 2], // Tracks current order
// ///     'deleted': [false, false, false], // Track deletions
// ///   }
// /// };
// ///
// /// String generatePathFromMetadata(String sectionPath, int index) {
// ///   // Use metadata to resolve path
// ///   return '$sectionPath.${repeatSectionMetadata[sectionPath]['order'][index]}.stockItemType';
// /// }
// /// ```
// class FormMetadata {
//   /// Tracks the order of items by unique uid
//   List<String> order = [];
//
//   /// Maps each item uid to its visibility status
//   Map<String, bool> visibility = {};
//
//   /// Tracks if an item is marked as deleted
//   Map<String, bool> deletionStatus = {};
//
//   /// Tracks if an item is marked as deleted
//   Map<String, bool> validStatus = {};
//
//   /// Tracks if an item is 'dirty' (needs re-evaluation)
//   Map<String, bool> isDirty = {};
//
//   void addItemToRepeatSection(String parentPath, String id) {
//     repeatSectionMetadata[parentPath]['order'].add(id);
//     repeatSectionMetadata[parentPath]['deleted'][id] = false;
//   }
//
//   void removeItemFromRepeatSection(String sectionPath, String id) {
//     repeatSectionMetadata[sectionPath]['order'].remove(id);
//     repeatSectionMetadata[sectionPath]['deleted'][id] = true;
//   }
//
// }
//
// final Map<String, FormMetadata> repeatSectionMetadata = {
//   'stockInfo.stockDetails': FormMetadata(),
// };
//
// void addNewItemToSection(String sectionPath) {
//   final newId = CodeGenerator.generateCompositeUid();
//
//   // Add the new item to the metadata
//   repeatSectionMetadata.putIfAbsent(sectionPath, () => FormMetadata());
//   repeatSectionMetadata[sectionPath]?.order.add(newId);
//   repeatSectionMetadata[sectionPath]?.visibility[newId] = true;
//   repeatSectionMetadata[sectionPath]?.deletionStatus[newId] = false;
//   repeatSectionMetadata[sectionPath]?.isDirty[newId] = false;
//
//   // Add the item to the form data
//   formValueCache['$sectionPath.$newId'] = {}; // Initialize form values for new item
// }
