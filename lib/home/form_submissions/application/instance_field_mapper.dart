import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/core/form/data/form_section_view_model.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:datarunmobile/core/form/model/section_ui_model_impl.dart';
import 'package:datarunmobile/core/form/ui/field_view_model_factory.dart';
import 'package:datarunmobile/home/form_submissions/application/instance_section_model.dart';

/// Result of mapping: a list of section models and a flat list of
/// field UI models.
class EventFieldMappingResult {
  EventFieldMappingResult(this.sections, this.fields);

  final List<InstanceSectionModel> sections;
  final List<FieldUiModel> fields;
}

class EventFieldMapper {
  EventFieldMapper(this._fieldFactory, this._mandatoryFieldWarning);

  final FieldViewModelFactory _fieldFactory;
  final String _mandatoryFieldWarning;

  int totalFields = 0;
  int unsupportedFields = 0;

  late List<String?> _visualDataElements;
  late Map<String?, List<FieldUiModel>> _fieldMap;
  late List<InstanceSectionModel> _eventSectionModels;
  late List<FieldUiModel> _finalFieldList;
  late Map<String, bool> _finalFields;

  EventFieldMappingResult map(
    List<FieldUiModel> fields,
    List<FormSectionViewModel> sectionList,
    String currentSection,
    Map<String, String> errors,
    Map<String, String> warnings,
    Map<String, FieldUiModel> emptyMandatoryFields,
    bool showWarningIndicators,
    bool showErrorIndicators,
  ) {
    _clearAll();
    _setFieldMap(
        fields, sectionList, showWarningIndicators, emptyMandatoryFields);

    for (var sectionModel in sectionList) {
      _handleSection(fields, sectionList, sectionModel, currentSection);
    }

    if (_eventSectionModels.isNotEmpty &&
        _eventSectionModels.first.sectionName == 'NO_SECTION') {
      _finalFieldList.add(_fieldFactory.createClosingSection());
    }

    // Update sections with error/warning counts
    if (showWarningIndicators || showErrorIndicators) {
      var sections = _finalFieldList.whereType<SectionUiModelImpl>().toList();
      for (var section in sections) {
        int errorCount = 0;
        int warningCount = 0;
        if (showWarningIndicators) {
          warningCount = warnings.keys
                  .where((uid) => fields.any((f) =>
                      f.uid == uid && f.programStageSection == section.uid))
                  .length +
              emptyMandatoryFields.values
                  .where((f) => f.programStageSection == section.uid)
                  .length;
        }
        if (showErrorIndicators) {
          errorCount = errors.keys
              .where((uid) => fields.any(
                  (f) => f.uid == uid && f.programStageSection == section.uid))
              .length;
        }
        section = section.copyWith(errors: errorCount, warnings: warningCount);

        // Replace in list
        var index = _finalFieldList.indexOf(section);
        _finalFieldList[index] = section;
      }
    }

    return EventFieldMappingResult(_eventSectionModels, _finalFieldList);
  }

  double completedFieldsPercentage() {
    final completed = _eventSectionModels
        .map((m) => m.numberOfCompletedFields)
        .fold<int>(0, (sum, v) => sum + v);
    return _calculateCompletionPercentage(completed, totalFields);
  }

  void _clearAll() {
    totalFields = 0;
    unsupportedFields = 0;
    _visualDataElements = <String?>[];
    _fieldMap = <String?, List<FieldUiModel>>{};
    _eventSectionModels = <InstanceSectionModel>[];
    _finalFieldList = <FieldUiModel>[];
    _finalFields = <String, bool>{};
  }

  void _setFieldMap(
    List<FieldUiModel> fields,
    List<FormSectionViewModel> sectionList,
    bool showMandatoryWarnings,
    Map<String, FieldUiModel> emptyMandatoryFields,
  ) {
    for (var field in fields) {
      final sectionKey = _getFieldSection(field);
      if (sectionKey.isNotEmpty || sectionList.length == 1) {
        final fieldModel = (showMandatoryWarnings &&
                emptyMandatoryFields.containsKey(field.uid))
            ? field.setWarning(_mandatoryFieldWarning)
            : field;

        _updateFieldMap(sectionKey, fieldModel);

        if (_fieldIsNotVisualOptionSet(field)) {
          totalFields++;
        } else if (!_visualDataElements.contains(field.uid)) {
          _visualDataElements.add(field.uid);
          totalFields++;
        }
        if (_isUnsupported(field.valueType)) {
          totalFields--;
          unsupportedFields++;
        }
      }
    }
  }

  String _getFieldSection(FieldUiModel field) =>
      field.programStageSection ?? '';

  void _updateFieldMap(String key, FieldUiModel field) {
    _fieldMap.putIfAbsent(key, () => <FieldUiModel>[]).add(field);
  }

  void _handleSection(
    List<FieldUiModel> fields,
    List<FormSectionViewModel> sectionList,
    FormSectionViewModel sectionModel,
    String currentSection,
  ) {
    if (_isValidMultiSection(sectionList, sectionModel)) {
      _handleMultiSection(sectionModel, currentSection);
    } else if (_isValidSingleSection(sectionList, sectionModel)) {
      _handleSingleSection(fields, sectionModel);
    }
  }

  bool _isValidMultiSection(
    List<FormSectionViewModel> sectionList,
    FormSectionViewModel sectionModel,
  ) {
    return sectionList.isNotEmpty &&
        (sectionModel.sectionUid?.isNotEmpty ?? false);
  }

  bool _isValidSingleSection(
    List<FormSectionViewModel> sectionList,
    FormSectionViewModel sectionModel,
  ) {
    return sectionList.length == 1 &&
        (sectionModel.sectionUid?.isEmpty ?? false);
  }

  void _handleMultiSection(
      FormSectionViewModel sectionModel, String currentSection) {
    final uid = sectionModel.sectionUid!;
    final fieldList = _fieldMap[uid] ?? [];
    _finalFields = {for (var f in fieldList) f.uid: !_isEmpty(f.value)};

    final completedCount = _finalFields.values.where((v) => v).length;
    _eventSectionModels.add(InstanceSectionModel(
      sectionUid: uid,
      sectionName: sectionModel.label!,
      numberOfCompletedFields: completedCount,
      numberOfTotalFields: _finalFields.length,
    ));

    final isOpen = uid == currentSection;
    if (fieldList.isNotEmpty) {
      _finalFieldList.add(_fieldFactory.createSection(
        uid,
        sectionModel.label,
        '',
        isOpen,
        _finalFields.length,
        completedCount,
        sectionModel.renderType,
        sectionModel.path ?? '',
      ));
    }
    if (isOpen) {
      _finalFieldList.addAll(fieldList);
    }
  }

  void _handleSingleSection(
    List<FieldUiModel> fields,
    FormSectionViewModel sectionModel,
  ) {
    for (var f in fields) {
      _finalFields[f.uid] = !_isEmpty(f.value);
    }
    final completedCount = _finalFields.values.where((v) => v).length;
    _eventSectionModels.add(InstanceSectionModel(
      sectionUid: 'no_section',
      sectionName: 'NO_SECTION',
      numberOfCompletedFields: completedCount,
      numberOfTotalFields: _finalFields.length,
    ));
    _finalFieldList.addAll(_fieldMap[sectionModel.sectionUid] ?? []);
  }

  bool _fieldIsNotVisualOptionSet(FieldUiModel field) {
    return field.optionSet == null ||
        (field.renderingType?.isVisualOptionSet == false);
  }

  bool _isUnsupported(ValueType? type) {
    return type == ValueType.TrackerAssociate || type == ValueType.Username;
  }

  bool _isEmpty(dynamic value) {
    if (value == null) return true;
    if (value is String) return value.isEmpty;
    return false;
  }

  double _calculateCompletionPercentage(int completed, int total) {
    if (total == 0) return 1.0;
    return completed / total;
  }
}
