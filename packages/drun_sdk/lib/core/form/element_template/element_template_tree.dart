abstract class ElementTemplate {
  final String id;
  final String? parentId;
  final int order;
  final String name;
  final String path;
  final List<ElementTemplate> children = [];

  ElementTemplate({
    required this.id,
    required this.parentId,
    required this.order,
    required this.name,
    required this.path,
  });
}

class SectionElementTemplate extends ElementTemplate {
  final bool repeatable;
  SectionElementTemplate({
    required String id,
    required String? parentId,
    required int order,
    required String name,
    required String path,
    required this.repeatable,
  }) : super(id: id, parentId: parentId, order: order, name: name, path: path);

  @override
  String toString() => 'Section($name, children: $children)';
}

class FieldElementTemplate extends ElementTemplate {
  final String type;
  FieldElementTemplate({
    required String id,
    required String? parentId,
    required int order,
    required String name,
    required String path,
    required this.type,
  }) : super(id: id, parentId: parentId, order: order, name: name, path: path);

  @override
  String toString() => 'Field($name, type: $type)';
}

List<ElementTemplate> buildTree({
  required List<Map<String, dynamic>> sections,
  required List<Map<String, dynamic>> fields,
}) {
  // 1) Create a lookup of all nodes by their id:
  final Map<String, ElementTemplate> lookup = {};

  for (var s in sections) {
    lookup[s['id']] = SectionElementTemplate(
      id: s['id'],
      parentId: s['parent'], // might be null
      order: s['order'],
      name: s['name'],
      path: s['path'],
      repeatable: s['repeatable'] ?? false,
    );
  }
  for (var f in fields) {
    lookup[f['id']] = FieldElementTemplate(
      id: f['id'],
      parentId: f['parent'], // might be null
      order: f['order'],
      name: f['name'],
      path: f['path'],
      type: f['type'],
    );
  }

  // 2) Link children into parents:
  final List<ElementTemplate> roots = [];
  lookup.forEach((id, node) {
    if (node.parentId == null || !lookup.containsKey(node.parentId!)) {
      // no parent in our data ⇒ this is a root
      roots.add(node);
    } else {
      lookup[node.parentId!]!.children.add(node);
    }
  });

  // sort each node’s children by the `order` property:
  void sortRecursively(List<ElementTemplate> list) {
    list.sort((a, b) => a.order.compareTo(b.order));
    for (var n in list) {
      if (n.children.isNotEmpty) sortRecursively(n.children);
    }
  }

  sortRecursively(roots);

  return roots;
}
