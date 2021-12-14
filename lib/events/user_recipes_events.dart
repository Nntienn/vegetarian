import 'package:vegetarian/blocs/user_recipes_bloc.dart';

class UserRecipesFetchEvent extends UserRecipesBloc{
}
class UserRecipesDeleteEvent extends UserRecipesBloc{
  final int recipeId;
  UserRecipesDeleteEvent(this.recipeId);
}
class SetPrivateEvent extends UserRecipesBloc{
  final int recipeID;
  SetPrivateEvent(this.recipeID);
}