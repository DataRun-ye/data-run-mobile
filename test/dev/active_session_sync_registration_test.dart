import 'package:datarunmobile/database/db_factory/database_factory.dart';
import 'package:datarunmobile/datasource/abstract_datasource.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/di/init_active_session_scope.dart';
import 'package:datarunmobile/app/di/injection.dart' as app_di;
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

    registerUserConfigurationDatasources(getIt);

    final resourceNames = getIt
        .getAll<AbstractDatasource<dynamic>>()
        .map((source) => source.resourceName)
        .toSet();

    expect(
      resourceNames,
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
      }),
    );
    expect(resourceNames, isNot(contains('dataSubmission')));
  });

  test('app layers share one locator instance', () {
    expect(app_di.appLocator, same(appLocator));
  });
}
