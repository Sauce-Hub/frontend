import 'package:flutter/material.dart';
import 'package:frontend/Widgets/Category_Items.dart';
import 'package:frontend/Widgets/Post_widgets.dart';

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
                  username: '@mounir',
                  timeAgo: '1h ago',
                  recipeImageUrl:
                      'https://i.pinimg.com/736x/2b/ea/39/2bea3906382038bba9992ea9083180f4.jpg',
                  name: 'Chocolate Cake',
                  category: 'Sweets',
                  likesCount: 35125,
                  commentsCount: 180,
                  recipeId: '1',
                  ingerdiants: '',
                  instructions: '',
                   caption: '',
                    estimatedTime: 99,
                     fats: 0,
                      carbs: 90,
                       protein: 390,
                        Calories: 970,
                ),

                const SizedBox(height: 16),

                // Recipe Card 2
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
                  ingerdiants: '',
                  instructions: '', 
                  caption: '', 
                  estimatedTime: 80,
                   fats: 9, 
                   carbs: 90,
                    protein: 0,
                     Calories: 970,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}