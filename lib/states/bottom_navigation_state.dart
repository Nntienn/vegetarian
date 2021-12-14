import 'package:equatable/equatable.dart';
import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/list_4_videos.dart';
import 'package:vegetarian/models/recipes_card.dart';
import 'package:vegetarian/models/recommend_recipes.dart';
import 'package:vegetarian/models/user.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({required this.currentIndex});

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';
}

class PageLoading extends BottomNavigationState {
  @override
  String toString() => 'PageLoading';
}

class FirstPageLoaded extends BottomNavigationState {
  final String? token;
  final List<RecipesCard> recipes;
  final List<RecipesCard> Bestecipes;
  final List<BlogsCard> blogs;
  final Listvideo videos;
  final ListRecommend? recommends;
  final User user;

  FirstPageLoaded(this.token, this.recipes, this.Bestecipes, this.blogs, this.videos, this.recommends, this.user);
}

class SecondPageLoaded extends BottomNavigationState {

  final User user;

  SecondPageLoaded(this.user);
}
