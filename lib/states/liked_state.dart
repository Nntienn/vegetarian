import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/liked.dart';
import 'package:vegetarian/models/recipes_card.dart';

class LikedState {
  const LikedState();
}

class LikedStateInitial extends LikedState {
}
class LikedStateFailure extends LikedState {}
class LikedStateSuccess extends LikedState {
  final List<RecipesCard> recipes;
  final List<BlogsCard> blogs;
  LikedStateSuccess(this.recipes, this.blogs);
}