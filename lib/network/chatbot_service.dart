import 'package:dio/dio.dart';
import 'package:frontend/network/api_helper.dart';
import 'package:frontend/network/end_points.dart';

class ChatService {
  final ApiHelper _apiHelper = ApiHelper();

  Future<Response> exploreChatResponse({
  required int userId,
  required String userPrompt,
}) async {
  try {
    final response = await _apiHelper.getRequest(
      endPoint: EndPoints.chatbot,
      data: {
        'user_id': userId,
        'prompt': userPrompt,
      },
    );

      print('====================================');
      print('CHATBOT STATUS CODE: ${response.statusCode}');
      print('CHATBOT RESPONSE: ${response.data}');
      print('====================================');

      return response;
    } on DioException catch (e) {
      print('====================================');
      print('CHATBOT ERROR STATUS: ${e.response?.statusCode}');
      print('CHATBOT ERROR DATA: ${e.response?.data}');
      print('CHATBOT ERROR MESSAGE: ${e.message}');
      print('====================================');

      rethrow;
    }
  }
}