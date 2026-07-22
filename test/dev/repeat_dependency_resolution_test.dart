import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'support/form_template_fixture.dart';

void main() {
  test('live nested-repeat dependencies stay within their outer and inner rows',
      () async {
    final repository = formRepositoryFromJson(await readJsonMap(
      'test/fixtures/live_forms/YLcsWJlB7uy-v4.json',
    ));
    final initialValue = <String, Object?>{
      'patients': [
        <String, Object?>{
          'is_test_preformed': 'yes',
          'investigations': [
            <String, Object?>{
              'lab_test_type': 'mrdt',
              'test_result': 'positive',
            },
            <String, Object?>{
              'lab_test_type': 'none',
            },
          ],
        },
        <String, Object?>{
          'is_test_preformed': 'no',
          'investigations': [
            <String, Object?>{
              'lab_test_type': 'microscopy',
              'test_result': 'negative',
            },
          ],
        },
      ],
    };
    final root = _buildForm(repository, initialValue);
    final patients = root.element('patients') as RepeatSection;
    final firstPatient = patients.elements[0];
    final secondPatient = patients.elements[1];
    final firstInvestigations =
        firstPatient.element('investigations') as RepeatSection;
    final secondInvestigations =
        secondPatient.element('investigations') as RepeatSection;

    expect(firstInvestigations.visible, isTrue);
    expect(secondInvestigations.hidden, isTrue);

    final firstLabType = firstInvestigations.elements[0]
        .element('lab_test_type') as FieldInstance<String>;
    final firstTestResult = firstInvestigations.elements[0]
        .element('test_result') as FieldInstance<String>;
    final secondLabType = firstInvestigations.elements[1]
        .element('lab_test_type') as FieldInstance<String>;
    final secondTestResult = firstInvestigations.elements[1]
        .element('test_result') as FieldInstance<String>;

    expect(firstTestResult.visible, isTrue);
    expect(secondTestResult.hidden, isTrue);

    secondLabType.updateValue('microscopy', emitEvent: false);

    expect(firstTestResult.visible, isTrue);
    expect(secondTestResult.visible, isTrue);

    firstLabType.updateValue('none', emitEvent: false);

    expect(firstTestResult.hidden, isTrue);
    expect(secondTestResult.visible, isTrue);

    final beforeHide = root.value;
    final firstPatientBeforeHide =
        (beforeHide['patients'] as List).first as Map<String, Object?>;
    final investigationsBeforeHide =
        firstPatientBeforeHide['investigations'] as List;
    final nestedIdsBeforeHide = investigationsBeforeHide
        .cast<Map<String, Object?>>()
        .map((row) => row['_id'])
        .toList();

    final secondPerformed =
        secondPatient.element('is_test_preformed') as FieldInstance<String>;
    secondPerformed.updateValue('yes', emitEvent: false);

    expect(firstInvestigations.visible, isTrue);
    expect(secondInvestigations.visible, isTrue);

    final firstPerformed =
        firstPatient.element('is_test_preformed') as FieldInstance<String>;
    firstPerformed.updateValue('no', emitEvent: false);

    expect(firstInvestigations.hidden, isTrue);
    expect(secondInvestigations.visible, isTrue);
    expect(firstLabType.value, 'none');
    expect(secondLabType.value, 'microscopy');
    final whileHidden = root.value;
    final firstPatientWhileHidden =
        (whileHidden['patients'] as List).first as Map<String, Object?>;
    expect(firstPatientWhileHidden, isNot(contains('investigations')));

    firstPerformed.updateValue('yes', emitEvent: false);

    expect(firstInvestigations.visible, isTrue);
    expect(firstInvestigations.elements, hasLength(2));
    expect(firstLabType.value, 'none');
    expect(secondLabType.value, 'microscopy');
    final afterShow = root.value;
    final firstPatientAfterShow =
        (afterShow['patients'] as List).first as Map<String, Object?>;
    final investigationsAfterShow =
        firstPatientAfterShow['investigations'] as List;
    expect(
      investigationsAfterShow
          .cast<Map<String, Object?>>()
          .map((row) => row['_id']),
      nestedIdsBeforeHide,
    );
    root.dispose();
  });

  test('live root dependency controls repeat sections without cross-effects',
      () async {
    final repository = formRepositoryFromJson(await readJsonMap(
      'test/fixtures/live_forms/woOl5yAmi8C-v9.json',
    ));
    final initialValue = <String, Object?>{
      'main': <String, Object?>{'report_type_ds': 'summary'},
      'summary': [<String, Object?>{}],
      'irsHouses': [<String, Object?>{}],
    };
    final root = _buildForm(repository, initialValue);
    final main = root.element('main') as Section;
    final reportType = main.element('report_type_ds') as FieldInstance<String>;
    final summary = root.element('summary') as RepeatSection;
    final details = root.element('irsHouses') as RepeatSection;

    expect(summary.visible, isTrue);
    expect(details.hidden, isTrue);

    reportType.updateValue('details', emitEvent: false);

    expect(summary.hidden, isTrue);
    expect(details.visible, isTrue);

    reportType.updateValue('summary', emitEvent: false);

    expect(summary.visible, isTrue);
    expect(details.hidden, isTrue);
    root.dispose();
  });

  test('live sibling dependencies reach repeat rows and preserve row scope',
      () async {
    final repository = formRepositoryFromJson(await readJsonMap(
      'test/fixtures/live_forms/ONIaOpzoYAe-v53.json',
    ));
    final initialValue = <String, Object?>{
      'locations': <String, Object?>{
        'Indoor_Surveillance_Type': 'Adult',
      },
      'adult': <String, Object?>{
        'adult_mosquito_present': 'yes',
        'adultClassification': [
          <String, Object?>{'AdultMosquitoSpecies': 'OtherSpecies'},
          <String, Object?>{'AdultMosquitoSpecies': 'Anopheles'},
        ],
      },
      'larval': <String, Object?>{
        'habitats': [<String, Object?>{}],
      },
    };
    final root = _buildForm(repository, initialValue);
    final locations = root.element('locations') as Section;
    final surveillanceType =
        locations.element('Indoor_Surveillance_Type') as FieldInstance<String>;
    final adult = root.element('adult') as Section;
    final adultPresent =
        adult.element('adult_mosquito_present') as FieldInstance<String>;
    final classifications =
        adult.element('adultClassification') as RepeatSection;
    final firstSpecies = classifications.elements[0]
        .element('AdultMosquitoSpecies') as FieldInstance<String>;
    final firstOtherSpecies = classifications.elements[0]
        .element('OtherAdultMosquitoSpecies') as FieldInstance<String>;
    final secondSpecies = classifications.elements[1]
        .element('AdultMosquitoSpecies') as FieldInstance<String>;
    final secondOtherSpecies = classifications.elements[1]
        .element('OtherAdultMosquitoSpecies') as FieldInstance<String>;
    final larval = root.element('larval') as Section;
    final habitats = larval.element('habitats') as RepeatSection;

    expect(adult.visible, isTrue);
    expect(classifications.visible, isTrue);
    expect(firstSpecies.visible, isTrue);
    expect(secondSpecies.visible, isTrue);
    expect(firstOtherSpecies.visible, isTrue);
    expect(secondOtherSpecies.hidden, isTrue);
    expect(larval.hidden, isTrue);
    expect(habitats.hidden, isTrue);

    surveillanceType.updateValue('Larval', emitEvent: false);

    expect(adult.hidden, isTrue);
    expect(classifications.hidden, isTrue);
    expect(classifications.elements[0].hidden, isTrue);
    expect(classifications.elements[1].hidden, isTrue);
    expect(firstSpecies.hidden, isTrue);
    expect(larval.visible, isTrue);
    expect(habitats.visible, isTrue);

    surveillanceType.updateValue('AdultAndLarval', emitEvent: false);

    expect(adult.visible, isTrue);
    expect(adultPresent.value, 'yes');
    expect(classifications.visible, isTrue);
    expect(classifications.elements[0].visible, isTrue);
    expect(classifications.elements[1].visible, isTrue);
    expect(firstSpecies.visible, isTrue);
    expect(firstSpecies.value, 'OtherSpecies');
    expect(secondSpecies.value, 'Anopheles');
    expect(firstOtherSpecies.visible, isTrue);
    expect(secondOtherSpecies.hidden, isTrue);
    expect(larval.visible, isTrue);
    expect(habitats.visible, isTrue);
    expect(
      firstSpecies.resolvedDependencies.map((element) => element.elementPath),
      containsAll(<String>[
        'locations.Indoor_Surveillance_Type',
        'adult.adult_mosquito_present',
      ]),
    );
    expect(
        firstSpecies.evalContext['Indoor_Surveillance_Type'], 'AdultAndLarval');
    expect(firstSpecies.evalContext['adult_mosquito_present'], 'yes');
    expect(firstSpecies.visible, isTrue);
    expect(secondOtherSpecies.hidden, isTrue);
    root.dispose();
  });
}

Section _buildForm(
  FormTemplateRepository repository,
  Map<String, Object?> initialValue,
) {
  final form = FormGroup(
    FormElementControlBuilder.formDataControls(repository, initialValue),
  );
  return Section(
    template: repository.rootSection,
    form: form,
    elements: FormElementBuilder.buildFormElements(
      form,
      repository,
      initialFormValue: initialValue,
    ),
  )
    ..bindControlReferences()
    ..resolveDependencies()
    ..evaluate(emitEvent: false);
}
