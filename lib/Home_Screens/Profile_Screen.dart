import 'package:flutter/material.dart';
import 'package:frontend/Home_Screens/profile_detailsscreen.dart';
import 'package:frontend/Service/profile_service.dart';
import 'package:frontend/Widgets/Profile_Post.dart';
import 'package:frontend/data/profile_model.dart';
import 'package:frontend/data/profile_recipe_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  final ProfileService _profileService =
  ProfileService();

  ProfileModel? profile;

  bool isLoading = true;
  String? errorMessage;

  bool showingRecipes = true;


  bool isOpeningRecipe = false;

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  // ==========================================================
  // LOAD PROFILE
  // ==========================================================

  Future<void> loadProfile() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result =
      await _profileService.getMyProfile();

      if (!mounted) return;

      setState(() {
        profile = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage =
            _getErrorMessage(e);
      });
    }
  }

  // ==========================================================
  // ERROR
  // ==========================================================

  String _getErrorMessage(Object error) {
    final message = error.toString();

    if (message.contains('401')) {
      return 'Your session has expired. Please login again.';
    }

    if (message.contains('403')) {
      return 'You are not authorized to view this profile.';
    }

    if (message.contains('404')) {
      return 'Profile not found.';
    }

    if (message.contains('Connection')) {
      return 'Could not connect to the server.';
    }

    return 'Something went wrong while loading your profile.';
  }

  // ==========================================================
  // OPEN RECIPE
  // ==========================================================
  Future<void> _openRecipeDetails(
      ProfileRecipe recipe,
      ) async {
    if (isOpeningRecipe) return;

    setState(() {
      isOpeningRecipe = true;
    });

    try {
      final details = await _profileService.getRecipeDetails(
        recipe.receiptId,
      );

      if (!mounted) return;

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ProfilePostDetails(
              recipeId: details.receiptId.toString(),

              username: details.username.isNotEmpty
                  ? details.username
                  : profile!.name,

              userHandle: details.userHandle.isNotEmpty
                  ? details.userHandle
                  : profile!.email,


              authorImageUrl: details.authorImageUrl,

              timeAgo: _formatTime(details.timestamp),

              recipeImageUrl: details.imageUrl,

              title: details.name,

              category: details.category,

              cookingTime: '${details.estimatedTime} min',

              difficulty: 'Medium',

              ingredients: details.ingredients,

              instructions: details.instructions,

              likesCount: details.likesCount,

              commentsCount: details.commentsCount,
            );
          },
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not load recipe: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isOpeningRecipe = false;
        });
      }
    }
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFFFFAF8),

      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  // ==========================================================
  // BODY
  // ==========================================================

  Widget _buildBody() {

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFFF6238),
        ),
      );
    }

    if (errorMessage != null) {
      return _buildErrorState();
    }

    if (profile == null) {
      return const Center(
        child: Text(
          'No profile data found.',
          style: TextStyle(
            color: Color(0xFF674F47),
          ),
        ),
      );
    }

    return RefreshIndicator(
      color:
      const Color(0xFFFF6238),

      onRefresh:
      loadProfile,

      child:
      SingleChildScrollView(
        physics:
        const AlwaysScrollableScrollPhysics(),

        child: Column(
          children: [

            const SizedBox(
              height: 25,
            ),

            // PROFILE IMAGE

            _buildProfilePicture(),

            const SizedBox(
              height: 18,
            ),

            // NAME

            Text(
              profile!.name,

              textAlign:
              TextAlign.center,

              style:
              const TextStyle(
                fontSize: 29,
                fontWeight:
                FontWeight.bold,
                color:
                Color(0xFF24201F),
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            // EMAIL

            Text(
              profile!.email,

              textAlign:
              TextAlign.center,

              style:
              const TextStyle(
                fontSize: 16,
                color:
                Color(0xFF674F47),
              ),
            ),

            const SizedBox(
              height: 22,
            ),

            // TABS

            _buildTabs(),

            const SizedBox(
              height: 16,
            ),

            // CONTENT

            if (showingRecipes)
              Padding(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child:
                _buildRecipesGrid(),
              )
            else
              _buildFavorites(),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // PROFILE PICTURE
  // ==========================================================

  Widget _buildProfilePicture() {
    return Container(
      width: 108,
      height: 108,

      decoration:
      BoxDecoration(
        shape: BoxShape.circle,

        color:
        const Color(0xFFFFE4D7),

        border: Border.all(
          color: Colors.white,
          width: 4,
        ),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(.12),
            blurRadius: 15,
          ),
        ],
      ),

      child: const Icon(
        Icons.person,
        size: 55,
        color:
        Color(0xFFFF7043),
      ),
    );
  }

  // ==========================================================
  // TABS
  // ==========================================================

  Widget _buildTabs() {
    return Row(
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

              decoration:
              BoxDecoration(
                border:
                Border(
                  bottom:
                  BorderSide(
                    color:
                    showingRecipes
                        ? const Color(
                      0xFFFF6238,
                    )
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
                  color:
                  showingRecipes
                      ? const Color(
                    0xFFFF6238,
                  )
                      : const Color(
                    0xFF5D5754,
                  ),

                  fontWeight:
                  showingRecipes
                      ? FontWeight.w500
                      : FontWeight.normal,
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

              decoration:
              BoxDecoration(
                border:
                Border(
                  bottom:
                  BorderSide(
                    color:
                    !showingRecipes
                        ? const Color(
                      0xFFFF6238,
                    )
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
                  color:
                  !showingRecipes
                      ? const Color(
                    0xFFFF6238,
                  )
                      : const Color(
                    0xFF5D5754,
                  ),

                  fontWeight:
                  !showingRecipes
                      ? FontWeight.w500
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // RECIPES GRID
  // ==========================================================

  Widget _buildRecipesGrid() {

    final List<ProfileRecipe>
    recipes = profile!.recipes;

    if (recipes.isEmpty) {
      return const Padding(
        padding:
        EdgeInsets.all(40),

        child: Column(
          children: [

            Icon(
              Icons.restaurant_menu_outlined,
              size: 45,
              color:
              Color(0xFFFF7043),
            ),

            SizedBox(
              height: 12,
            ),

            Text(
              'You have not posted any recipes yet.',

              textAlign:
              TextAlign.center,

              style: TextStyle(
                color:
                Color(0xFF674F47),
                fontSize: 15,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,

      physics:
      const NeverScrollableScrollPhysics(),

      itemCount:
      recipes.length,

      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

        crossAxisSpacing: 14,

        mainAxisSpacing: 16,

        childAspectRatio: .70,
      ),

      itemBuilder:
          (context, index) {

        final recipe =
        recipes[index];

        return GestureDetector(

          onTap: () {
            _openRecipeDetails(
              recipe,
            );
          },

          child: ProfilePost(

            recipeId:
            recipe.receiptId.toString(),

            username:
            profile!.name,

            timeAgo:
            _formatTime(
              recipe.timestamp,
            ),

            recipeImageUrl:
            recipe.imageUrl,

            title:
            recipe.name,

            category:
            recipe.category,

            likesCount:
            0,

            commentsCount:
            0,
          ),
        );
      },
    );
  }

  // ==========================================================
  // FAVORITES
  // ==========================================================

  Widget _buildFavorites() {
    return const Padding(
      padding:
      EdgeInsets.all(40),

      child: Column(
        children: [

          Icon(
            Icons.bookmark_border,
            size: 45,
            color:
            Color(0xFFFF7043),
          ),

          SizedBox(
            height: 12,
          ),

          Text(
            'No favorite recipes yet.',

            textAlign:
            TextAlign.center,

            style: TextStyle(
              color:
              Color(0xFF674F47),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ERROR
  // ==========================================================

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding:
        const EdgeInsets.all(25),

        child: Column(
          mainAxisSize:
          MainAxisSize.min,

          children: [

            const Icon(
              Icons.error_outline,
              size: 50,
              color:
              Color(0xFFFF6238),
            ),

            const SizedBox(
              height: 15,
            ),

            const Text(
              'Could not load your profile',

              textAlign:
              TextAlign.center,

              style: TextStyle(
                fontSize: 18,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Text(
              errorMessage ??
                  'Unknown error',

              textAlign:
              TextAlign.center,

              style:
              const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed:
              loadProfile,

              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                const Color(
                  0xFFFF6238,
                ),
                foregroundColor:
                Colors.white,
              ),

              child:
              const Text(
                'Retry',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // TIMESTAMP
  // ==========================================================

  String _formatTime(
      String timestamp,
      ) {

    if (timestamp.isEmpty) {
      return '';
    }

    try {

      final date =
      DateTime.parse(
        timestamp,
      );

      final difference =
      DateTime.now()
          .difference(date);

      if (difference.inMinutes < 1) {
        return 'Just now';
      }

      if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago';
      }

      if (difference.inHours < 24) {
        return '${difference.inHours}h ago';
      }

      if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      }

      return '${date.day}/${date.month}/${date.year}';

    } catch (_) {
      return '';
    }
  }
}