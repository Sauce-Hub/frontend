import 'package:frontend/network/Recipe_Model.dart';

abstract class RecipeDetailState {}

class RecipeDetailInitialState extends RecipeDetailState {}

class RecipeDetailLoadingState extends RecipeDetailState {}

class RecipeDetailSuccessState extends RecipeDetailState {
  final RecipeModel recipe;
  RecipeDetailSuccessState(this.recipe);
}

class RecipeDetailErrorState extends RecipeDetailState {
  final String errorMessage;
  RecipeDetailErrorState(this.errorMessage);
}