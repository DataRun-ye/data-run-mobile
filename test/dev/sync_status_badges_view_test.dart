import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/features/sync_badges/sync_status_badges_view.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  testWidgets('keeps the loading badge within the action row height',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SyncStatusBadgesView(formId: 'form-1'),
          ),
        ),
      ),
    );

    final loading = find.byKey(
      const ValueKey('sync-status-badges-loading'),
    );
    expect(loading, findsOneWidget);
    expect(tester.getSize(loading), const Size.square(24));

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump();
  });

  testWidgets('renders live submission status counts from the scoped database',
      (tester) async {
    await db.into(db.dataInstances).insert(
          DataInstancesCompanion.insert(
            id: 'submission-1',
            formTemplate: 'form-1',
            templateVersion: 'version-1',
            syncState: InstanceSyncStatus.finalized,
            isToUpdate: false,
          ),
        );

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SyncStatusBadgesView(formId: 'form-1'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.cloud_upload), findsOneWidget);
    expect(find.text('1'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump();
  });
}
