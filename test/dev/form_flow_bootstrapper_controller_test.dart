import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/exception/d_exception.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/features/form_submission/application/form_flow_bootstrapper_controller.dart';
import 'package:datarunmobile/features/form_submission/application/form_scope.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    await appLocator.reset();
    db = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'test-user',
    );
    appLocator.registerSingleton<AppDatabase>(db);
  });

  tearDown(() async {
    await db.close();
    await appLocator.reset();
  });

  test('new submission bootstrap requires a form id', () async {
    final controller = FormFlowBootstrapperController();

    await expectLater(
      controller.bootstrapFlow(null),
      throwsA(isA<DException>()),
    );
  });

  test('failed form construction drops the submission scope', () async {
    await db.into(db.dataInstances).insert(
          DataInstancesCompanion.insert(
            id: 'submission-1',
            formTemplate: 'form-1',
            templateVersion: 'missing-version',
            syncState: InstanceSyncStatus.draft,
            isToUpdate: false,
          ),
        );
    final controller = FormFlowBootstrapperController();

    await expectLater(
      controller.bootstrapFlow('submission-1'),
      throwsA(anything),
    );

    expect(appLocator.hasScope('submission-1'), isFalse);
  });

  test('closing a form scope runs its registered disposers', () async {
    var disposed = false;
    await appLocator.pushNewScopeAsync(
      scopeName: 'submission-1',
      init: (getIt) async {
        getIt.registerSingleton<_DisposableMarker>(
          _DisposableMarker(),
          dispose: (_) {
            disposed = true;
          },
        );
      },
    );

    await closeFormScope('submission-1');

    expect(appLocator.hasScope('submission-1'), isFalse);
    expect(disposed, isTrue);
  });
}

class _DisposableMarker {}
