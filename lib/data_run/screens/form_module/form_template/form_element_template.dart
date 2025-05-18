import 'package:d_sdk/core/form/attribute_type.dart';
import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/form/rule/rule.dart';
import 'package:d_sdk/core/form/tree/tree.dart';
import 'package:d_sdk/core/form/value_type_rendering_type.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/flat_template_factory.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template_iterator.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/util_methods.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

@immutable
class FormFlatTemplate
    with TemplatePathWalkingService<FormElementTemplate>, EquatableMixin {
  FormFlatTemplate._({
    required this.id,
    required this.name,
    required this.formVersion,
    required this.versionNumber,
    this.description,
    Map<String, dynamic>? label,
    Iterable<FormElementTemplate> fields = const [],
    required IMap<String, IList<FormOption>> optionLists,
  })  : this.optionLists = optionLists,
        this.label = label ?? {'ar': name},
        rootElementTemplate = SectionElementTemplate(
            repeatable: false,
            namePath: null,
            children: fields.toList(),
            id: '') {
    final itFields = getFormElementTemplateIterator(rootElementTemplate)
        .where((field) => (field.path ?? '').isNotEmpty)
        .toList()
      ..sort((a, b) => (a.order).compareTo(b.order));
    for (final field in itFields) {
      _flatFields[field.path!] = field;
    }
  }

  static Future<FormFlatTemplate> fromTemplate(
      {required String templateId}) async {
    final FormTemplateVersion templateVersion =
        await getTemplateByVersionOrLatest(templateId);
    IMap<String, IList<FormOption>> optionLists =
        await getOptionSets(templateVersion);
    final formTemplate = await getFormTemplate(templateVersion.template);
    final fields = await FlatTemplateFactory(templateVersion, optionLists)
        .createFlatTemplate();

    return FormFlatTemplate._(
      id: formTemplate.id,
      name: formTemplate.name,
      formVersion: templateVersion.id,
      label: formTemplate.label,
      description: formTemplate.description,
      versionNumber: templateVersion.versionNumber,
      optionLists: optionLists,
      fields: fields,
    );
  }

  final SectionElementTemplate rootElementTemplate;

  /// {listName: List<option>}
  final IMap<String, IList<FormOption>> optionLists;

  final String id;

  final String name;

  final String? description;

  final String formVersion;

  final int versionNumber;

  final Map<String, dynamic> label;

  @override
  List<Object?> get props => [id, name, formVersion];

  final Map<String, FormElementTemplate> _flatFields = {};

  Map<String, FormElementTemplate> get flatFields =>
      Map.unmodifiable(_flatFields);

  IList<FormElementTemplate> get flatFieldsList =>
      _flatFields.values.toList().lock;
}

sealed class FormElementTemplate with TreeElement, EquatableMixin {
  FormElementTemplate({
    required this.id,
    this.name,
    this.path,
    required this.parent,
    required this.namePath,
    this.readOnly = false,
    this.order = 0,
    this.valueTypeRendering = ValueTypeRenderingType.DEFAULT,
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

  final String id;
  final String? name;
  final String? parent;
  final bool readOnly;
  final String? path;
  final String? namePath;
  final int order;

  bool get mainField;

  final ValueTypeRenderingType valueTypeRendering;
  final Map<String, dynamic> _label = {};
  final List<Rule> _rules = [];
  final List<String> _ruleDependencies = [];
  final Map<String, dynamic> _properties = {};

  final List<FormElementTemplate> children = [];

  ValueType get type;

  Map<String, String> get label => Map.unmodifiable(_label);

  List<Rule> get rules => List.unmodifiable(_rules);

  List<String> get ruleDependencies => List.unmodifiable(_ruleDependencies);

  Map<String, dynamic> get properties => Map.unmodifiable(_properties);

  @override
  String get displayName => getItemLocalString(label, defaultString: name);

  @override
  List<Object?> get props => [
        id,
        type,
        name,
        path,
        order,
        _rules.length,
        _label.length,
        valueTypeRendering
      ];
}

// @immutable
class FieldElementTemplate extends FormElementTemplate {
  FieldElementTemplate({
    required super.id,
    required this.type,
    super.readOnly,
    super.name,
    super.path,
    super.parent,
    required super.namePath,
    super.order,
    super.valueTypeRendering,
    super.rules,
    super.ruleDependencies,
    super.properties,
    super.label,
    this.optionSet,
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
  final String? optionSet;

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
      {required super.id,
      super.name,
      super.readOnly,
      super.parent,
      required super.namePath,
      super.path,
      super.order,
      super.valueTypeRendering,
      super.ruleDependencies,
      super.rules,
      super.label,
      super.properties,
      this.repeatCount = 1,
      required this.repeatable,
      Iterable<FormElementTemplate>? children,
      this.itemTitle})
      : this.children = children?.toList() ?? [];

  final String? itemTitle;
  final int repeatCount;
  final bool repeatable;

  final List<FormElementTemplate> children;

  @override
  ValueType get type => ValueType.Section;

  @override
  bool get mainField => false;
}
