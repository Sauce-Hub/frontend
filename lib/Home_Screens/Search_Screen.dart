import 'package:flutter/material.dart';
import 'package:frontend/Widgets/Category_Items.dart';
import 'package:frontend/Widgets/Post_widgets.dart';

import '../data/ing.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  // The currently selected category
  String selectedCategory = 'Sweets';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search",
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Icon(
                      Icons.menu,
                      size: 40,
                      color: Color(0xFFF97316),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Categories
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Categories List
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [

                      CategoryItem(
                        icon: Icons.bakery_dining,
                        label: 'Breakfast',
                        isSelected: selectedCategory == 'Breakfast',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Breakfast';
                          });
                        },
                      ),

                      const SizedBox(width: 5),

                      CategoryItem(
                        icon: Icons.lunch_dining,
                        label: 'Lunch',
                        isSelected: selectedCategory == 'Lunch',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Lunch';
                          });
                        },
                      ),

                      const SizedBox(width: 5),

                      CategoryItem(
                        icon: Icons.dinner_dining,
                        label: 'Dinner',
                        isSelected: selectedCategory == 'Dinner',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Dinner';
                          });
                        },
                      ),

                      const SizedBox(width: 5),

                      CategoryItem(
                        icon: Icons.cake,
                        label: 'Sweets',
                        isSelected: selectedCategory == 'Sweets',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Sweets';
                          });
                        },
                      ),

                      const SizedBox(width: 5),

                      CategoryItem(
                        icon: Icons.coffee,
                        label: 'Hot Drinks',
                        isSelected: selectedCategory == 'Hot Drinks',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Hot Drinks';
                          });
                        },
                      ),

                      const SizedBox(width: 5),

                      CategoryItem(
                        icon: Icons.local_drink,
                        label: 'Iced Drinks',
                        isSelected: selectedCategory == 'Iced Drinks',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Iced Drinks';
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Recommended
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recommended",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Recipe Card 1
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

                const SizedBox(height: 16),

                // Recipe Card 2
                RecipeCard(
                  username: '@mounir',
                  timeAgo: '1h ago',

                  recipeImageUrl:
                  'https://i.pinimg.com/736x/2b/ea/39/2bea3906382038bba9992ea9083180f4.jpg',

                  name: 'Chocolate Cake',
                  category: 'Sweets',

                  likesCount: 35125,
                  commentsCount: 180,

                  recipeId: '1',

                  ingredients: [
                    Ingredient(
                      name: 'Flour',
                      quantity: '2',
                      unit: 'cups',
                    ),

                    Ingredient(
                      name: 'Sugar',
                      quantity: '1',
                      unit: 'cup',
                    ),

                    Ingredient(
                      name: 'Cocoa Powder',
                      quantity: '1/2',
                      unit: 'cup',
                    ),

                    Ingredient(
                      name: 'Eggs',
                      quantity: '2',
                      unit: 'pieces',
                    ),
                  ],

                  instructions: [
                    'Mix the flour, cocoa powder, and sugar.',
                    'Add the eggs and mix well.',
                    'Pour the mixture into a baking pan.',
                    'Bake until fully cooked.',
                  ],

                  caption: 'Rich and delicious chocolate cake.',

                  estimatedTime: 40,

                  fats: 20,
                  carbs: 60,
                  protein: 10,
                  Calories: 450,
                  userHandle: 'aaa@email.com',
                  difficulty: 'medium',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}