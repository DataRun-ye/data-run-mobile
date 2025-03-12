import 'package:datarunmobile/data_run/screens/form_module/form/form_value_cache.dart';

class RepeatSectionHandler {
  RepeatSectionHandler(this.formValueCache);
  final FormValueCache formValueCache;

  // Add new item to nested repeat section
  void addNestedItem(
      String parentPath, String parentId, String nestedId, dynamic value) {
    String path =
        formValueCache.resolvePathForNestedItem(parentPath, parentId, nestedId);
    formValueCache.getValue(path); // Access or set value for the path
    // Update metadata for nested repeat item
    formValueCache.updateMetadata(parentPath, parentId, {
      'nestedItems': [nestedId],
      'order': 1,
    });
  }

  // Remove item from nested repeat section
  void removeNestedItem(String parentPath, String parentId, String nestedId) {
    String path =
        formValueCache.resolvePathForNestedItem(parentPath, parentId, nestedId);
    formValueCache.getValue(path); // Clear value for the path
    // Remove metadata or adjust it
    formValueCache.updateMetadata(parentPath, parentId, {
      'nestedItems': [], // Remove nested item
    });
  }
}
