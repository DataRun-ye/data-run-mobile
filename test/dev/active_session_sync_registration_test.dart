import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/db_factory/database_factory.dart';
import 'package:datarunmobile/datasource/abstract_datasource.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/di/init_active_session_scope.dart';
import 'package:datarunmobile/app/di/injection.dart' as app_di;
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  test('database dependencies use the supplied locator', () async {
    final getIt = GetIt.asNewInstance();
    addTearDown(getIt.reset);

    registerDatabaseDependencies(getIt);

    expect(getIt.isRegistered<DatabaseFactory>(), isTrue);
    expect(getIt<DatabaseFactory>(), same(getIt<DatabaseFactory>()));
  });

  test('active session sync contains configuration resources only', () async {
    final getIt = GetIt.asNewInstance()
      ..enableRegisteringMultipleInstancesOfOneType();
    addTearDown(getIt.reset);
    final database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'registration-test-user',
    );
    addTearDown(database.close);
    getIt.registerSingleton<AppDatabase>(database);
    getIt.registerSingleton<HttpClient<dynamic>>(_UnusedHttpClient());

    registerUserConfigurationDatasources(getIt);

    final resourceNames = getIt
        .getAll<AbstractDatasource<dynamic>>()
        .map((source) => source.resourceName)
        .toList();

    expect(
      resourceNames.toSet(),
      unorderedEquals({
        'projects',
        'activities',
        'ouLevels',
        'orgUnits',
        'optionSets',
        'formTemplates',
        'teams',
        'formPermissions',
        'assignments',
        'referenceEntries',
      }),
    );
    expect(resourceNames, isNot(contains('dataSubmission')));
    expect(
      resourceNames.indexOf('referenceEntries'),
      greaterThan(resourceNames.indexOf('assignments')),
    );
  });

  test('app layers share one locator instance', () {
    expect(app_di.appLocator, same(appLocator));
  });
}

class _UnusedHttpClient extends HttpClient<dynamic> {
  @override
  Future<Response<dynamic>> request({
    required String resourceName,
    String? path,
    required String method,
    Object? data,
    Map<String, dynamic>? headers,
  }) {
    throw StateError('HTTP is not used by registration tests');
  }
}
