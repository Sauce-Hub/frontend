import 'package:dio/dio.dart';
import 'package:frontend/network/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart'; // تأكدي من استيراد الشيرد بريفرنسز

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
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 90),
        sendTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
  final prefs = await SharedPreferences.getInstance();

  final token = prefs.getString('user_token');

  print('====================================');
  print('TOKEN EXISTS: ${token != null && token.isNotEmpty}');
  print('REQUEST METHOD: ${options.method}');
  print('REQUEST URL: ${options.uri}');
  print('REQUEST HEADERS BEFORE TOKEN: ${options.headers}');
  print('REQUEST DATA: ${options.data}');

  if (token != null && token.isNotEmpty) {
    options.headers['Authorization'] = 'Bearer $token';
  }

  print('REQUEST HEADERS AFTER TOKEN: ${options.headers}');
  print('====================================');

  return handler.next(options);
},
        onResponse: (response, handler) {
          print(
            'RESPONSE: ${response.statusCode} ${response.requestOptions.path}',
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

  // باقي الكود كما هو بدون تغيير...
  Future<Response> _request({
    required String method,
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.request(
        endPoint,
        options: Options(method: method),
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Response timeout');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }
      rethrow;
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Response> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = false,
  }) {
    return _request(
      method: 'POST',
      endPoint: endPoint,
      data: data,
      isFormData: isFormData,
    );
  }

  Future<Response> getRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _request(
      method: 'GET',
      endPoint: endPoint,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response> patchRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = false,
  }) {
    return _request(
      method: 'PATCH',
      endPoint: endPoint,
      data: data,
      isFormData: isFormData,
    );
  }

  Future<Response> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = false,
  }) {
    return _request(
      method: 'PUT',
      endPoint: endPoint,
      data: data,
      isFormData: isFormData,
    );
  }

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
