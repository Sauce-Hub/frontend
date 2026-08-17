import 'package:flutter/material.dart';
import 'package:frontend/Home_Screens/Comments_Screen.dart';
import 'package:frontend/data/ing.dart';
import 'package:frontend/Home_Screens/suggestions.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final String recipeId;

  final String username;
  final String userHandle;

  final String timeAgo;

  final String recipeImageUrl;
  final String title;
  final String category;

  final String cookingTime;
  final String difficulty;

  final List<Ingredient> ingredients;
  final List<String> instructions;

  final int likesCount;
  final int commentsCount;

  const RecipeDetailsScreen({
    super.key,
    required this.recipeId,
    required this.username,
    required this.userHandle,
    required this.timeAgo,
    required this.recipeImageUrl,
    required this.title,
    required this.category,
    required this.cookingTime,
    required this.difficulty,
    required this.ingredients,
    required this.instructions,
    required this.likesCount,
    required this.commentsCount,
  });

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  bool isLiked = false;
  bool isSaved = false;

  late int currentLikes;
  late int currentComments;

  // Used for switching between Ingredients and Steps.
  bool showIngredients = true;

  @override
  void initState() {
    super.initState();

    currentLikes = widget.likesCount;
    currentComments = widget.commentsCount;
  }

  // -------------------------
  // LIKE
  // -------------------------

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;

      if (isLiked) {
        currentLikes++;
      } else {
        currentLikes--;
      }
    });
  }

  // -------------------------
  // SAVE
  // -------------------------

  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  // -------------------------
  // OPEN COMMENTS
  // -------------------------

  Future<void> openComments() async {
    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (context) => CommentsScreen(
          recipeId: widget.recipeId,
        ),
      ),
    );

    // The comments screen returns the current number of comments.
    if (result != null) {
      setState(() {
        currentComments = result;
      });
    }
  }

  // -------------------------
  // SUGGEST IMPROVEMENT
  // -------------------------

  void suggestImprovement() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Suggestion screen will open here'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),

      body: SafeArea(
        child: Column(
          children: [
            // ----------------------------------
            // EVERYTHING ABOVE THE TABS SCROLLS
            // ----------------------------------

            Expanded(
              child: CustomScrollView(
                slivers: [
                  // ----------------------------------
                  // RECIPE IMAGE
                  // ----------------------------------

                  SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        Hero(
                          tag: 'recipe_${widget.recipeId}',
                          child: Image.network(
                            widget.recipeImageUrl,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Back button
                        Positioned(
                          top: 15,
                          left: 15,
                          child: _circleButton(
                            icon: Icons.arrow_back,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),

                        // Save button
                        Positioned(
                          top: 15,
                          right: 15,
                          child: _circleButton(
                            icon: isSaved
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            iconColor:
                            isSaved ? const Color(0xFFFF7043) : Colors.black,
                            onPressed: toggleSave,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ----------------------------------
                  // RECIPE INFORMATION
                  // ----------------------------------

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User information
                          Row(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFE4D7),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Color(0xFFFF7043),
                                  size: 22,
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.username,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),

                                    const SizedBox(height: 2),

                                    Text(
                                      widget.userHandle,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Follow button
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color(0xFFFF7043),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 11,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(25),
                                  ),
                                ),
                                child: const Text(
                                  'Follow',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // Recipe title
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Category / Time / Difficulty
                          Row(
                            children: [
                              _infoChip(
                                widget.category,
                                backgroundColor:
                                const Color(0xFFFFDDD1),
                                textColor:
                                const Color(0xFF9A3214),
                              ),

                              const SizedBox(width: 8),

                              _infoChip(
                                widget.cookingTime,
                                icon: Icons.access_time,
                              ),

                              const SizedBox(width: 8),

                              _infoChip(
                                widget.difficulty,
                                icon: Icons.bar_chart,
                              ),
                            ],
                          ),

                          const SizedBox(height: 22),
                        ],
                      ),
                    ),
                  ),

                  // ----------------------------------
                  // INGREDIENTS / STEPS TABS
                  // ----------------------------------

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2EFED),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _tabButton(
                                title: 'Ingredients',
                                selected: showIngredients,
                                onTap: () {
                                  setState(() {
                                    showIngredients = true;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: _tabButton(
                                title: 'Steps',
                                selected: !showIngredients,
                                onTap: () {
                                  setState(() {
                                    showIngredients = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(
                    child: SizedBox(height: 18),
                  ),

                  // ----------------------------------
                  // INGREDIENTS
                  // ----------------------------------

                  if (showIngredients)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final ingredient =
                            widget.ingredients[index];

                            return Padding(
                              padding:
                              const EdgeInsets.only(bottom: 12),
                              child: _ingredientCard(
                                ingredient: ingredient,
                              ),
                            );
                          },
                          childCount: widget.ingredients.length,
                        ),
                      ),
                    ),

                  // ----------------------------------
                  // STEPS
                  // ----------------------------------

                  if (!showIngredients)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final step = widget.instructions[index];

                            return Padding(
                              padding:
                              const EdgeInsets.only(bottom: 14),
                              child: _stepCard(
                                stepNumber: index + 1,
                                stepText: step,
                              ),
                            );
                          },
                          childCount: widget.instructions.length,
                        ),
                      ),
                    ),

                  // ----------------------------------
                  // BOTTOM SPACE
                  // ----------------------------------

                  const SliverToBoxAdapter(
                    child: SizedBox(height: 10),
                  ),
                ],
              ),
            ),

            // ----------------------------------
            // BOTTOM ACTIONS
            // ----------------------------------

            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFE8E3DF),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Like
                      GestureDetector(
                        onTap: toggleLike,
                        child: Row(
                          children: [
                            Icon(
                              isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isLiked
                                  ? const Color(0xFFFF7043)
                                  : Colors.grey[700],
                              size: 25,
                            ),
                            const SizedBox(width: 7),
                            Text(
                              _formatNumber(currentLikes),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 22),

                      // Comments
                      GestureDetector(
                        onTap: openComments,
                        child: Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.grey[700],
                              size: 24,
                            ),
                            const SizedBox(width: 7),
                            Text(
                              _formatNumber(currentComments),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Share
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.share_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  // Suggest improvement
                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuggestImprovementScreen(
                              // Recipe information
                              recipeId: widget.recipeId,
                              recipeTitle: widget.title,
                              recipeImageUrl: widget.recipeImageUrl,

                              // Author information
                              authorName: widget.username,
                              authorUsername: widget.userHandle,
                              authorImageUrl: '',

                              // Convert Ingredient objects to Maps
                              ingredients: widget.ingredients.map((ingredient) {
                                return {
                                  'name': ingredient.name,
                                  'quantity': ingredient.quantity,
                                  'unit': '',
                                };
                              }).toList(),

                              // Convert List<String> to List<Map<String, String>>
                              steps: widget.instructions.map((instruction) {
                                return {
                                  'description': instruction,
                                };
                              }).toList(),
                            ),
                          ),
                        );
                      },

                      icon: const Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xFFBE3D00),
                      ),

                      label: const Text(
                        'Suggest an Improvement',
                        style: TextStyle(
                          color: Color(0xFFBE3D00),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFFBE3D00),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 13,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SMALL UI COMPONENTS
  // ==========================================================

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color iconColor = Colors.black,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }

  Widget _infoChip(
      String text, {
        IconData? icon,
        Color backgroundColor = const Color(0xFFF0EFED),
        Color textColor = const Color(0xFF55514E),
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 15,
              color: textColor,
            ),
            const SizedBox(width: 5),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabButton({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: selected
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 5,
            ),
          ]
              : null,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: selected
                  ? const Color(0xFFFF7043)
                  : const Color(0xFF55514E),
              fontWeight:
              selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _ingredientCard({
    required Ingredient ingredient,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Ingredient icon
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF2EC),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.restaurant,
              color: const Color(0xFFFF7043),
              size: 21,
            ),
          ),

          const SizedBox(width: 14),

          // Ingredient name
          Expanded(
            child: Text(
              ingredient.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Ingredient amount
          Text(
            ingredient.quantity,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF65615E),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepCard({
    required int stepNumber,
    required String stepText,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step number
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: Color(0xFFFF7043),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$stepNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Step text
          Expanded(
            child: Text(
              stepText,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Color(0xFF383432),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }

    return number.toString();
  }
}