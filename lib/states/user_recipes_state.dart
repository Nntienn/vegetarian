import 'package:vegetarian/models/recipes_card.dart';

class UserRecipeState {
  const UserRecipeState();
}

class UserRecipeStateInitial extends UserRecipeState {
}
class UserRecipeStateFailure extends UserRecipeState {}
class UserRecipeDeleteStateSuccess extends UserRecipeState {
  final int userId;

  UserRecipeDeleteStateSuccess(this.userId);
}
class UserRecipeStateSuccess extends UserRecipeState {

  final List<RecipesCard> recipes;
  UserRecipeStateSuccess(this.recipes);
}