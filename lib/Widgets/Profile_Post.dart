import 'package:flutter/material.dart';
import 'package:frontend/Home_Screens/Detailed_Screens.dart';

class ProfilePost extends StatelessWidget {
  final String recipeId;
  final String username;
  final String timeAgo;
  final String userImageUrl;
  final String recipeImageUrl;
  final String title;
  final String category;

  final String ingerdiants;
  final String instructions;

  final int likesCount;
  final int commentsCount;

  const ProfilePost({
    super.key,
    required this.recipeId,
    required this.username,
    required this.timeAgo,
    required this.userImageUrl,
    required this.recipeImageUrl,
    required this.title,
    required this.category,
    required this.ingerdiants,
    required this.instructions,
    required this.likesCount,
    required this.commentsCount,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailsScreen(
                recipeId: recipeId,
                username: username,
                timeAgo: timeAgo,
                userImageUrl: userImageUrl,
                recipeImageUrl: recipeImageUrl,
                title: title,
                category: category,
                ingerdiants: ingerdiants,
                instructions: instructions,
                likesCount: likesCount,
                commentsCount: commentsCount,
              ),
            ),
          );
        },

        child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 8,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: 'recipe_$recipeId',

                    child: Image.network(
                      recipeImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,

                  child: Container(
                    width: 34,
                    height: 34,

                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.favorite_border,
                      size: 19,
                      color: Color(0xFF675B57),
                    ),
                  ),
                ),
              ],
            ),
          ),


          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                9,
                8,
                8,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F1F0),
                      borderRadius:
                      BorderRadius.circular(15),
                    ),

                    child: Text(
                      category,

                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF674F47),
                      ),
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF24201F),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
}