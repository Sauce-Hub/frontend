import 'package:frontend/data/ing.dart';

class RecipeModel {
  final String recipeId;
  final String username;
  final String userHandle;
  final String timeAgo;
  final String recipeImageUrl;
  final String name;
  final String category;
  final String caption;
  final int estimatedTime;
  final String difficulty;
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final double calories;
  final double fats;
  final double carbs;
  final double protein;
  final int likesCount;
  final int commentsCount;

  RecipeModel({
    required this.recipeId,
    required this.username,
    required this.userHandle,
    required this.timeAgo,
    required this.recipeImageUrl,
    required this.name,
    required this.category,
    required this.caption,
    required this.estimatedTime,
    required this.difficulty,
    required this.ingredients,
    required this.instructions,
    required this.calories,
    required this.fats,
    required this.carbs,
    required this.protein,
    required this.likesCount,
    required this.commentsCount,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      recipeId: (json['receipt_id'] ?? json['_id'] ?? '').toString(),
      username: json['username'] ?? '',
      userHandle: json['userHandle'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      recipeImageUrl: json['image_url'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      caption: json['caption'] ?? '',
      estimatedTime: json['estimatedTime'] ?? 0,
      difficulty: json['difficulty'] ?? '',
      ingredients: (json['ingredients'] as List?)
              ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      instructions: (json['instructions'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      calories: (json['Calories'] ?? json['calories'] ?? 0).toDouble(),
      fats: (json['fats'] ?? 0).toDouble(),
      carbs: (json['carbs'] ?? 0).toDouble(),
      protein: (json['protein'] ?? 0).toDouble(),
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
    );
  }
}

class ReceiptUser {
  final int userId;
  final String name;

  ReceiptUser({required this.userId, required this.name});

  factory ReceiptUser.fromJson(Map<String, dynamic> json) {
    return ReceiptUser(
      userId: json['user_id'],
      name: json['name'],
    );
  }
}


