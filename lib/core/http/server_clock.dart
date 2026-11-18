import 'dart:io' show HttpDate, HttpException, HttpHeaders;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// How far this phone's clock is from the server's, measured from the `Date`
/// header of server responses.
///
/// Forms take "today" and entry times from the phone clock, so a phone set to
/// the wrong date records wrong dates without any error.
class ServerClock {
  ServerClock();

  static final ServerClock instance = ServerClock();

  /// Differences up to this are normal and not reported.
  static const tolerance = Duration(hours: 1);

  /// Phone time minus server time, from the latest response with a `Date`.
  final ValueNotifier<Duration?> skew = ValueNotifier(null);

  bool get isWrong => (skew.value?.abs() ?? Duration.zero) > tolerance;

  /// Server time now, estimated from the phone clock and [skew].
  DateTime? get serverNow {
    final offset = skew.value;
    return offset == null ? null : DateTime.now().subtract(offset);
  }

  void record(String? dateHeader, {DateTime? phoneNow}) {
    if (dateHeader == null) return;
    final DateTime serverTime;
    try {
      serverTime = HttpDate.parse(dateHeader);
    } on FormatException {
      return;
    } on HttpException {
      return;
    }
    skew.value = (phoneNow ?? DateTime.now()).toUtc().difference(serverTime);
  }
}

/// Feeds the `Date` header of every server response to a [ServerClock].
class ServerClockInterceptor extends Interceptor {
  ServerClockInterceptor({ServerClock? clock})
      : _clock = clock ?? ServerClock.instance;

  final ServerClock _clock;

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    _clock.record(response.headers.value(HttpHeaders.dateHeader));
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _clock.record(err.response?.headers.value(HttpHeaders.dateHeader));
    handler.next(err);
  }
}
