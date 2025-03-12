import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';

class FormValueCache {
  FormValueCache({
    Map<String, dynamic> formElementMap = const {},
    required this.formFlatTemplate,
  }) {
    _formValueMap.addAll(formElementMap);
  }
  final Map<String, dynamic> _formValueMap = {};
  final FormFlatTemplate formFlatTemplate;

  /// Store metadata for parent and nested repeat sections
  final Map<String, Map<String, dynamic>> metadata = {};

  /// Store metadata for repeat sections
  void updateMetadata(
      String sectionPath, String itemId, dynamic metadataValue) {
    metadata.putIfAbsent(sectionPath, () => {});
    metadata[sectionPath]![itemId] = metadataValue;
  }

  /// Get value for a path (dynamically generated with IDs)
  dynamic getValue(String absolutePath) {
    return _formValueMap[absolutePath];
  }

  /// Get value for a path (dynamically generated with IDs)
  void setValue(List<String> absolutePath, dynamic value) {
    // _formValueMap[absolutePath] = value;
  }

  String getRepeatPath(String basePath, int index) {
    return '$basePath[$index]';
  }

  /// Generate path for nested repeat sections dynamically
  String generatePath(String parentPath, String parentId, String elementName,
      String elementId) {
    return '$parentPath.$parentId.$elementName.$elementId';
  }

  /// Dynamically resolve path
  String resolvePathForNestedItem(
      String parentPath, String parentId, String nestedId) {
    return '$parentPath.$parentId.stockItems.$nestedId';
  }

  // String relativePath = "stockItemType";
  // String fullPath = getRepeatPath('stockInfo.stockDetails', 0) + ".$relativePath";

// String generatePath(String parentPath, List<String> nestedItems, int nestedIndex) {
  //   // Build the path for the nested item dynamically
  //   String nestedPath = '$parentPath.stockItems.${nestedItems[nestedIndex]}';
  //   return nestedPath;
  // }
  //
  // String resolvePathForNestedRepeatSection(
  //     String parentPath,
  //     List<String> nestedItems,
  //     List<int> indices
  //     ) {
  //   // Recursively resolve the path for nested items
  //   String path = parentPath;
  //   for (int i = 0; i < nestedItems.length; i++) {
  //     path += '.stockItems.${nestedItems[i]}.${indices[i]}';
  //   }
  //   return path;
  // }
}

// class FormValueCache {
//   final Map<String, dynamic> _formValueCache = {};
//   final FormFlatTemplate formFlatTemplate;
//
//   Map<String, dynamic> get formElementMap => Map.unmodifiable(_formValueCache);
//
//   FormValueCache({
//     Map<String, dynamic> formElementMap = const {},
//     required this.formFlatTemplate,
//   }) {
//     _formValueCache.addAll(formElementMap);
//   }
//
//   dynamic getValue(String path) {
//     return formElementMap[path];
//   }
//
//   /// **Flattening Nested Structure to Table:** This function will walk through
//   /// form structure, flattening it into a table-like structure where each
//   /// key is a full path and each value is a data value.
//   /// can be used during export operations to translate the
//   /// hierarchical data to a table-like structure where each key is a full
//   /// path and each value is a data value.
//   Map<String, dynamic> flattenFormElement(Map<String, dynamic> formElement) {
//     Map<String, dynamic> flattenedMap = {};
//
//     void flatten(dynamic element, String parentPath) {
//       if (element is Map) {
//         element.forEach((key, value) {
//           flatten(value, '$parentPath.$key');
//         });
//       } else if (element is List) {
//         for (int i = 0; i < element.length; i++) {
//           flatten(element[i], '$parentPath[$i]');
//         }
//       } else {
//         flattenedMap[parentPath] = element;
//       }
//     }
//
//     flatten(formElement, '');
//     return flattenedMap;
//   }
//
//   /// **Restoring Nested Structure from Table:** This function would iterate
//   /// over the flattened map (from the table), reconstructing the original
//   /// nested structure. You would need to handle indices for repeat sections
//   /// properly. This method Can be used during import operations to translate
//   /// a table data to hierarchical data.
//   ///
//   Map<String, dynamic> restoreNestedStructure(
//       Map<String, dynamic> flattenedData) {
//     Map<String, dynamic> restoredMap = {};
//
//     flattenedData.forEach((path, value) {
//       var keys = path.split('.');
//
//       dynamic currentMap = restoredMap;
//       for (var i = 0; i < keys.length - 1; i++) {
//         var key = keys[i];
//         if (!currentMap.containsKey(key)) {
//           currentMap[key] = {};
//         }
//         currentMap = currentMap[key];
//       }
//
//       currentMap[keys.last] = value;
//     });
//
//     return restoredMap;
//   }
// }
