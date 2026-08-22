import 'package:dio/dio.dart';
import 'package:frontend/Home_Screens/Detailed_Screens.dart';
import 'package:frontend/data/profile_model.dart';
import 'package:frontend/data/recipe_details_model.dart';
import 'package:frontend/network/api_helper.dart';
import 'package:frontend/network/end_points.dart';
import 'package:frontend/data/recipe_details_model.dart';

class ProfileService {
  final ApiHelper _apiHelper = ApiHelper();

  Future<ProfileModel> getMyProfile() async {
    try {
      final Response response = await _apiHelper.getRequest(
        endPoint: EndPoints.profile,
      );

      return ProfileModel.fromJson(response.data);
    } on DioException {
      rethrow;
    }
  }

  Future<RecipeDetails> getRecipeDetails(int receiptId) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.receiptDetails,
        queryParameters: {
          'receipt_id': receiptId,
        },
      );

      return RecipeDetails.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        'Failed to load recipe details: ${e.response?.statusCode}',
      );
    }
  }
}
