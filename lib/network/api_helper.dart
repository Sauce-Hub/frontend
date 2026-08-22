import 'package:dio/dio.dart';
import 'package:frontend/network/end_points.dart';
import 'package:frontend/network/token_storage.dart';

class ApiHelper {
  static final ApiHelper _instance = ApiHelper._internal();
  factory ApiHelper() => _instance;
  ApiHelper._internal() {
    _setupDio();
  }

  late final Dio dio;

  void _setupDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          // 'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          print(
            'REQUEST: ${options.method} ${options.path}',
          );

          return handler.next(options);
        },

        onResponse: (response, handler) {
          print(
            'RESPONSE: ${response.statusCode} '
                '${response.requestOptions.path}',
          );

          return handler.next(response);
        },




        onError: (DioException e, handler) {
  print('ERROR TYPE: ${e.type}');
  print('STATUS CODE: ${e.response?.statusCode}');
  print('RESPONSE DATA: ${e.response?.data}');
  print('MESSAGE: ${e.message}');
  return handler.next(e);
},
      ),
    );
  }

  // Generic request method to reduce duplication
  Future<Response> _request({
    required String method,
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.request(
        endPoint,
        options: Options(
          method: method,
        ),
        data: data,
        queryParameters: queryParameters,
      );

      return response;

    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      }

      if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Response timeout');
      }

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }

      rethrow;
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
//post
  Future<Response> postRequest({
    required String endPoint,
    dynamic data,
  }) {
    return _request(
      method: 'POST',
      endPoint: endPoint,
      data: data,
    );
  }
//get
  Future<Response> getRequest({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) {
    return _request(
      method: 'GET',
      endPoint: endPoint,
      queryParameters: queryParameters,
    );
  }

//patch
  Future<Response> patchRequest({
    required String endPoint,
    dynamic data,
  }) {
    return _request(
      method: 'PATCH',
      endPoint: endPoint,
      data: data,
    );
  }

  Future<Response> putRequest({
    required String endPoint,
    dynamic data,
  }) {
    return _request(
      method: 'PUT',
      endPoint: endPoint,
      data: data,
    );
  }

//delete
  Future<Response> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _request(
      method: 'DELETE',
      endPoint: endPoint,
      data: data,
      queryParameters: queryParameters,
    );
  }
}