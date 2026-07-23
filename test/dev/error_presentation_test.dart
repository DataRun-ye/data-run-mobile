import 'dart:ui';

import 'package:datarunmobile/commons/errors_management/d_error_localization.dart';
import 'package:datarunmobile/core/exception/d_error_code.dart';
import 'package:datarunmobile/core/exception/d_exception.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await S.load(const Locale('en'));
  });

  test('connection and timeout failures use readable localized messages', () {
    final request = RequestOptions(path: '/api/v1/config');
    final connection = DioException(
      requestOptions: request,
      type: DioExceptionType.connectionError,
      message: 'SocketException: host lookup failed for api.example.test',
    );
    final timeout = DioException(
      requestOptions: request,
      type: DioExceptionType.receiveTimeout,
      message: 'receiveTimeout after 30000 ms',
    );

    expect(
      ErrorMessage.getMessage(connection),
      S.current.networkConnectionFailed,
    );
    expect(ErrorMessage.getMessage(timeout), S.current.networkTimeout);
    expect(ErrorMessage.getMessage(connection), isNot(contains('/api/v1')));
    expect(
        ErrorMessage.getMessage(connection), isNot(contains('DioException')));
  });

  test('login 401 is presented as invalid credentials', () {
    final request = RequestOptions(path: '/api/v1/authenticate');
    final error = NetworkHttpError.fromDioException(
      DioException(
        requestOptions: request,
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: request,
          statusCode: 401,
          data: const {'detail': 'Bad credentials'},
        ),
      ),
      unauthorizedErrorCode: DRunErrorCode.invalidCredentials,
    );

    expect(error.errorCode, DRunErrorCode.invalidCredentials);
    expect(ErrorMessage.getMessage(error), S.current.authInvalidCredentials);
  });

  test('server failures do not expose internal server details', () {
    final request = RequestOptions(path: '/api/v1/dataSubmission');
    final error = NetworkHttpError.error(
      Response<dynamic>(
        requestOptions: request,
        statusCode: 500,
        data: const {
          'detail': 'NullPointerException at DataSubmissionService.java:214',
        },
      ),
    );

    expect(error.errorCode, DRunErrorCode.serverError);
    expect(ErrorMessage.getMessage(error), S.current.generalErrorTitle);
    expect(
      ErrorMessage.getMessage(error),
      isNot(contains('NullPointerException')),
    );
  });

  test('actionable structured validation details remain readable', () {
    final request = RequestOptions(path: '/api/v1/dataSubmission');
    final error = NetworkHttpError.error(
      Response<dynamic>(
        requestOptions: request,
        statusCode: 400,
        data: const {
          'error': {
            'error_code': 'SUBMISSION_INVALID',
            'message': 'The submission contains invalid values',
          },
        },
      ),
    );

    expect(error.errorCode, DRunErrorCode.badRequest);
    expect(error.serverMessage, 'The submission contains invalid values');
    expect(
      ErrorMessage.getMessage(error),
      'The submission contains invalid values',
    );
  });

  test('canceled requests are explicitly non-reportable', () {
    final error = NetworkHttpError.fromDioException(
      DioException(
        requestOptions: RequestOptions(path: '/api/v1/config'),
        type: DioExceptionType.cancel,
      ),
    );

    expect(error.shouldShowMessage, isFalse);
  });

  test('network failures use the active Arabic localization', () async {
    await S.load(const Locale('ar'));
    final error = DioException(
      requestOptions: RequestOptions(path: '/api/v1/config'),
      type: DioExceptionType.connectionError,
      message: 'SocketException: Network unreachable',
    );

    expect(ErrorMessage.getMessage(error), S.current.networkConnectionFailed);
    expect(ErrorMessage.getMessage(error), isNot(contains('SocketException')));
  });

  test('short string causes do not break exception formatting', () {
    expect(
      const DException('Request failed', 'short').toString(),
      "Request failed(source: 'short')",
    );
  });
}
