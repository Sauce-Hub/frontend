import 'package:dio/dio.dart';
import 'package:frontend/network/api_helper.dart';
import 'package:frontend/network/end_points.dart';

class SuggestionService {
  final ApiHelper _apiHelper = ApiHelper();

  // CREATE SUGGESTION
  Future<Map<String, dynamic>> createSuggestion({
    required int recipeId,
    required String text,
    required List<Map<String, dynamic>> ingredients,
    required List<Map<String, dynamic>> instructions,
  }) async {
    try {
      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.createSuggestion,
        data: {
          'receipt_id': recipeId,
          'text': text,
          'ingredients': ingredients,
          'instructions': instructions,
        },
      );

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to create suggestion',
      );
    }
  }

  // GET SUGGESTIONS
  Future<List<dynamic>> getSuggestions({
    required int recipeId,
  }) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.suggestions,
      );

      final List<dynamic> suggestions =
          response.data['data'] ?? [];

      // Only return suggestions belonging to this recipe.
      return suggestions
          .where(
            (suggestion) =>
        suggestion['receipt_id'].toString() ==
            recipeId.toString(),
      )
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to load suggestions',
      );
    }
  }

  // APPROVE SUGGESTION
  Future<Map<String, dynamic>> approveSuggestion({
    required int suggestionId,
  }) async {
    try {
      final response = await _apiHelper.patchRequest(
        endPoint: EndPoints.approveSuggestion,
        data: {
          'suggestion_id': suggestionId,
        },
      );

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to approve suggestion',
      );
    }
  }
}