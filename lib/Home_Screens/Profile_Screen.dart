import 'package:flutter/material.dart';
import 'package:frontend/Home_Screens/Edit_Profile_Screen.dart';
import 'package:frontend/Widgets/Profile_Post.dart';
import 'package:frontend/data/ing.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  List<Map<String, dynamic>> recipes = [
    {
      'recipeId': '1',
      'username': 'NouraChef',
      'timeAgo': '2h ago',
      'userImageUrl':
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
      'recipeImageUrl':
      'https://images.unsplash.com/photo-1473093295043-cdd812d0e601',
      'title': 'Creamy Pasta',
      'category': 'Dinner',
      'ingredients': [
        Ingredient(
          name: 'Pasta',
          quantity: '500',
          unit: 'g',
        ),
        Ingredient(
          name: 'Heavy Cream',
          quantity: '1',
          unit: 'cup',
        ),
        Ingredient(
          name: 'Garlic',
          quantity: '2',
          unit: 'cloves',
        ),
        Ingredient(
          name: 'Parmesan Cheese',
          quantity: '50',
          unit: 'g',
        ),
      ],

      'instructions': [
        'Boil pasta in a large pot of salted water until al dente.',
        'Heat oil in a pan over medium heat.',
        'Sauté minced garlic until fragrant.',
        'Add heavy cream and parmesan cheese.',
        'Add the pasta and mix well.',
      ],

      'likesCount': 120,
      'commentsCount': 18,
    },

    {
      'recipeId': '2',
      'username': 'NouraChef',
      'timeAgo': '1d ago',
      'userImageUrl':
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
      'recipeImageUrl':
      'https://images.unsplash.com/photo-1565958011703-44f9829ba187',
      'title': 'Berry Cheesecake',
      'category': 'Dessert',

      'ingredients': [
        Ingredient(
          name: 'Pasta',
          quantity: '500',
          unit: 'g',
        ),
        Ingredient(
          name: 'Heavy Cream',
          quantity: '1',
          unit: 'cup',
        ),
        Ingredient(
          name: 'Garlic',
          quantity: '2',
          unit: 'cloves',
        ),
        Ingredient(
          name: 'Parmesan Cheese',
          quantity: '50',
          unit: 'g',
        ),
      ],

      'instructions': [
        'Boil pasta in a large pot of salted water until al dente.',
        'Heat oil in a pan over medium heat.',
        'Sauté minced garlic until fragrant.',
        'Add heavy cream and parmesan cheese.',
        'Add the pasta and mix well.',
      ],
      'likesCount': 245,
      'commentsCount': 32,
    },


    {
      'recipeId': '4',
      'username': 'NouraChef',
      'timeAgo': '3d ago',
      'userImageUrl':
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
      'recipeImageUrl':
      'https://images.unsplash.com/photo-1544025162-d76694265947',
      'title': 'Grilled Steak',
      'category': 'Dinner',

      'ingredients': [
        Ingredient(
          name: 'Pasta',
          quantity: '500',
          unit: 'g',
        ),
        Ingredient(
          name: 'Heavy Cream',
          quantity: '1',
          unit: 'cup',
        ),
        Ingredient(
          name: 'Garlic',
          quantity: '2',
          unit: 'cloves',
        ),
        Ingredient(
          name: 'Parmesan Cheese',
          quantity: '50',
          unit: 'g',
        ),
      ],

      'instructions': [
        'Boil pasta in a large pot of salted water until al dente.',
        'Heat oil in a pan over medium heat.',
        'Sauté minced garlic until fragrant.',
        'Add heavy cream and parmesan cheese.',
        'Add the pasta and mix well.',
      ],

      'likesCount': 320,
      'commentsCount': 27,
    },
  ];

  String name = 'Noura Ahmed';
  String username = '@NouraChef';
  String bio = 'Easy recipes & sweet treats 🍰';
  String profileImage =
      'https://images.unsplash.com/photo-1556761175-b413da4baf72';


  bool showingRecipes = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF8),

      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    const SizedBox(height: 25),

                    Container(
                      width: 108,
                      height: 108,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.12),
                            blurRadius: 15,
                          ),
                        ],

                        image: DecorationImage(
                          image: NetworkImage(profileImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF24201F),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF674F47),
                      ),
                    ),
                    const SizedBox(height: 15),

                    Text(
                      bio,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF302A28),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 36,
                      ),
                      color: const Color(0xFFE8E1DE),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                            Text(
                              '24',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Posts',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF674F47),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: const [
                            Text(
                              '1.8K',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Followers',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF674F47),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: const [
                            Text(
                              '320',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Following',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF674F47),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    OutlinedButton(
                      onPressed: () async {
                        final result =
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfileScreen(name: '', username: '', profileImage: '',

                                ),
                          ),
                        );

                        if (result != null) {
                          setState(() {
                            name = result['name'];
                            username = result['username'];
                            profileImage =
                            result['profileImage'];
                          });
                        }
                      },

                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFFFF6238),
                          width: 1.5,
                        ),

                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 12,
                        ),

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(30),
                        ),
                      ),

                      child: const Text(
                        'Edit Profile',

                        style: TextStyle(
                          color: Color(0xFFFF6238),
                          fontSize: 15,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),


                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showingRecipes = true;
                              });
                            },
                            child: Container(
                              padding:
                              const EdgeInsets.only(
                                bottom: 17,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: showingRecipes
                                        ? const Color(
                                        0xFFFF6238)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),

                              child: Text(
                                'My Recipes',
                                textAlign:
                                TextAlign.center,

                                style: TextStyle(
                                  color: showingRecipes ? const Color(0xFFFF6238) : const Color(0xFF5D5754),
                                  fontWeight:
                                  showingRecipes ? FontWeight.w500 : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showingRecipes = false;
                              });
                            },

                            child: Container(
                              padding:
                              const EdgeInsets.only(
                                bottom: 17,
                              ),

                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: !showingRecipes
                                        ? const Color(
                                        0xFFFF6238)
                                        : Colors.transparent,

                                    width: 2,
                                  ),
                                ),
                              ),

                              child: Text(
                                'Favorites',

                                textAlign:
                                TextAlign.center,

                                style: TextStyle(
                                  color: !showingRecipes
                                      ? const Color(
                                      0xFFFF6238)
                                      : const Color(
                                      0xFF5D5754),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),


                    if (showingRecipes)

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),

                        child: GridView.builder(
                          shrinkWrap: true,

                          physics:
                          const NeverScrollableScrollPhysics(),

                          itemCount: recipes.length,

                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 16,
                            childAspectRatio: .78,
                          ),

                          itemBuilder: (context, index) {

                            return ProfilePost(
                              recipeId: recipes[index]['recipeId'],
                              username: recipes[index]['username'],
                              timeAgo: recipes[index]['timeAgo'],
                              recipeImageUrl: recipes[index]['recipeImageUrl'],
                              title: recipes[index]['title'],
                              category: recipes[index]['category'],
                              ingredients: recipes[index]['ingredients'],
                              instructions: recipes[index]['instructions'],
                              likesCount: recipes[index]['likesCount'],
                              commentsCount: recipes[index]['commentsCount'],
                            );
                          },
                        ),
                      ),

                    if (!showingRecipes)
                      const Padding(
                        padding:
                        EdgeInsets.all(40),

                        child: Text(
                          'No favorite recipes yet.',
                          style: TextStyle(
                            color:
                            Color(0xFF674F47),
                          ),
                        ),
                      ),

                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}