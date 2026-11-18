import 'dart:io' show HttpDate;
import 'dart:typed_data';

import 'package:datarunmobile/core/http/server_clock.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final serverTime = DateTime.utc(2026, 11, 23, 9);

  test('measures how far the phone clock is from the server', () {
    final clock = ServerClock();

    clock.record(
      HttpDate.format(serverTime),
      phoneNow: serverTime.add(const Duration(minutes: 20)),
    );
    expect(clock.skew.value, const Duration(minutes: 20));
    expect(clock.isWrong, isFalse);

    clock.record(
      HttpDate.format(serverTime),
      phoneNow: serverTime.subtract(const Duration(days: 2)),
    );
    expect(clock.skew.value, const Duration(days: -2));
    expect(clock.isWrong, isTrue);
  });

  test('ignores a missing or malformed Date header', () {
    final clock = ServerClock();

    clock.record(null);
    clock.record('yesterday');

    expect(clock.skew.value, isNull);
    expect(clock.isWrong, isFalse);
  });

  test('reads the Date header of successful and failed responses', () async {
    final clock = ServerClock();
    final adapter = _DateAdapter(HttpDate.format(DateTime.now().toUtc()));
    final dio = Dio(BaseOptions(baseUrl: 'https://server.test'))
      ..httpClientAdapter = adapter
      ..interceptors.add(ServerClockInterceptor(clock: clock));

    await dio.get<dynamic>('/api/v1/assignments');
    expect(clock.skew.value!.abs(), lessThan(const Duration(minutes: 1)));

    clock.skew.value = null;
    adapter.status = 401;
    await expectLater(
      dio.get<dynamic>('/api/v1/assignments'),
      throwsA(isA<DioException>()),
    );
    expect(clock.skew.value, isNotNull);
  });
}

class _DateAdapter implements HttpClientAdapter {
  _DateAdapter(this.date);

  final String date;
  int status = 200;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString('{}', status, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
      'date': [date],
    });
  }

  @override
  void close({bool force = false}) {}
}
