import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/attribute_type.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/scanned_code_properties.dart';
import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/rule.dart';
import 'package:d2_remote/modules/datarun/form/shared/template_extensions/template_path_walking_service.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarunmobile/core/form/utils/path_walking_service.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/flat_template_factory.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template_iterator.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/util_methods.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/cupertino.dart';

@immutable
class FormFlatTemplate
    with
        TemplatePathWalkingService<FormElementTemplate>,
        PathDependencyWalkingService<FormElementTemplate>,
        EquatableMixin {
  FormFlatTemplate._({
    required this.formTemplate,
    Iterable<FormElementTemplate> fields = const [],
    required IMap<String, IList<FormOption>> optionLists,
  })  : this.optionLists = optionLists,
        rootElementTemplate = SectionElementTemplate(
            repeatable: false, namePath: null, children: fields.toList()) {
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
    final FormVersion? template =
        await D2Remote.formModule.formTemplateV.byId(templateId).getOne();
    IMap<String, IList<FormOption>> optionLists = await getOptionSets(template);
    final fields =
        await FlatTemplateFactory(template!, optionLists).createFlatTemplate();
    return FormFlatTemplate._(
      formTemplate: template,
      optionLists: optionLists,
      fields: fields,
    );
  }

  final FormVersion formTemplate;
  final SectionElementTemplate rootElementTemplate;

  /// {listName: List<option>}
  final IMap<String, IList<FormOption>> optionLists;

  String? get name => formTemplate.name;

  String? get code => formTemplate.code;

  String get defaultLocal => formTemplate.defaultLocal;

  String get versionUid => formTemplate.versionUid!;

  int get versionNumber => formTemplate.versionNumber;

  @override
  List<Object?> get props => [formTemplate.id, name, code, versionNumber];

  final Map<String, FormElementTemplate> _flatFields = {};

  Map<String, FormElementTemplate> get flatFields =>
      Map.unmodifiable(_flatFields);

  Map<String, String> get label => Map.unmodifiable(formTemplate.label);

  List<String> get orgUnits => <String>[];

  IList<FormElementTemplate> get flatFieldsList =>
      _flatFields.values.toList().lock;
}

sealed class FormElementTemplate with TreeElement, EquatableMixin {
  FormElementTemplate({
    this.id,
    this.name,
    this.path,
    required this.parent,
    required this.namePath,
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

  final String? id;
  final String? name;
  final String? parent;
  final bool readOnly;
  final String? path;
  final String? namePath;
  final int order;
  final String? fieldValueRenderingType;
  final Map<String, dynamic> _label = {};
  final List<Rule> _rules = [];
  final List<String> _ruleDependencies = [];
  final Map<String, dynamic> _properties = {};
  final IList<FormElementTemplate> children = IList();

  ValueType get type;

  Map<String, String> get label => Map.unmodifiable(_label);

  List<Rule> get rules => List.unmodifiable(_rules);

  List<String> get ruleDependencies => List.unmodifiable(_ruleDependencies);

  Map<String, dynamic> get properties => Map.unmodifiable(_properties);

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
    super.parent,
    required super.namePath,
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
      super.parent,
      required super.namePath,
      super.path,
      super.order,
      super.fieldValueRenderingType,
      super.ruleDependencies,
      super.rules,
      super.label,
      super.properties,
      this.repeatCount = 1,
      required this.repeatable,
      Iterable<FormElementTemplate>? children,
      this.itemTitle})
      : this.children = IList.orNull(children) ?? IList();

  final String? itemTitle;
  final int repeatCount;
  final bool repeatable;

  final IList<FormElementTemplate> children;

  @override
  ValueType get type => ValueType.Section;
}
