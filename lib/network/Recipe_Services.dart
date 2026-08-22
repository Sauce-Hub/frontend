// Recipe_Services.dart
import 'package:dio/dio.dart';
import 'package:frontend/network/Recipe_Model.dart';
import 'package:frontend/network/api_helper.dart';
import 'package:frontend/network/end_points.dart';

class RecipeService {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<RecipeModel>> getFypRecipes() async {
    try {
      final Response response = await _apiHelper.getRequest(
        endPoint: EndPoints.fyp,
      );

      if (response.data != null && response.data['data'] != null) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => RecipeModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
Future<RecipeModel> getRecipeDetail(String recipeId) async {
  try {
    final Response response = await _apiHelper.getRequest(
      endPoint: EndPoints.detailed,
      data: {
        "receipt_id": int.parse(recipeId),
      },
    );

    if (response.data != null && response.data['receipt'] != null) {
      return RecipeModel.fromJson(response.data['receipt']);
    } else {
      throw Exception('Recipe not found');
    }
  } catch (e) {
    rethrow;
  }
}
}