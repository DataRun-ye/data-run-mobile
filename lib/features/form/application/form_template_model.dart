import 'package:built_collection/built_collection.dart';
import 'package:d_sdk/core/form/element_template/template.dart';
import 'package:d_sdk/database/shared/d_identifiable_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class FormTemplateModel extends IdentifiableModel {
  FormTemplateModel(
      {required super.id,
      required super.name,
      super.code,
      super.label,
      super.description,
      super.properties,
      required this.versionUid,
      required this.versionNumber,
      required this.fields,
      required this.sections})
      : this.elementTree =
            _buildTree(fieldsAndSections: [...fields, ...sections]);

  final String versionUid;
  final int versionNumber;
  final BuiltList<Template> fields;
  final BuiltList<Template> sections;

  final BuiltList<Template> elementTree;

  static BuiltList<Template> _buildTree(
      {required Iterable<Template> fieldsAndSections}) {
    // a lookup of all nodes by their id:
    final IMap<String, Template> lookup = IMap.fromIterable(fieldsAndSections,
        keyMapper: (template) => template.id,
        valueMapper: (template) => template);

    // Link children into parents:
    final List<Template> roots = [];
    lookup.forEach((id, node) {
      if (node.parent == null || !lookup.containsKey(node.parent)) {
        // no parent in our data ⇒ this is a root
        roots.add(node);
      } else {
        lookup[node.parent!]!.children.add(node);
      }
    });

    // 3) Optional: sort each node’s children by the `order` property:
    void sortRecursively(List<Template> list) {
      list.sort((a, b) => a.order.compareTo(b.order));
      for (var n in list) {
        if (n.children.isNotEmpty) sortRecursively(n.children);
      }
    }

    sortRecursively(roots);

    return BuiltList.of(roots);
  }

  @override
  List<Object?> get props => super.props + [versionUid, versionNumber];
}
