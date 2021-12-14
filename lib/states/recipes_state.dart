

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
  final User? user;
  final List<Comment> comments;
  final Recipe recipe;
  final bool isLiked;
  final User author;
  final List<String> commentImage;
  RecipeStateSuccess(this.recipe, this.comments, this.user, this.isLiked, this.author, this.path, this.commentImage);
}