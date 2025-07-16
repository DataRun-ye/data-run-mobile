import 'dart:io';

import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/http/http_client.dart';
import 'package:d_sdk/di/app_environment.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HttpClient)
class DefaultHttpAdapter extends HttpClient<dynamic> {
  DefaultHttpAdapter(this.dioClient);

  final Dio dioClient;

  String get apiVersionPath => '/${AppEnvironment.apiV1Path}';

  @override
  Future<Response<dynamic>> request(
      {required String resourceName,
      required String method,
      Object? data,
      Map<String, dynamic>? headers}) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({HttpHeaders.contentTypeHeader: 'application/json'});

    final resourcePath = '${this.apiVersionPath}/$resourceName';

    Response<dynamic> response = noResponse(
        url: resourcePath, method: method, data: data, headers: defaultHeaders);
    Future<Response<dynamic>>? futureResponse;
    try {
      if (method == 'post') {
        // dioClient.options.copyWith(
        //     // headers: defaultHeaders,
        //     receiveTimeout: const Duration(milliseconds: 100000));

        futureResponse = dioClient.post(resourcePath,
            data: data,
            options: Options(
                sendTimeout: dioClient.options.sendTimeout,
                receiveTimeout: const Duration(milliseconds: 100000),
                headers: defaultHeaders));
      } else if (method == 'get') {
        futureResponse = dioClient.get(resourcePath,
            options: Options(headers: defaultHeaders));
      } else if (method == 'put') {
        futureResponse = data == null
            ? dioClient.put(resourcePath)
            : dioClient.put(resourcePath,
                data: data, options: Options(headers: defaultHeaders));
      }

      if (futureResponse != null) {
        response = await futureResponse.timeout(const Duration(seconds: 1000));
      }
    } on DioException catch (error) {
      throw NetworkHttpError.fromDioException(error,
          stackTrace: StackTrace.current);
    }
    return _handleResponse(response);
  }

  Response<dynamic> _handleResponse(Response<dynamic> response) {
    return switch (response.statusCode) {
      == 200 => response,
      _ =>
        throw NetworkHttpError.error(response, stackTrace: StackTrace.current),
    };
  }

  Response<dynamic> noResponse(
      {required String url,
      required String method,
      Object? data,
      Map<String, dynamic>? headers}) {
    RequestOptions requestOptions = RequestOptions(
      method: method,
      baseUrl: '${dioClient.options.baseUrl}${url}',
      data: data,
      headers: headers,
    );

    return Response(data: '', statusCode: 500, requestOptions: requestOptions);
  }
}
