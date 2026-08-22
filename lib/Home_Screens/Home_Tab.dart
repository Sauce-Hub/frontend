import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Widgets/Post_widgets.dart';
import 'package:frontend/core/Recipes_Cubit.dart';
import 'package:frontend/core/Recipes_State.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipesCubit()..fetchFypRecipes(),
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.food_bank, color: Color(0xFFF97316)),
          backgroundColor: const Color.fromARGB(255, 252, 238, 228),
          centerTitle: true,
          title: const Text("Sauce hub"),
        ),
        body: BlocBuilder<RecipesCubit, RecipesState>(
          builder: (context, state) {
            if (state is RecipesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFF97316)),
              );
            } else if (state is RecipesSuccessState) {
              if (state.recipes.isEmpty) {
                return const Center(child: Text("No recipes"));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: state.recipes.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final recipe = state.recipes[index];

                  return RecipeCard(
                    recipeId: recipe.recipeId,
                    username: recipe.username,
                    userHandle: recipe.userHandle,
                    timeAgo: recipe.timeAgo,
                    recipeImageUrl: recipe.recipeImageUrl,
                    name: recipe.name,
                    category: recipe.category,
                    caption: recipe.caption,
                    estimatedTime: recipe.estimatedTime,
                    difficulty: recipe.difficulty,
                    ingredients: recipe.ingredients,
                    instructions: recipe.instructions,
                    Calories: recipe.calories,
                    fats: recipe.fats,
                    carbs: recipe.carbs,
                    protein: recipe.protein,
                    likesCount: recipe.likesCount,
                    commentsCount: recipe.commentsCount,
                  );
                },
              );
            } else if (state is RecipesErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("something went wrong ${state.errorMessage}"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<RecipesCubit>().fetchFypRecipes();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF97316),
                      ),
                      child: const Text(
                        "try again",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
