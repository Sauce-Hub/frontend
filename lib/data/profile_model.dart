import 'profile_recipe_model.dart';

class ProfileModel {
  final int userId;
  final String name;
  final String email;
  final List<ProfileRecipe> recipes;

  ProfileModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.recipes,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      recipes: (json['receipts'] as List<dynamic>? ?? [])
          .map(
            (recipe) => ProfileRecipe.fromJson(
          recipe as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }
}