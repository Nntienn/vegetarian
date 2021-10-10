

import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/recipes_card.dart';

class HomeState {
  const HomeState();
}

class HomeStateInitial extends HomeState{}
class HomeStateFailure extends HomeState{}
class HomeStateSuccess extends HomeState{
  final String token;
  final List<RecipesCard> recipes;
  final List<RecipesCard> Bestecipes;
  final List<BlogsCard> blogs;
  HomeStateSuccess(this.token, this.recipes, this.Bestecipes, this.blogs);
}
class HomeStateUnLogged extends HomeState{
  final List<RecipesCard> recipes;
  final List<RecipesCard> Bestecipes;
  final List<BlogsCard> blogs;
  HomeStateUnLogged(this.recipes, this.Bestecipes, this.blogs);
}