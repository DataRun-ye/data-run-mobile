import 'package:d_sdk/core/form/attribute_type.dart';
import 'package:d_sdk/core/form/rule/rule.dart';
import 'package:d_sdk/core/form/template_path_walking_service.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/core/form/utils/path_walking_service.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/flat_template_factory.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template_iterator.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

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
    Iterable<FormElementTemplate> fields = const [],
  })  : this._optionLists = Map.fromIterable(
            (formTemplate.options)
              ..sort((p1, p2) => p1.order.compareTo(p2.order)),
            key: (option) => option.listName,
            value: (option) => formTemplate.options
                .where((o) => o.listName == option.listName)
                .toList()),
        rootElementTemplate = SectionElementTemplate(
          isRepeat: false,
          children:
              fields.toIList().sort((t1, t2) => t1.order.compareTo(t2.order)),
        ) {
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

  String get defaultLocal => formTemplate.defaultLocal ?? 'ar';

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

  Map<String, String> get label => Map.unmodifiable(formTemplate.label ?? {});

  List<String> get orgUnits => <String>[];
}

sealed class FormElementTemplate with TreeElement, EquatableMixin {
  FormElementTemplate({
    this.id,
    this.code,
    this.name,
    this.description,
    this.path,
    required this.runtimePath,
    this.readOnly = false,
    this.order = 0,
    this.fieldValueRenderingType,
    Iterable<Rule>? rules,
    Map<String, dynamic>? label,
    Map<String, dynamic>? properties,
    Iterable<String>? ruleDependencies,
  })  : this.rules = IList.orNull(rules) ?? IList(),
        this.label = IMap.orNull(label) ?? IMap(),
        this.properties = IMap.orNull(properties) ?? IMap(),
        this.ruleDependencies = IList.orNull(ruleDependencies) ?? IList();

  final String? id;
  final String? code;
  final String? name;
  final String? description;
  final bool readOnly;
  final String? path;
  final String? runtimePath;
  final int order;
  final String? fieldValueRenderingType;
  final IMap<String, dynamic> label;
  final IList<Rule> rules;
  final IList<String> ruleDependencies;
  final IMap<String, dynamic> properties;

  ValueType get type;

  IList<FormElementTemplate> get children => IList([]);

  @override
  List<Object?> get props => [
        id,
        code,
        name,
        description,
        path,
        order,
        rules,
        label,
        fieldValueRenderingType
      ];
}

// @immutable
class FieldElementTemplate extends FormElementTemplate {
  FieldElementTemplate({
    super.id,
    required this.type,
    super.readOnly,
    super.code,
    super.name,
    super.description,
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
      super.code,
      super.name,
      super.description,
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
      Iterable<FormElementTemplate>? children,
      this.itemTitle})
      : this.children = IList.orNull(children) ?? IList();
  final String? itemTitle;
  final int repeatCount;
  final bool isRepeat;
  final IList<FormElementTemplate> children;

  @override
  ValueType get type => ValueType.Section;
}
