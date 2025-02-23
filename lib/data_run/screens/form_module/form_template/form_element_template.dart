import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/attribute_type.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/scanned_code_properties.dart';
import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/rule.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarun/core/form_template/path_walking_service.dart';
import 'package:datarun/data_run/screens/form_module/form_template/form_element_template_iterator.dart';
import 'package:datarun/data_run/screens/form_module/form_template/flat_template_factory.dart';
import 'package:d2_remote/modules/datarun/form/shared/template_extensions/template_path_walking_service.dart';
import 'package:equatable/equatable.dart';

String? getParentPath(String? path) {
  final pathSegments = path?.split('.') ?? [];
  if (pathSegments.length > 1) {
    final parentPath =
        pathSegments.sublist(0, pathSegments.length - 1).join('.');
    return parentPath;
  }
  return null;
}

class FormFlatTemplate
    with
        TemplatePathWalkingService<FormElementTemplate>,
        PathDependencyWalkingService<FormElementTemplate>,
        EquatableMixin {

  factory FormFlatTemplate.fromTemplate(FormVersion template) {
    return FormFlatTemplate(
      formTemplate: template,
      fields: FlatTemplateFactory(template).createFlatTemplate(),
    );
  }

  FormFlatTemplate({
    required this.formTemplate,
    List<FormElementTemplate> fields = const [],
  })  : this._optionLists = Map.fromIterable(
            (formTemplate.options)
              ..sort((p1, p2) => p1.order.compareTo(p2.order)),
            key: (option) => option.listName,
            value: (option) => formTemplate.options
                .where((o) => o.listName == option.listName)
                .toList()),
        rootElementTemplate = SectionElementTemplate(
            isRepeat: false,
            children: fields..sort((t1, t2) => t1.order.compareTo(t2.order))) {
    final itFields = getFormElementTemplateIterator(rootElementTemplate)
        .where((field) => field.path != null)
        .toList()
      ..sort((a, b) => (a.order).compareTo(b.order));
    for (final field in itFields) {
      _flatFields[field.path!] = field;
    }
  }

  final FormVersion formTemplate;
  final SectionElementTemplate rootElementTemplate;

  /// {listName: List<option>}
  final Map<String, List<FormOption>> _optionLists;

  String? get name => formTemplate.name;

  String? get code => formTemplate.code;

  String get defaultLocal => formTemplate.defaultLocal;

  // String get activity => formTemplate.activity;

  int get version => formTemplate.version;

  @override
  List<Object?> get props => [formTemplate.id, name, code, version];

  List<FormElementTemplate> get flatFieldsList => flatFields.values.toList();

  final Map<String, FormElementTemplate> _flatFields = {};

  Map<String, FormElementTemplate> get flatFields =>
      Map.unmodifiable(_flatFields);

  Map<String, List<FormOption>> get optionLists =>
      Map.unmodifiable(_optionLists);

  Map<String, String> get label => Map.unmodifiable(formTemplate.label);

  List<String> get orgUnits => <String>[];
}

sealed class FormElementTemplate with TreeElement, EquatableMixin {
  FormElementTemplate({
    this.id,
    this.name,
    this.path,
    required this.runtimePath,
    this.readOnly = false,
    this.order = 0,
    this.fieldValueRenderingType,
    Iterable<Rule> rules = const [],
    Map<String, dynamic> label = const {},
    Map<String, dynamic> properties = const {},
    Iterable<String> ruleDependencies = const [],
  }) {
    _label.addAll(label);
    _rules.addAll(rules);
    _ruleDependencies.addAll(ruleDependencies);
    _properties.addAll(properties);
  }

  ValueType get type;

  final String? id;
  final String? name;
  final bool readOnly;
  final String? path;
  final String? runtimePath;
  final int order;
  final String? fieldValueRenderingType;
  final Map<String, dynamic> _label = {};
  final List<Rule> _rules = [];
  final List<String> _ruleDependencies = [];
  final Map<String, dynamic> _properties = {};

  Map<String, String> get label => Map.unmodifiable(_label);

  List<Rule> get rules => List.unmodifiable(_rules);

  List<String> get ruleDependencies => List.unmodifiable(_ruleDependencies);

  Map<String, dynamic> get properties => Map.unmodifiable(_properties);

  List<FormElementTemplate> get children => List.unmodifiable([]);

  // final FormElementTemplate? _parent;
  //
  // FormElementTemplate? get parent => _parent;

  // String get pathRecursive => pathBuilder(name);

  // String pathBuilder(String? pathItem) {
  //   return [parent?.pathRecursive, pathItem].whereType<String>().join('.');
  // }

  @override
  List<Object?> get props => [
        id,
        type,
        name,
        path,
        order,
        _rules.length,
        _label.length,
        fieldValueRenderingType
      ];
}

// @immutable
class FieldElementTemplate extends FormElementTemplate {
  FieldElementTemplate({
    super.id,
    required this.type,
    super.readOnly,
    super.name,
    super.path,
    super.runtimePath,
    super.order,
    super.fieldValueRenderingType,
    super.rules,
    super.ruleDependencies,
    super.properties,
    super.label,
    this.mainField = false,
    this.mandatory = false,
    this.calculation,
    this.listName,
    this.gs1Enabled = false,
    this.choiceFilter,
    this.defaultValue,
    this.attributeType,
    this.scannedCodeProperties,
    Iterable<FormOption> options = const [],
    Iterable<String> filterDependencies = const [],
    Iterable<String> calculationDependencies = const [],
  }) {
    _options.addAll(options);
    _filterDependencies.addAll(filterDependencies);
    _calculationDependencies.addAll(calculationDependencies);
  }

  final ValueType type;
  final String? listName;
  final bool mainField;
  final bool mandatory;
  final String? choiceFilter;
  final dynamic defaultValue;
  final AttributeType? attributeType;
  final String? calculation;
  final bool gs1Enabled;
  final ScannedCodeProperties? scannedCodeProperties;
  final List<FormOption> _options = [];

  /// <name, path>
  final List<String> _filterDependencies = [];
  final List<String> _calculationDependencies = [];

  List<FormOption> get options => List.unmodifiable(_options);

  Iterable<Map<String, dynamic>> get optionContext =>
      options.map((option) => option.toContext());

  List<String> get filterDependencies => List.unmodifiable(_filterDependencies);
}

/// represent a Section or RepeatableSection, the ValueType tell which on it is
class SectionElementTemplate extends FormElementTemplate {
  SectionElementTemplate(
      {super.id,
      super.name,
      super.readOnly,
      super.runtimePath,
      super.path,
      super.order,
      super.fieldValueRenderingType,
      super.ruleDependencies,
      super.rules,
      super.label,
      super.properties,
      this.repeatCount = 1,
      required this.isRepeat,
      List<FormElementTemplate> children = const [],
      this.itemTitle}) {
    // addAll(children);
    _children.addAll(children);
  }

  final String? itemTitle;
  final int repeatCount;
  final bool isRepeat;

  final List<FormElementTemplate> _children = [];

  List<FormElementTemplate> get children => List.unmodifiable(_children);

  // void addAll(List<FormElementTemplate> children) {
  //   _children.clear();
  //   for (var child in children) {
  //     child._parent = this;
  //   }
  //   _children.addAll(children);
  // }

  // @override
  // List<Object?> get props => super.props..addAll([itemTitle]);

  @override
  ValueType get type => ValueType.Section;
}

// /// represent a Section or RepeatableSection, the ValueType tell which on it is
// class RepeatElementTemplate extends SectionElementTemplate {
//   RepeatElementTemplate(
//       {super.id,
//       super.name,
//       super.readOnly,
//       super.runtimePath,
//       super.path,
//       super.order,
//       super.fieldValueRenderingType,
//       super.ruleDependencies,
//       super.rules,
//       super.label,
//       super.properties,
//       super.children,
//       this.itemTitle});
//
//   // add(FormElementTemplate child) {
//   //   child._parent = this;
//   //   _children.add(child);
//   // }
//
//   @override
//   ValueType get type => ValueType.RepeatableSection;
//
// // @override
// // List<Object?> get props => super.props..addAll([itemTitle]);
// }
