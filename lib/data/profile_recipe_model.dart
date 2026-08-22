import 'package:frontend/network/image_helper.dart';

class ProfileRecipe {
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

  ProfileRecipe({
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
  });

  factory ProfileRecipe.fromJson(Map<String, dynamic> json) {
    return ProfileRecipe(
      receiptId: json['receipt_id'] ?? 0,
      name: json['name'] ?? '',
      caption: json['caption'] ?? '',
      category: json['category'] ?? '',
      imageUrl: buildImageUrl(json['image_url']?.toString()),
      estimatedTime: json['estimated_time'] ?? 0,
      calories: json['Calories'] ?? 0,
      fats: json['Fats'] ?? 0,
      carbs: json['Carbs'] ?? 0,
      protein: json['Protein'] ?? 0,
      timestamp: json['timestamp'] ?? '',
    );
  }
}