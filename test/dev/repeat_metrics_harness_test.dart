import 'dart:convert';

import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/core/form/element_iterator/form_element_iterator.dart';
import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'support/form_template_fixture.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late bool loggingWasEnabled;

  setUpAll(() {
    loggingWasEnabled = logger.isLogEnabled;
    logger.isLogEnabled = false;
  });

  tearDownAll(() {
    logger.isLogEnabled = loggingWasEnabled;
  });

  test('profile ITNs repeat form at multiple row counts', () async {
    const formPath =
        'test/fixtures/legacy_forms/ITNs Household Distribution Form.json';
    const submissionPath =
        'test/fixtures/legacy_submissions/ITNs Household Distribution submission.json';
    const repeatPath = ['households_information', 'householdnames'];
    const rowCounts = [50, 150, 300];

    final formJson = await readJsonMap(formPath);
    final submissionJson = await readJsonMap(submissionPath);
    final baseFormData =
        Map<String, Object?>.from(submissionJson['formData'] as Map);

    for (final rowCount in rowCounts) {
      final template = formTemplateFromJson(formJson);
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

  test('profile live outside-to-repeat rule fan-out', () async {
    final formJson = await readJsonMap(
      'test/fixtures/live_forms/ONIaOpzoYAe-v53.json',
    );

    for (final rowCount in const [50, 150, 300]) {
      final repository = FormTemplateRepository.inMemory(
        formTemplateModel: formTemplateFromJson(formJson),
      );
      final formData = <String, Object?>{
        'locations': <String, Object?>{
          'Indoor_Surveillance_Type': 'Adult',
        },
        'adult': <String, Object?>{
          'adult_mosquito_present': 'yes',
          'adultClassification': List.generate(
            rowCount,
            (_) => <String, Object?>{
              'AdultMosquitoSpecies': 'Anopheles',
            },
          ),
        },
        'larval': <String, Object?>{'habitats': <Object?>[]},
      };
      final root = _buildForm(repository: repository, formData: formData);
      final locations = root.element('locations') as Section;
      final surveillanceType = locations.element('Indoor_Surveillance_Type')
          as FieldInstance<String>;
      final adult = root.element('adult') as Section;
      final classifications =
          adult.element('adultClassification') as RepeatSection;

      surveillanceType.updateValue('AdultAndLarval', emitEvent: false);
      surveillanceType.updateValue('Adult', emitEvent: false);

      const toggleCount = 20;
      final updateWatch = Stopwatch()..start();
      for (var index = 0; index < toggleCount; index++) {
        surveillanceType.updateValue(
          index.isEven ? 'AdultAndLarval' : 'Adult',
          emitEvent: false,
        );
      }
      updateWatch.stop();

      final microsPerToggle = updateWatch.elapsedMicroseconds ~/ toggleCount;
      // ignore: avoid_print
      print('repeatFanout ${jsonEncode({
            'repeatRowCount': rowCount,
            'dependentCount': surveillanceType.dependents.length,
            'microsPerToggle': microsPerToggle,
          })}');

      expect(classifications.elements, hasLength(rowCount));
      expect(classifications.visible, isTrue);
      expect(
        classifications.elements.every((row) =>
            (row.element('AdultMosquitoSpecies') as FieldInstance<dynamic>)
                .visible),
        isTrue,
      );
      root.dispose();
    }
  });
}

Section _buildForm({
  required FormTemplateRepository repository,
  required Map<String, Object?> formData,
}) {
  final form = FormGroup(
    FormElementControlBuilder.formDataControls(repository, formData),
  );
  return Section(
    template: repository.rootSection,
    elements: FormElementBuilder.buildFormElements(
      form,
      repository,
      initialFormValue: formData,
    ),
    form: form,
  )
    ..bindControlReferences()
    ..resolveDependencies()
    ..evaluate(emitEvent: false);
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

  final root = Section(
    template: repository.rootSection,
    elements: elements,
    form: form,
  );

  final bindWatch = Stopwatch()..start();
  root.bindControlReferences();
  bindWatch.stop();

  final resolveWatch = Stopwatch()..start();
  root.resolveDependencies();
  resolveWatch.stop();

  final evaluateWatch = Stopwatch()..start();
  root.evaluate(emitEvent: false);
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
    bindControlMs: bindWatch.elapsedMilliseconds,
    dependencyResolveMs: resolveWatch.elapsedMilliseconds,
    ruleEvaluateMs: evaluateWatch.elapsedMilliseconds,
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
    required this.bindControlMs,
    required this.dependencyResolveMs,
    required this.ruleEvaluateMs,
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
  final int bindControlMs;
  final int dependencyResolveMs;
  final int ruleEvaluateMs;
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
        'bindControlMs': bindControlMs,
        'dependencyResolveMs': dependencyResolveMs,
        'ruleEvaluateMs': ruleEvaluateMs,
        'reduceMs': reduceMs,
        'jsonEncodeMs': jsonEncodeMs,
        'elementCount': elementCount,
        'fieldCount': fieldCount,
        'repeatSectionCount': repeatSectionCount,
        'repeatRowCount': repeatRowCount,
        'jsonBytes': jsonBytes,
      };
}
