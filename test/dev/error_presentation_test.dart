import 'dart:ui';

import 'package:datarunmobile/commons/errors_management/d_error_localization.dart';
import 'package:datarunmobile/core/exception/d_error_code.dart';
import 'package:datarunmobile/core/exception/d_exception.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/exception/server_failure.dart';
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

  test('current nested server failure shape retains code and fallback detail',
      () {
    final failure = ServerFailure.fromResponseData(const {
      'error': {
        'error_code': 'E4112',
        'message': 'Submission abc form and formVersionId must be present',
      },
    });

    expect(failure.code, 'E4112');
    expect(
      failure.detail,
      'Submission abc form and formVersionId must be present',
    );
    expect(failure.arguments, isEmpty);
  });

  test('future structured server failure retains arguments and trace id', () {
    final failure = ServerFailure.fromResponseData(const {
      'status': 400,
      'code': 'E4114',
      'args': ['team-1', 'submission-1'],
      'detail': 'fallback English',
      'traceId': 'trace-123',
    });

    expect(failure.code, 'E4114');
    expect(failure.arguments, ['team-1', 'submission-1']);
    expect(failure.detail, 'fallback English');
    expect(failure.traceId, 'trace-123');
  });

  test('known submission codes use mobile localization over server text', () {
    final request = RequestOptions(path: '/api/v1/dataSubmission/bulk');
    final error = NetworkHttpError.error(
      Response<dynamic>(
        requestOptions: request,
        statusCode: 400,
        data: const {
          'error': {
            'error_code': 'E4112',
            'message': 'Submission abc form and formVersionId must be present',
          },
        },
      ),
    );

    expect(error.serverFailure?.code, 'E4112');
    expect(ErrorMessage.getMessage(error), S.current.submissionFormMissing);
    expect(ErrorMessage.getMessage(error), isNot(contains('abc')));
  });

  test('active server domain codes have explicit mobile messages', () {
    final expectedMessages = <String, String>{
      'E3000': S.current.authSessionExpired,
      'E3001': S.current.permissionDenied,
      'E3002': S.current.permissionDenied,
      'E3003': S.current.permissionDenied,
      'E3004': S.current.permissionDenied,
      'E3005': S.current.permissionDenied,
      'E3006': S.current.submissionTeamUnavailable,
      'E4110': S.current.submissionRejected,
      'E4111': S.current.submissionRejected,
      'E4112': S.current.submissionFormMissing,
      'E4113': S.current.submissionTeamMissing,
      'E4114': S.current.submissionTeamAccessDenied,
      'E4115': S.current.submissionFormVersionConflict,
      'E4116': S.current.submissionNotFound,
    };

    for (final entry in expectedMessages.entries) {
      final request = RequestOptions(path: '/api/v1/dataSubmission/bulk');
      final error = NetworkHttpError.error(
        Response<dynamic>(
          requestOptions: request,
          statusCode: 400,
          data: {
            'error': {
              'error_code': entry.key,
              'message': 'server fallback for ${entry.key}',
            },
          },
        ),
      );

      expect(
        ErrorMessage.getMessage(error),
        entry.value,
        reason: '${entry.key} should use its mobile localization',
      );
    }
  });

  test('known access codes use the active Arabic localization', () async {
    await S.load(const Locale('ar'));
    final request = RequestOptions(path: '/api/v1/dataSubmission/bulk');
    final error = NetworkHttpError.error(
      Response<dynamic>(
        requestOptions: request,
        statusCode: 400,
        data: const {
          'error': {
            'error_code': 'E4114',
            'message': 'your user is not part of team-1',
          },
        },
      ),
    );

    expect(
      ErrorMessage.getMessage(error),
      S.current.submissionTeamAccessDenied,
    );
    expect(ErrorMessage.getMessage(error), isNot(contains('team-1')));
  });

  test('plain string and RFC problem details remain compatible', () {
    expect(
      ServerFailure.fromResponseData(' refresh failed ').detail,
      'refresh failed',
    );
    final problem = ServerFailure.fromResponseData(const {
      'type': 'problem',
      'title': 'Bad Request',
      'detail': 'The request has an actionable problem',
      'requestId': 'request-123',
    });

    expect(problem.code, isNull);
    expect(problem.detail, 'The request has an actionable problem');
    expect(problem.traceId, 'request-123');
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
