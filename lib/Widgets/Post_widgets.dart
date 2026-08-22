import 'package:flutter/material.dart';
import 'package:frontend/Home_Screens/Comments_Screen.dart';
import 'package:frontend/Home_Screens/Detailed_Screens.dart';
import 'package:frontend/data/ing.dart';

class RecipeCard extends StatefulWidget {
  final String recipeId;

  final String username;
  final String userHandle;
  final String timeAgo;

  final String recipeImageUrl;
  final String name;
  final String category;
  final String caption;

  final int estimatedTime;
  final String difficulty;

  final List<Ingredient> ingredients;
  final List<String> instructions;

  final double Calories;
  final double fats;
  final double carbs;
  final double protein;

  final int likesCount;
  final int commentsCount;

  const RecipeCard({
    Key? key,
    required this.recipeId,

    required this.username,
    required this.userHandle,
    required this.timeAgo,

    required this.recipeImageUrl,
    required this.name,
    required this.category,
    required this.caption,

    required this.estimatedTime,
    required this.difficulty,

    required this.ingredients,
    required this.instructions,

    required this.Calories,
    required this.fats,
    required this.carbs,
    required this.protein,

    required this.likesCount,
    required this.commentsCount,
  }) : super(key: key);

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool isLiked = false;
  bool isSaved = false;

  int currentLikes = 0;

  @override
  void initState() {
    super.initState();
    currentLikes = widget.likesCount;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(
              receipt_id: widget.recipeId,
             

            ),
          ),
        );
      },

      child: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================
            // User Information
            // =========================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),

              child: Row(
                children: [

                  const Icon(
                    Icons.person_2_outlined,
                    color: Color(0xFFF97316),
                  ),

                  const SizedBox(width: 12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        widget.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        widget.timeAgo,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  IconButton(
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.black54,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // =========================
            // Recipe Name
            // =========================

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // =========================
            // Recipe Image
            // =========================

            Hero(
              tag: 'recipe_${widget.recipeId}',

              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),

                child: Image.network(
                  widget.recipeImageUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // =========================
            // Category
            // =========================

            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 14,
              ),

              child: Text(
                widget.category,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // =========================
            // Caption
            // =========================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                0,
              ),

              child: Text(
                widget.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // =========================
            // Estimated Time
            // =========================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Row(
                children: [

                  const Icon(
                    Icons.access_time_outlined,
                    size: 18,
                    color: Color(0xFFF97316),
                  ),

                  const SizedBox(width: 6),

                  Text(
                    '${widget.estimatedTime} min',

                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),


            const SizedBox(height: 8),


            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),

              child: Row(
                children: [

                  // Like
                  IconButton(
                    icon: Icon(
                      isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,

                      color: isLiked
                          ? Colors.red
                          : Colors.grey,
                    ),

                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;

                        if (isLiked) {
                          currentLikes++;
                        } else {
                          currentLikes--;
                        }
                      });
                    },
                  ),

                  Text(
                    '$currentLikes',

                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(width: 20),

                  // Comments
                  IconButton(
                    icon: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.grey,
                    ),

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CommentsScreen(
                                recipeId: widget.recipeId,
                              ),
                        ),
                      );
                    },
                  ),

                  Text(
                    '${widget.commentsCount}',

                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),

                  const Spacer(),

                  // Save
                  IconButton(
                    icon: Icon(
                      isSaved
                          ? Icons.bookmark
                          : Icons.bookmark_border,

                      color: isSaved
                          ? Colors.amber
                          : Colors.grey,
                    ),

                    onPressed: () {
                      setState(() {
                        isSaved = !isSaved;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// Nutrition Divider
// =====================================================

class NutritionDivider extends StatelessWidget {
  const NutritionDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30,
      color: Colors.grey.shade300,
    );
  }
}