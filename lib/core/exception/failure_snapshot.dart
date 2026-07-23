import 'dart:convert';

import 'package:datarunmobile/core/exception/d_error.dart';
import 'package:datarunmobile/core/exception/d_error_code.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/exception/server_failure.dart';
import 'package:dio/dio.dart';

final class FailureSnapshot {
  const FailureSnapshot({
    required this.errorCode,
    this.httpStatus,
    this.serverFailure,
  });

  factory FailureSnapshot.fromError(Object error) {
    if (error is RevokeTokenException) {
      return const FailureSnapshot(
        errorCode: DRunErrorCode.sessionExpired,
      );
    }
    if (error is DioException) {
      return FailureSnapshot.fromError(
        NetworkHttpError.fromDioException(error),
      );
    }
    if (error is NetworkHttpError) {
      return FailureSnapshot(
        errorCode: error.errorCode ?? DRunErrorCode.unexpected,
        httpStatus: error.httpErrorCode,
        serverFailure: error.serverFailure,
      );
    }
    if (error is DError) {
      return FailureSnapshot(
        errorCode: error.errorCode ?? DRunErrorCode.unexpected,
        httpStatus: error.httpErrorCode,
      );
    }
    if (error is FormatException) {
      return const FailureSnapshot(
        errorCode: DRunErrorCode.badResponse,
      );
    }
    return const FailureSnapshot(
      errorCode: DRunErrorCode.unexpected,
    );
  }

  factory FailureSnapshot.fromServerResponse(
    Object? data, {
    DRunErrorCode errorCode = DRunErrorCode.invalidData,
  }) {
    final serverFailure = ServerFailure.fromResponseData(data);
    return FailureSnapshot(
      errorCode: errorCode,
      serverFailure: serverFailure.isEmpty ? null : serverFailure,
    );
  }

  factory FailureSnapshot.badResponse() => const FailureSnapshot(
        errorCode: DRunErrorCode.badResponse,
      );

  static const storageVersion = 1;

  final DRunErrorCode errorCode;
  final int? httpStatus;
  final ServerFailure? serverFailure;

  String encode() => jsonEncode({
        'v': storageVersion,
        'errorCode': errorCode.name,
        if (httpStatus != null) 'httpStatus': httpStatus,
        if (serverFailure != null && !serverFailure!.isEmpty)
          'serverFailure': serverFailure!.toJson(),
      });

  static FailureSnapshot? tryDecode(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    try {
      final decoded = jsonDecode(value);
      if (decoded is! Map || decoded['v'] != storageVersion) return null;

      final errorCodeName = decoded['errorCode'];
      if (errorCodeName is! String) return null;
      final errorCode = _errorCodeByName(errorCodeName);
      if (errorCode == null) return null;

      final status = decoded['httpStatus'];
      final serverData = decoded['serverFailure'];
      final serverFailure = serverData == null
          ? null
          : ServerFailure.fromResponseData(serverData);

      return FailureSnapshot(
        errorCode: errorCode,
        httpStatus: status is int ? status : null,
        serverFailure: serverFailure == null || serverFailure.isEmpty
            ? null
            : serverFailure,
      );
    } on FormatException {
      return null;
    } on TypeError {
      return null;
    }
  }

  static DRunErrorCode? _errorCodeByName(String name) {
    for (final errorCode in DRunErrorCode.values) {
      if (errorCode.name == name) return errorCode;
    }
    return null;
  }
}
