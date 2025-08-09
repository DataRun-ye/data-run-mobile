import 'package:injectable/injectable.dart';

@lazySingleton
class TableSelectionRepository {
  final Map<String, Set<String>> _formSelections = {};

  Set<String> getSelections(String formId) =>
      _formSelections.putIfAbsent(formId, () => <String>{});

  void saveSelections(String formId, Set<String> ids) {
    _formSelections[formId] = ids;
  }

  void removeInvalidSelections(
      String formId, List<String> selectableInstances) {
    final selections = getSelections(formId);
    selections.removeWhere((id) => !selectableInstances.contains(id));
    saveSelections(formId, selections);
  }

  void remove(String formId, String id) {
    final selections = getSelections(formId);
    selections.remove(id);
  }

  void addSelection(String formId, String id) {
    _formSelections.putIfAbsent(formId, () => <String>{}).add(id);
  }

  void clearSelections(String formId) {
    _formSelections.remove(formId);
  }

  @disposeMethod
  void dispose() {
    _formSelections.clear();
  }
}
