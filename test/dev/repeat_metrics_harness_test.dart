import 'dart:convert';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/database/shared/form_option.dart';
import 'package:d_sdk/database/shared/form_template_model.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/core/form/element_iterator/form_element_iterator.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/rule_effect_state_factory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    if (!appLocator.isRegistered<RuleEffectStateFactory>()) {
      appLocator.registerFactory<RuleEffectStateFactory>(
        RuleEffectStateFactory.new,
      );
    }
  });

  test('profile ITNs repeat form at multiple row counts', () async {
    const formPath = 'example/ITNs Household Distribution Form.json';
    const submissionPath =
        'example/ITNs Household Distribution submission.json';
    const repeatPath = ['households_information', 'householdnames'];
    const rowCounts = [50, 150, 300];

    final formJson = await _readJsonFile(formPath);
    final submissionJson = await _readJsonFile(submissionPath);
    final baseFormData =
        Map<String, Object?>.from(submissionJson['formData'] as Map);

    for (final rowCount in rowCounts) {
      final template = _templateModelFromJson(formJson);
      final repository = FormTemplateRepository.inMemory(
        formTemplateModel: template,
      );
      final formData = _withRepeatRows(
        baseFormData,
        repeatPath: repeatPath,
        rowCount: rowCount,
      );

      final metrics = _profileFormBuildAndReduce(
        repository: repository,
        formData: formData,
      );

      // ignore: avoid_print
      print('repeatProfile ${jsonEncode(metrics.toJson())}');

      expect(metrics.repeatRowCount, rowCount);
      expect(metrics.elementCount, greaterThan(rowCount));
      expect(metrics.jsonBytes, greaterThan(0));
    }
  });
}

RepeatProfileMetrics _profileFormBuildAndReduce({
  required FormTemplateRepository repository,
  required Map<String, Object?> formData,
}) {
  final totalWatch = Stopwatch()..start();

  final controlWatch = Stopwatch()..start();
  final form = FormGroup(
    FormElementControlBuilder.formDataControls(repository, formData),
  );
  controlWatch.stop();

  final elementBuildWatch = Stopwatch()..start();
  final elements = FormElementBuilder.buildFormElements(
    form,
    repository,
    initialFormValue: formData,
  );
  elementBuildWatch.stop();

  final evaluateWatch = Stopwatch()..start();
  final root = Section(
    template: repository.rootSection,
    elements: elements,
    form: form,
  )
    ..resolveDependencies()
    ..evaluate(emitEvent: false);
  evaluateWatch.stop();

  final allElements = getFormElementIterator<FormElementInstance<dynamic>>(root)
      .toList(growable: false);

  final reduceWatch = Stopwatch()..start();
  final reduced = root.value;
  reduceWatch.stop();

  final jsonWatch = Stopwatch()..start();
  final jsonBytes = utf8.encode(jsonEncode(reduced)).length;
  jsonWatch.stop();
  totalWatch.stop();

  return RepeatProfileMetrics(
    totalMs: totalWatch.elapsedMilliseconds,
    controlBuildMs: controlWatch.elapsedMilliseconds,
    elementBuildMs: elementBuildWatch.elapsedMilliseconds,
    dependencyEvaluateMs: evaluateWatch.elapsedMilliseconds,
    reduceMs: reduceWatch.elapsedMilliseconds,
    jsonEncodeMs: jsonWatch.elapsedMilliseconds,
    elementCount: allElements.length,
    fieldCount: allElements.whereType<FieldInstance<dynamic>>().length,
    repeatSectionCount: allElements.whereType<RepeatSection>().length,
    repeatRowCount: allElements
        .whereType<RepeatSection>()
        .fold<int>(0, (total, repeat) => total + repeat.elements.length),
    jsonBytes: jsonBytes,
  );
}

Future<Map<String, dynamic>> _readJsonFile(String path) async {
  return jsonDecode(await File(path).readAsString()) as Map<String, dynamic>;
}

FormTemplateModel _templateModelFromJson(Map<String, dynamic> json) {
  final normalized = _withTemplatePaths(json);
  return FormTemplateModel(
    id: normalized['uid'] as String? ?? normalized['id'] as String,
    name: normalized['name'] as String,
    code: normalized['code'] as String?,
    label: normalized['label'] as Map<String, dynamic>?,
    versionUid:
        normalized['versionUid'] as String? ?? normalized['uid'] as String,
    versionNumber: normalized['versionNumber'] as int? ?? 1,
    fields: BuiltList<Template>(
      (normalized['fields'] as List)
          .cast<Map<String, dynamic>>()
          .map(Template.fromJsonFactory),
    ),
    sections: BuiltList<Template>(
      (normalized['sections'] as List)
          .cast<Map<String, dynamic>>()
          .map(Template.fromJsonFactory),
    ),
    options: BuiltList<FormOption>(),
  );
}

Map<String, dynamic> _withTemplatePaths(Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);
  final sections = (json['sections'] as List)
      .cast<Map<String, dynamic>>()
      .map((section) => Map<String, dynamic>.from(section))
      .toList();
  final fields = (json['fields'] as List)
      .cast<Map<String, dynamic>>()
      .map((field) => Map<String, dynamic>.from(field))
      .toList();

  final sectionById = {
    for (final section in sections) section['id'] as String: section,
  };

  String sectionPath(Map<String, dynamic> section) {
    final existingPath = section['path'] as String?;
    if (existingPath != null && existingPath.isNotEmpty) {
      return existingPath;
    }

    final parentId = section['parent'] as String?;
    final name = section['name'] as String;
    if (parentId == null || !sectionById.containsKey(parentId)) {
      return name;
    }

    return '${sectionPath(sectionById[parentId]!)}.$name';
  }

  for (final section in sections) {
    section['path'] = sectionPath(section);
  }

  for (final field in fields) {
    final parentId = field['parent'] as String?;
    final name = field['name'] as String;
    if (field['path'] == null && parentId != null) {
      field['path'] = '${sectionPath(sectionById[parentId]!)}.$name';
    }
  }

  normalized['sections'] = sections;
  normalized['fields'] = fields;
  return normalized;
}

Map<String, Object?> _withRepeatRows(
  Map<String, Object?> formData, {
  required List<String> repeatPath,
  required int rowCount,
}) {
  final copy = _deepCopyMap(formData);
  final parent = copy[repeatPath.first] as Map<String, Object?>;
  final existingRows =
      (parent[repeatPath.last] as List).cast<Map<String, Object?>>();
  final rows = <Map<String, Object?>>[];

  for (var index = 0; index < rowCount; index++) {
    final source = existingRows[index % existingRows.length];
    rows.add({
      ...Map<String, Object?>.from(source),
      'repeatUid': 'profile-repeat-${index + 1}',
      'householdHeadSerialNumber': 40000 + index + 1,
      '_index': index + 1,
    });
  }

  parent[repeatPath.last] = rows;
  return copy;
}

Map<String, Object?> _deepCopyMap(Map<String, Object?> value) {
  return Map<String, Object?>.from(jsonDecode(jsonEncode(value)) as Map);
}

class RepeatProfileMetrics {
  RepeatProfileMetrics({
    required this.totalMs,
    required this.controlBuildMs,
    required this.elementBuildMs,
    required this.dependencyEvaluateMs,
    required this.reduceMs,
    required this.jsonEncodeMs,
    required this.elementCount,
    required this.fieldCount,
    required this.repeatSectionCount,
    required this.repeatRowCount,
    required this.jsonBytes,
  });

  final int totalMs;
  final int controlBuildMs;
  final int elementBuildMs;
  final int dependencyEvaluateMs;
  final int reduceMs;
  final int jsonEncodeMs;
  final int elementCount;
  final int fieldCount;
  final int repeatSectionCount;
  final int repeatRowCount;
  final int jsonBytes;

  Map<String, Object?> toJson() => {
        'totalMs': totalMs,
        'controlBuildMs': controlBuildMs,
        'elementBuildMs': elementBuildMs,
        'dependencyEvaluateMs': dependencyEvaluateMs,
        'reduceMs': reduceMs,
        'jsonEncodeMs': jsonEncodeMs,
        'elementCount': elementCount,
        'fieldCount': fieldCount,
        'repeatSectionCount': repeatSectionCount,
        'repeatRowCount': repeatRowCount,
        'jsonBytes': jsonBytes,
      };
}
