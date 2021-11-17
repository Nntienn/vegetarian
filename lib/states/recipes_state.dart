

import 'package:vegetarian/models/comment.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/user.dart';

class RecipeState {
  const RecipeState();
}

class RecipeStateInitial extends RecipeState {
}
class RecipeStateFailure extends RecipeState {}
class RecipeStateSuccess extends RecipeState {
  final List<String> path;
  final int userID;
  final List<Comment> comments;
  final Recipe recipe;
  final bool isLiked;
  final User author;
  RecipeStateSuccess(this.recipe, this.comments, this.userID, this.isLiked, this.author, this.path);
}