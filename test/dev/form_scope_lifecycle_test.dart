import 'dart:async';

import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/application/form_scope.dart';
import 'package:datarunmobile/features/form_submission/application/submission_list.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_submission_screen.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUp(() => appLocator.reset());
  tearDown(() => appLocator.reset());

  testWidgets('removing the form route closes its submission scope',
      (tester) async {
    final registry = FieldContextRegistry();
    registry.getOrCreateKey('field');
    await appLocator.pushNewScopeAsync(
      scopeName: 'submission-1',
      init: (getIt) async {
        getIt.registerSingleton<FieldContextRegistry>(
          registry,
          dispose: (registry) => registry.dispose(),
        );
      },
    );
    final pendingEditStatus = Completer<bool>();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          submissionEditStatusProvider(submissionId: 'submission-1')
              .overrideWith((ref) => pendingEditStatus.future),
        ],
        child: const MaterialApp(
          home: FormSubmissionScreen(
            submissionId: 'submission-1',
            formId: 'form-1',
            versionId: 'version-1',
          ),
        ),
      ),
    );

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();

    expect(appLocator.hasScope('submission-1'), isFalse);
    expect(registry.getKey('field'), isNull);
  });

  // Leaving one form and opening the next within the close animation: the
  // first screen's dispose runs after the next form's scope was opened.
  test('closing a form leaves the next form open', () async {
    await openFormScope('form-a', _register('a'));
    final tokenA = formScopeToken('form-a');
    await openFormScope('form-b', _register('b'));

    await closeFormScope('form-a', token: tokenA);

    expect(appLocator.hasScope('form-a'), isFalse);
    expect(appLocator.hasScope('form-b'), isTrue);
    expect(appLocator<_Probe>().name, 'b');
  });

  test('closing waits for a form that is still opening', () async {
    await openFormScope('form-a', _register('a'));
    final tokenA = formScopeToken('form-a');
    final initStarted = Completer<void>();
    final templateLoaded = Completer<void>();

    final opening = openFormScope('form-b', (getIt) async {
      initStarted.complete();
      await templateLoaded.future;
      getIt.registerSingleton<_Probe>(_Probe('b'));
    });
    await initStarted.future;
    final closing = closeFormScope('form-a', token: tokenA);
    templateLoaded.complete();
    await opening;
    await closing;

    expect(appLocator.hasScope('form-a'), isFalse);
    expect(appLocator<_Probe>().name, 'b');
  });

  test('a late close does not close the same form reopened', () async {
    await openFormScope('form-a', _register('first'));
    final firstToken = formScopeToken('form-a');
    await openFormScope('form-a', _register('second'));

    await closeFormScope('form-a', token: firstToken);

    expect(appLocator<_Probe>().name, 'second');
    await closeFormScope('form-a', token: formScopeToken('form-a'));
    expect(appLocator.hasScope('form-a'), isFalse);
    expect(appLocator.isRegistered<_Probe>(), isFalse);
  });
}

Future<void> Function(GetIt getIt) _register(String name) =>
    (getIt) async => getIt.registerSingleton<_Probe>(_Probe(name));

class _Probe {
  _Probe(this.name);

  final String name;
}
