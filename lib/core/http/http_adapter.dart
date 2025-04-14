import 'dart:io';

import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/http/http_client.dart';
import 'package:d_sdk/core/http/http_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

/// dio initialization
/// ```dart
///  Dio(BaseOptions(
///   baseUrl: 'https://api.nmcpye.org'
///   connectTimeout: Duration(milliseconds: 100000),
///   receiveTimeout: Duration(milliseconds: 100000),
///   headers: {
///     HttpHeaders.authorizationHeader:
///         '${httpDetails.authTokenType} ${httpDetails.authToken}',
///     HttpHeaders.contentTypeHeader: 'application/json'
///   }));
/// ```
@Named('httpAdapter')
@LazySingleton(as: HttpClient)
class HttpAdapter extends HttpClient {
  final Dio dioClient;

  HttpAdapter(this.dioClient);

  Future<HttpResponse> request(
      {
      // pass on dio init config
      // required String url,
      required String resourceName,
      required String method,
      Object? data,
      Map? headers}) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({HttpHeaders.contentTypeHeader: 'application/json'});

    final resourcePath = '/$resourceName';
    Response response = noResponse(
        url: resourcePath, method: method, data: data, headers: defaultHeaders);
    Future<Response>? futureResponse;
    try {
      if (method == 'post') {
        dioClient.options.copyWith(
            headers: defaultHeaders,
            receiveTimeout: Duration(milliseconds: 100000));

        futureResponse = dioClient.post(resourcePath,
            data: data,
            options: Options(
                sendTimeout: dioClient.options.sendTimeout,
                receiveTimeout: Duration(milliseconds: 100000),
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
        response = await futureResponse.timeout(Duration(seconds: 1000));
      }
    } on DioError catch (error) {
      throw NetworkHttpError.fromDioError(error,
          stackTrace: StackTrace.current);
    }
    return _handleResponse(response);
  }

  HttpResponse _handleResponse(Response response) {
    return switch (response.statusCode) {
      == 200 => HttpResponse(response: response),
      _ =>
        throw NetworkHttpError.error(response, stackTrace: StackTrace.current),
    };
  }

  Response noResponse(
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
