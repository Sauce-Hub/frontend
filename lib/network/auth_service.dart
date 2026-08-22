import 'package:dio/dio.dart';
import 'package:frontend/network/api_helper.dart';
import 'package:frontend/network/end_points.dart';
import 'package:frontend/network/token_storage.dart';

class AuthService {
  final ApiHelper _apiHelper = ApiHelper();

  // Login - Returns Response
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      final token = response.data['token'];

      if (token != null) {
        await TokenStorage.saveToken(token);
      }

      return response;
    } on DioException {
      rethrow;
    }
  }

  // Register - Returns Response
  Future<Response> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      final token = response.data['token'];

      if (token != null) {
        await TokenStorage.saveToken(token);
      }

      return response;
    } on DioException {
      rethrow;
    }
  }
}