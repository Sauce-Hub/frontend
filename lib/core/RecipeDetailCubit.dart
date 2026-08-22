import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/RecipeDetailState.dart';
import 'package:frontend/network/Recipe_Services.dart';

class RecipeDetailCubit extends Cubit<RecipeDetailState> {
  final RecipeService _recipeService = RecipeService();

  RecipeDetailCubit() : super(RecipeDetailInitialState());

  void fetchRecipeDetail(String recipeId) async {
    emit(RecipeDetailLoadingState());
    try {
      final recipe = await _recipeService.getRecipeDetail(recipeId);
      emit(RecipeDetailSuccessState(recipe));
    } catch (e) {
      emit(RecipeDetailErrorState(e.toString()));
    }
  }
}