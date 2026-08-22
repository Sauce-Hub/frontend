import 'package:dio/dio.dart';
import 'package:frontend/network/api_helper.dart';
import 'package:frontend/network/end_points.dart';

class PostService {
  final ApiHelper _apiHelper = ApiHelper();

  Future<Response> createPost({
    required String name,
    required String caption,
    required String category,
    required List<Map<String, dynamic>> ingredients,
    required List<String> instructions,
    required MultipartFile image,
  }) async {
    final formData = FormData();

    // ==========================================================
    // RECEIPT
    // ==========================================================

    formData.fields.add(
      MapEntry(
        'receipt[name]',
        name,
      ),
    );

    formData.fields.add(
      MapEntry(
        'receipt[caption]',
        caption,
      ),
    );

    formData.fields.add(
      MapEntry(
        'receipt[category]',
        category,
      ),
    );

    // Image belongs to receipt
    formData.files.add(
      MapEntry(
        'receipt[image]',
        image,
      ),
    );

    // ==========================================================
    // INGREDIENTS
    // IMPORTANT:
    // These are NOT inside receipt.
    //
    // Correct:
    // ingredients[0][name]
    //
    // NOT:
    // receipt[ingredients][0][name]
    // ==========================================================

    for (int i = 0; i < ingredients.length; i++) {
      final ingredient = ingredients[i];

      formData.fields.add(
        MapEntry(
          'ingredients[$i][name]',
          ingredient['name'].toString(),
        ),
      );

      formData.fields.add(
        MapEntry(
          'ingredients[$i][quantity]',
          ingredient['quantity'].toString(),
        ),
      );

      formData.fields.add(
        MapEntry(
          'ingredients[$i][unit]',
          ingredient['unit'].toString(),
        ),
      );
    }

    // ==========================================================
    // INSTRUCTIONS
    // IMPORTANT:
    // These are also NOT inside receipt.
    //
    // Correct:
    // instructions[0]
    // instructions[1]
    // instructions[2]
    // ==========================================================

    for (int i = 0; i < instructions.length; i++) {
      formData.fields.add(
        MapEntry(
          'instructions[$i]',
          instructions[i],
        ),
      );
    }

    // ==========================================================
    // DEBUG
    // ==========================================================

    print('========== CREATE POST ==========');

    print('FIELDS:');

    for (final field in formData.fields) {
      print('${field.key} = ${field.value}');
    }

    print('FILES:');

    for (final file in formData.files) {
      print('${file.key} = ${file.value.filename}');
    }

    print('=================================');

    // ==========================================================
    // SEND
    // ==========================================================

    return await _apiHelper.postRequest(
      endPoint: EndPoints.newPost,
      data: formData,
    );
  }
}