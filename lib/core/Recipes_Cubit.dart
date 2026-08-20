import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/Recipes_State.dart';
import 'package:frontend/network/Recipe_Services.dart';


class RecipesCubit extends Cubit<RecipesState> {
  final RecipeService _recipeService = RecipeService();

  RecipesCubit() : super(RecipesInitialState());

  void fetchFypRecipes() async {
    emit(RecipesLoadingState());
    try {
      final recipes = await _recipeService.getFypRecipes();
      emit(RecipesSuccessState(recipes));
    } catch (e) {
      emit(RecipesErrorState(e.toString()));
    }
  }
}