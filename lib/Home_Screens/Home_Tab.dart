import 'package:flutter/material.dart';
import 'package:frontend/Widgets/Post_widgets.dart';
import 'package:frontend/data/ing.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      leading: Icon(Icons.food_bank, color: Color(0xFFF97316),),
      backgroundColor: Color.fromARGB(255, 252, 238, 228),
      centerTitle: true,
      title: Text("Sauce hub", selectionColor: Color(0xFFF97316),),
    ),

    body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            RecipeCard(
              username: '@nadin',
              timeAgo: '13h ago',

              recipeImageUrl:
              'https://i.pinimg.com/1200x/d3/48/1b/d3481bd5ea30bd9d5350a15c5aea9cc1.jpg',

              name: 'Shrimp',
              category: 'Lunch',

              likesCount: 15,
              commentsCount: 1,

              recipeId: '2',

              ingredients: [
                Ingredient(
                  name: 'Shrimp',
                  quantity: '500',
                  unit: 'g',
                ),

                Ingredient(
                  name: 'Garlic',
                  quantity: '3',
                  unit: 'cloves',
                ),

                Ingredient(
                  name: 'Butter',
                  quantity: '2',
                  unit: 'tbsp',
                ),
              ],

              instructions: [
                'Clean and prepare the shrimp.',
                'Heat the butter in a pan.',
                'Add garlic and cook briefly.',
                'Add the shrimp and cook until done.',
              ],

              caption: 'Easy garlic shrimp.',

              estimatedTime: 25,

              fats: 9,
              carbs: 10,
              protein: 30,
              Calories: 250,
              userHandle: 'aaa@email.com',
              difficulty: 'medium',
            ),
            const SizedBox(height: 16),

            RecipeCard(
              username: '@hana',
              timeAgo: '4h ago',

              recipeImageUrl:
              'https://i.pinimg.com/1200x/6e/1e/06/6e1e0663df4ce9b20244dddf2a8233ff.jpg',

              name: 'Creamy Pasta',
              category: 'Lunch',

              likesCount: 155,
              commentsCount: 3,

              recipeId: '4',

              ingredients: [
                Ingredient(
                  name: 'Pasta',
                  quantity: '200',
                  unit: 'g',
                ),

                Ingredient(
                  name: 'Heavy Cream',
                  quantity: '1',
                  unit: 'cup',
                ),

                Ingredient(
                  name: 'Parmesan Cheese',
                  quantity: '1/2',
                  unit: 'cup',
                ),

                Ingredient(
                  name: 'Garlic',
                  quantity: '2',
                  unit: 'cloves',
                ),
              ],

              instructions: [
                'Boil the pasta until al dente.',
                'Heat the heavy cream in a pan.',
                'Add garlic and cook for 1–2 minutes.',
                'Add Parmesan cheese and stir until creamy.',
                'Add the cooked pasta and combine everything.',
              ],

              caption: 'Delicious creamy pasta!',

              estimatedTime: 30,

              fats: 90,
              carbs: 70,
              protein: 30,
              Calories: 707,
              userHandle: 'aaa@email.com',
              difficulty: 'medium',
            ),

            
          ]

        )
    )
    );
  }
}
