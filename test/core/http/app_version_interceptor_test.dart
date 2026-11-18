import 'dart:typed_data';

import 'package:datarunmobile/core/http/app_version_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  late _CapturingAdapter adapter;

  Dio client(AppVersionInterceptor interceptor) {
    adapter = _CapturingAdapter();
    return Dio(BaseOptions(baseUrl: 'https://server.test'))
      ..httpClientAdapter = adapter
      ..interceptors.add(interceptor);
  }

  test('sends the app version on every request', () async {
    var reads = 0;
    final dio = client(AppVersionInterceptor(readVersion: () async {
      reads++;
      return '6.1.0+55';
    }));

    await dio.get<dynamic>('/api/v1/assignments');
    await dio.get<dynamic>('/api/v1/teams');

    expect(adapter.headers, hasLength(2));
    for (final headers in adapter.headers) {
      expect(headers[AppVersionInterceptor.header], '6.1.0+55');
    }
    expect(reads, 1);
  });

  test('sends the request without the header when the version is unknown',
      () async {
    final dio = client(AppVersionInterceptor(
      readVersion: () async => throw StateError('no package info'),
    ));

    final response = await dio.get<dynamic>('/api/v1/assignments');

    expect(response.statusCode, 200);
    expect(adapter.headers.single.containsKey(AppVersionInterceptor.header),
        isFalse);
  });

  test('reads the installed version and build number', () async {
    PackageInfo.setMockInitialValues(
      appName: 'DataRun',
      packageName: 'datarunmobile',
      version: '6.1.0',
      buildNumber: '55',
      buildSignature: '',
    );
    final dio = client(AppVersionInterceptor());

    await dio.get<dynamic>('/api/v1/assignments');

    expect(adapter.headers.single[AppVersionInterceptor.header], '6.1.0+55');
  });
}

class _CapturingAdapter implements HttpClientAdapter {
  final List<Map<String, dynamic>> headers = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    headers.add(Map.of(options.headers));
    return ResponseBody.fromString('{}', 200, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });
  }

  @override
  void close({bool force = false}) {}
}
