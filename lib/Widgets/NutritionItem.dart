import 'package:flutter/material.dart';

class NutritionItem extends StatelessWidget {
  final String title;
  final String value;

  const NutritionItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [

          Text(
            value,

            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF97316),
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,

            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}