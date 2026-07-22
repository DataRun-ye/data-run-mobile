import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/assignment_model.dart';
import 'package:datarunmobile/database/shared/d_identifiable_model.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/features/assignment/application/assignment_filter.provider.dart';
import 'package:datarunmobile/features/assignment/application/assignment_model.provider.dart';
import 'package:datarunmobile/features/assignment/presentation/assignment_screen.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/assignment_detail_page.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    await rSdkLocator.reset();
    db = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'test-user',
    );
    rSdkLocator.registerSingleton<AppDatabase>(db);
  });

  tearDown(() async {
    await db.close();
    await rSdkLocator.reset();
  });

  test('assignment providers are keyed by activity id', () async {
    await db.into(db.projects).insert(
          ProjectsCompanion.insert(id: 'project-a', name: 'Project A'),
        );
    await db.batch((batch) {
      batch.insertAll(db.activities, [
        ActivitiesCompanion.insert(
          id: 'activity-a',
          name: 'Activity A',
          project: 'project-a',
        ),
        ActivitiesCompanion.insert(
          id: 'activity-b',
          name: 'Activity B',
          project: 'project-a',
        ),
      ]);
      batch.insertAll(db.orgUnits, [
        OrgUnitsCompanion.insert(
          id: 'org-unit-a',
          name: 'Org unit A',
          path: 'org-unit-a',
          level: 1,
        ),
        OrgUnitsCompanion.insert(
          id: 'org-unit-b',
          name: 'Org unit B',
          path: 'org-unit-b',
          level: 1,
        ),
      ]);
      batch.insertAll(db.teams, [
        TeamsCompanion.insert(id: 'team-a', activity: 'activity-a'),
        TeamsCompanion.insert(id: 'team-b', activity: 'activity-b'),
      ]);
    });
    await db.batch((batch) {
      batch.insertAll(db.assignments, [
        AssignmentsCompanion.insert(
          id: 'assignment-a',
          activity: 'activity-a',
          team: 'team-a',
          orgUnit: 'org-unit-a',
          syncState: InstanceSyncStatus.synced,
          disabled: const Value(false),
        ),
        AssignmentsCompanion.insert(
          id: 'assignment-b',
          activity: 'activity-b',
          team: 'team-b',
          orgUnit: 'org-unit-b',
          syncState: InstanceSyncStatus.synced,
          disabled: const Value(false),
        ),
      ]);
    });

    final container = ProviderContainer();
    addTearDown(container.dispose);

    final activityAAssignments =
        await container.read(assignmentsProvider('activity-a').future);
    final activityBAssignments =
        await container.read(assignmentsProvider('activity-b').future);

    expect(activityAAssignments.map((item) => item.id), ['assignment-a']);
    expect(activityBAssignments.map((item) => item.id), ['assignment-b']);
  });

  testWidgets('assignment navigation keeps one root provider scope',
      (tester) async {
    const activityId = 'activity-a';
    final assignment = AssignmentModel(
      id: 'assignment-a',
      orgUnit: IdentifiableModel(
        id: 'org-unit-a',
        code: 'OU-A',
        name: 'Org unit A',
      ),
      team: IdentifiableModel(
        id: 'team-a',
        code: 'TEAM-A',
        name: 'Team A',
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          filterAssignmentsProvider(activityId)
              .overrideWith((ref) async => [assignment]),
          filterQueryProvider.overrideWithValue(
            AssignmentFilterQuery(isCardView: true),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const AssignmentScreen(
                        activityId: activityId,
                      ),
                    ),
                  ),
                  child: const Text('Open assignments'),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(ProviderScope), findsOneWidget);

    await tester.tap(find.text('Open assignments'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Org unit A'), findsOneWidget);
    expect(find.byType(ProviderScope), findsOneWidget);

    await tester.tap(find.byType(TextFormField));
    await tester.pump();
    expect(tester.takeException(), isNull);

    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pumpAndSettle();

    expect(find.byType(AssignmentDetailPage), findsOneWidget);
    expect(find.byType(ProviderScope), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Open assignments'), findsOneWidget);
    expect(find.byType(ProviderScope), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
