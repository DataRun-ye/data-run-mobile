import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/data_instance/form_data_aggregator.dart';
import 'package:d_sdk/core/form/rule/rule.dart';
import 'package:d_sdk/core/form/tree_element.dart';
import 'package:d_sdk/core/form/value_type_rendering_type.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

abstract class Template with EquatableMixin, TreeElement {
  //<editor-fold desc="Template Common properties">
  String get id;

  String? get description;

  String? get parent;

  String? get path;

  int get order;

  String? get name;

  String? get code;

  Aggregation? get aggregation => getDefaultAggregation(type);

  IMap<String, dynamic> get label;

  bool get readOnly;

  bool get mandatory => false;

  IList<Rule>? get rules;

  IMap<String, dynamic> get properties;

  ValueTypeRenderingType get valueTypeRendering =>
      ValueTypeRenderingType.DEFAULT;

  //</editor-fold>

  //<editor-fold desc="Leaf field Templates properties">
  String? get optionSet => null;

  bool get showInSummary => false;

  @Deprecated('Use showInSummary instead')
  bool get mainField => false;

  ValueType? get type => null;
  //</editor-fold>

  //<editor-fold desc="Container/Group Template properties">
  bool get repeatable;

  List<Template> get children => [];

  //</editor-fold>
  @override
  List<Object?> get props => [id, path];

  static Template fromJsonFactory(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    final valueType = ValueType.getValueType(type);

    return switch (valueType) {
      null => SectionTemplate.fromJson(json),
      _ => FieldTemplate.fromJson(json),
    };
  }

  static Map<String, dynamic> toJsonFactory(Template template) {
    return switch (template.type) {
      null => (template as SectionTemplate).toJson(),
      _ => (template as FieldTemplate).toJson(),
    };
  }

  static List<Template> buildTree(
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

    return roots;
  }

  static Aggregation? getDefaultAggregation(ValueType? type) {
    if (type?.isDate == true) {
      return Aggregation.first;
    }

    if (type?.isNumeric == true) {
      return Aggregation.sum;
    }

    if(type?.isText == true) return Aggregation.concat;

    return null;
  }
}
