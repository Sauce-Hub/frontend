import 'package:frontend/network/Recipe_Model.dart';

abstract class RecipesState {}

class RecipesInitialState extends RecipesState {}

class RecipesLoadingState extends RecipesState {}

class RecipesSuccessState extends RecipesState {
  final List<RecipeModel> recipes;
  RecipesSuccessState(this.recipes);
}

class RecipesErrorState extends RecipesState {
  final String errorMessage;
  RecipesErrorState(this.errorMessage);
}