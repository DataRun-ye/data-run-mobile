import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/core/sync/model/sync_progress_event.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/datasource/remote_data_sources/assignment_datasource.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    await appLocator.reset();
    database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'assignment-form-sync-test',
    );
    await _seedStaleAccess(database);
    appLocator.registerSingleton<AppDatabase>(database);
  });

  tearDown(() async {
    await database.close();
    await appLocator.reset();
  });

  test('successful empty response clears access even with zero assignments',
      () async {
    final client = _AssignmentHttpClient();
    appLocator.registerSingleton<HttpClient<dynamic>>(client);
    final events = <SyncProgressEvent>[];

    await AssignmentDatasource().syncWithRemote(
      progressCallback: events.add,
    );

    expect(client.requestedResources, [
      'assignments?paged=false',
      'assignments/forms?paged=false&referenceVersion=1',
    ]);
    expect(await database.select(database.assignmentForms).get(), isEmpty);
    expect(events.last.syncProgressState, SyncProgressState.SUCCEEDED);
  });

  test('failed forms response preserves existing offline access', () async {
    final client = _AssignmentHttpClient(failForms: true);
    appLocator.registerSingleton<HttpClient<dynamic>>(client);
    final events = <SyncProgressEvent>[];

    await AssignmentDatasource().syncWithRemote(
      progressCallback: events.add,
    );

    expect(
      await database.select(database.assignmentForms).get(),
      hasLength(1),
    );
    expect(events.last.syncProgressState, SyncProgressState.PARTIAL_ERROR);
  });
}

Future<void> _seedStaleAccess(AppDatabase database) {
  return database.customStatement('''
    INSERT INTO org_units (id, translations, name, path, level)
    VALUES ('org-1', '{}', 'Org unit', '/org-1', 1);
    INSERT INTO projects (id, translations, name)
    VALUES ('project-1', '{}', 'Project');
    INSERT INTO activities (id, translations, name, project)
    VALUES ('activity-1', '{}', 'Activity', 'project-1');
    INSERT INTO teams (id, activity)
    VALUES ('team-1', 'activity-1');
    INSERT INTO assignments
      (id, activity, team, org_unit, sync_state, disabled)
    VALUES
      ('assignment-1', 'activity-1', 'team-1', 'org-1', 'synced', 0);
    INSERT INTO form_templates
      (id, version_uid, version_number, name)
    VALUES ('form-1', 'version-1', 1, 'Form');
    INSERT INTO assignment_forms
      (assignment, form, can_add_submissions)
    VALUES ('assignment-1', 'form-1', 1);
  ''');
}

class _AssignmentHttpClient extends HttpClient<dynamic> {
  _AssignmentHttpClient({this.failForms = false});

  final bool failForms;
  final List<String> requestedResources = [];

  @override
  Future<Response<dynamic>> request({
    required String resourceName,
    String? path,
    required String method,
    Object? data,
    Map<String, dynamic>? headers,
  }) async {
    requestedResources.add(resourceName);
    if (resourceName ==
            'assignments/forms?paged=false&referenceVersion=1' &&
        failForms) {
      throw StateError('assignment forms unavailable');
    }
    final responseData = resourceName == 'assignments?paged=false'
        ? <String, dynamic>{'assignments': []}
        : <String, dynamic>{'assignments': []};
    return Response<dynamic>(
      data: responseData,
      statusCode: 200,
      requestOptions: RequestOptions(path: resourceName),
    );
  }
}
