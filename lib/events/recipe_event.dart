import 'package:vegetarian/blocs/recipe_blocs.dart';

class RecipeFetchEvent extends RecipeBloc{
  final int recipeID;
  RecipeFetchEvent(this.recipeID);
}

class RecipeCommentEvent extends RecipeBloc{
  final int recipeId;
  final String comment;
  RecipeCommentEvent(this.comment, this.recipeId);
}