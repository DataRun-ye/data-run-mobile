import 'package:dio/dio.dart';

import 'network_request.dart';
import 'network_request_body.dart';
import 'network_response.dart';

abstract class HttpClient<T> {
  /// default http adapter instance name for unauthorized/public http requests
  static const String defaultHttpAdapterInstanceName = 'defaultHttpAdapter';

  Future<Response<T>> request({
    required String resourceName,
    required String method,
    Object? data,
    Map<String, dynamic>? headers,
  });

  /// Generic type and parser are used to properly deserialize JSON.
  Future<NetworkResponse<Model>> networkRequest<Model>(
      _PreparedNetworkRequest<Model> request) async {
    try {
      final dynamic body = switch (request.request.data) {
        Json(data: final data) => data,
        Text(data: final data) => data,
        _ => null,
      };

      final response = await request.dio.request(
        request.request.path,
        data: body,
        queryParameters: request.request.queryParams,
        options: Options(
          method: request.request.type.name,
          headers: request.headers,
        ),
        onSendProgress: request.onSendProgress,
        onReceiveProgress: request.onReceiveProgress,
      );
      return NetworkResponse.ok(request.parser(response.data));
    } on DioException catch (error) {
      final errorText = error.toString();
      if (error.requestOptions.cancelToken!.isCancelled) {
        return NetworkResponse.noData(errorText);
      }
      switch (error.response?.statusCode) {
        case 400:
          return NetworkResponse.badRequest(errorText);
        case 401:
          return NetworkResponse.noAuth(errorText);
        case 403:
          return NetworkResponse.noAccess(errorText);
        case 404:
          return NetworkResponse.notFound(errorText);
        case 409:
          return NetworkResponse.conflict(errorText);
        default:
          return NetworkResponse.noData(errorText);
      }
    } catch (error) {
      return NetworkResponse.noData(error.toString());
    }
  }
}

class _PreparedNetworkRequest<Model> {
  const _PreparedNetworkRequest(
    this.request,
    this.parser,
    this.dio,
    this.headers,
    this.onSendProgress,
    this.onReceiveProgress,
  );

  final NetworkRequest request;
  final Model Function(Map<String, dynamic>) parser;
  final Dio dio;
  final Map<String, dynamic> headers;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;
}
