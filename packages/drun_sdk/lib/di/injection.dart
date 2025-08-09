import 'package:d_sdk/core/auth/token_storage.dart';
import 'package:d_sdk/core/http/http_client.dart';
import 'package:d_sdk/core/secure_storage/storage_service.dart';
import 'package:d_sdk/database/dbManager.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

GetIt rSdkLocator = GetIt.instance;

@InjectableInit(
    initializerName: r'$initSdkGetIt',
    asExtension: false,
    ignoreUnregisteredTypes: [
      Dio,
      DbManager,
      HttpClient,
      StorageService,
      TokenStorage,
    ])
GetIt setupSdkLocator() {
  // rSdkLocator.enableRegisteringMultipleInstancesOfOneType();
  return $initSdkGetIt(rSdkLocator);
}
