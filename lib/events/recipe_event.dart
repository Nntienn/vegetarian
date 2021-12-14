import 'package:vegetarian/blocs/recipe_blocs.dart';

class RecipeFetchEvent extends RecipeBloc{
  final String lastPage;
  final int recipeID;
  RecipeFetchEvent(this.recipeID, this.lastPage);
}

class RecipeCommentEvent extends RecipeBloc{
  final int recipeId;
  final String comment;
  RecipeCommentEvent(this.comment, this.recipeId);
}
class EditRecipeCommentEvent extends RecipeBloc{
  final int commentId;
  final int recipeId;
  final String comment;
  EditRecipeCommentEvent(this.comment, this.commentId, this.recipeId);
}

class RecipeLikeEvent extends RecipeBloc{
  final int recipeID;
  RecipeLikeEvent(this.recipeID);
}


class RecipeDeleteCommentEvent extends RecipeBloc{
  final int recipeId;
  final int commentId;
  RecipeDeleteCommentEvent(this.commentId, this.recipeId);
}

class RecipeprivateEvent extends RecipeBloc{
  final int recipeId;
  RecipeprivateEvent( this.recipeId);
}