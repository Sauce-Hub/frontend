class Ingredient {
  final String name;
  final String quantity;
  final String unit;

  const Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] ?? json['ingredient'] ?? '',
      quantity: json['quantity']?.toString() ?? '',
      unit: json['unit'] ?? '',
    );
  }
}