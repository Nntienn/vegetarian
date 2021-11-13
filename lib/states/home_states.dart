

import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/list_4_videos.dart';
import 'package:vegetarian/models/recipes_card.dart';
import 'package:vegetarian/models/recommend_recipes.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/models/video.dart';

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
  final Listvideo videos;
  final List<RRecipesCard> recommends;
  final User user;
  HomeStateSuccess(this.token, this.recipes, this.Bestecipes, this.blogs, this.videos, this.recommends, this.user);
}
class HomeStateUnLogged extends HomeState{
  final List<RecipesCard> recipes;
  final List<RecipesCard> Bestecipes;
  final List<BlogsCard> blogs;
  final Listvideo videos;
  HomeStateUnLogged(this.recipes, this.Bestecipes, this.blogs, this.videos);
}