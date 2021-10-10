import 'package:vegetarian/blocs/user_recipes_bloc.dart';

class UserRecipesFetchEvent extends UserRecipesBloc{
  final int userId;
  UserRecipesFetchEvent(this.userId);
}
class UserRecipesDeleteEvent extends UserRecipesBloc{
  final int recipeId;
  UserRecipesDeleteEvent(this.recipeId);
}