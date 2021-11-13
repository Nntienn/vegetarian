

import 'package:vegetarian/models/comment.dart';
import 'package:vegetarian/models/recipe.dart';

class RecipeState {
  const RecipeState();
}

class RecipeStateInitial extends RecipeState {
}
class RecipeStateFailure extends RecipeState {}
class RecipeStateSuccess extends RecipeState {
  final int userID;
  final List<Comment> comments;
  final Recipe recipe;
  final bool isLiked;
  RecipeStateSuccess(this.recipe, this.comments, this.userID, this.isLiked);

}