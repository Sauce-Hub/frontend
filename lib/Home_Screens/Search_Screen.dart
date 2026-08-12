import 'package:flutter/material.dart';
import 'package:frontend/Widgets/Category_Items.dart';
import 'package:frontend/Widgets/Post_widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
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
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    categoryItem(
                      Icons.free_breakfast_outlined,
                      'Breakfast',
                    ),

                    categoryItem(
                      Icons.lunch_dining_outlined,
                      'Lunch',
                    ),

                    categoryItem(
                      Icons.apple_outlined,
                      'Dinner',
                    ),
                  ],
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
                  userImageUrl:
                      'https://i.pinimg.com/736x/6f/da/c0/6fdac023f39bdd0ed31f23c3df078708.jpg',
                  recipeImageUrl:
                      'https://i.pinimg.com/736x/2b/ea/39/2bea3906382038bba9992ea9083180f4.jpg',
                  title: 'Chocolate Cake',
                  category: 'Sweets',
                  likesCount: 35125,
                  commentsCount: 180,
                ),

                const SizedBox(height: 16),

                // Recipe Card 2
                RecipeCard(
                  username: '@nadin',
                  timeAgo: '1h ago',
                  userImageUrl:
                      'https://i.pinimg.com/736x/f4/f8/a6/f4f8a62a70b8d9b2a8c91f1bcd7a74a2.jpg',
                  recipeImageUrl:
                      'https://i.pinimg.com/1200x/d3/48/1b/d3481bd5ea30bd9d5350a15c5aea9cc1.jpg',
                  title: 'Shrimp',
                  category: 'Lunch',
                  likesCount: 15,
                  commentsCount: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}