import 'ing.dart';

class RecipeDetails {
  final int receiptId;
  final String name;
  final String caption;
  final String category;
  final String imageUrl;
  final int estimatedTime;
  final int calories;
  final int fats;
  final int carbs;
  final int protein;
  final String timestamp;

  final int userId;
  final String username;
  final String userHandle;

  final List<Ingredient> ingredients;
  final List<String> instructions;

  final int likesCount;
  final int commentsCount;

  const RecipeDetails({
    required this.receiptId,
    required this.name,
    required this.caption,
    required this.category,
    required this.imageUrl,
    required this.estimatedTime,
    required this.calories,
    required this.fats,
    required this.carbs,
    required this.protein,
    required this.timestamp,
    required this.userId,
    required this.username,
    required this.userHandle,
    required this.ingredients,
    required this.instructions,
    required this.likesCount,
    required this.commentsCount,
  });

  String get authorImageUrl => '';

  factory RecipeDetails.fromJson(Map<String, dynamic> json) {

    final recipeJson =
        (json['receipt'] as Map<String, dynamic>?) ?? json;

    final authorJson =
        (json['user'] as Map<String, dynamic>?) ??
            (json['author'] as Map<String, dynamic>?) ??
            <String, dynamic>{};

    final ingredientsJson =
        json['ingredients'] as List<dynamic>? ?? [];

    final instructionsJson =
        json['instructions'] as List<dynamic>? ?? [];

    return RecipeDetails(
      receiptId: recipeJson['receipt_id'] ?? 0,
      name: recipeJson['name'] ?? '',
      caption: recipeJson['caption'] ?? '',
      category: recipeJson['category'] ?? '',
      imageUrl: recipeJson['image_url'] ?? '',
      estimatedTime: recipeJson['estimated_time'] ?? 0,
      calories: recipeJson['Calories'] ?? 0,
      fats: recipeJson['Fats'] ?? 0,
      carbs: recipeJson['Carbs'] ?? 0,
      protein: recipeJson['Protein'] ?? 0,
      timestamp: recipeJson['timestamp'] ?? '',

      userId: recipeJson['user_id'] ?? 0,
      username: authorJson['name'] ?? '',
      userHandle: authorJson['email'] ?? '',

      ingredients: ingredientsJson.map((item) {
        final ingredientMap = item as Map<String, dynamic>;

        return Ingredient(
          name: ingredientMap['name']?.toString() ?? '',
          quantity: ingredientMap['quantity']?.toString() ?? '',
          unit: ingredientMap['unit']?.toString() ?? '',
        );
      }).toList(),

      // Each instruction entry is expected to be either a plain
      // string, or an object like { "instruction": "..." } —
      // matching what SuggestionService already sends. Handle
      // both shapes defensively.
      instructions: instructionsJson.map((item) {
        if (item is String) return item;

        if (item is Map<String, dynamic>) {
          return item['instruction']?.toString() ?? '';
        }

        return item.toString();
      }).toList(),

      likesCount: json['likes_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
    );
  }
}