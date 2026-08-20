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
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
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
          // 1. قراءة التوكن من Storage
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString(
            'user_token',
          ); 
          // استبدلي user_token بالاسم اللي حفظتي بيه التوكن
          
          print('====================================');
          print('TOKEN FROM STORAGE: $token');
          print('====================================');
          // 2. إرفاق التوكن في הـ Headers لو كان موجود
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          print('REQUEST: ${options.method} ${options.path}');
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
    Map<String, dynamic>? queryParameters,
  }) {
    return _request(
      method: 'GET',
      endPoint: endPoint,
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
