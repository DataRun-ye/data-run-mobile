import 'dart:async';

import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/application/submission_list.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_submission_screen.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
