import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:vegetarian/events/bottom_navigation_event.dart';
import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/list_4_videos.dart';
import 'package:vegetarian/models/recipes_card.dart';
import 'package:vegetarian/models/recommend_recipes.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/repositories/blog_repository.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/repositories/video_repository.dart';
import 'package:vegetarian/states/bottom_navigation_state.dart';


class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc()
      :
        super(PageLoading());


  int currentIndex = 0;

  @override
  Stream<BottomNavigationState> mapEventToState(
      BottomNavigationEvent event) async* {
    if (event is AppStarted) {
      this.add(PageTapped(index: this.currentIndex));
    }
    if (event is PageTapped) {
      this.currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: this.currentIndex);
      yield PageLoading();

      if (this.currentIndex == 0) {
        String? token = await LocalData().getToken();
        print(token! + "Token in o day");
        List<RecipesCard> tenRecipes = await get10Recipes();
        List<RecipesCard> fiveRecipes = await get5bestRecipes();
        List<BlogsCard> tenBlogs = await get10Blogs();
        Listvideo? fourvideos = await get4bestVideos();
        ListRecommend? recommend = await recommendRecipe();
        User? user = await getUser();
        yield FirstPageLoaded(token == null ? null : token, tenRecipes, fiveRecipes, tenBlogs, fourvideos!, recommend!, user!);
      }
      if (this.currentIndex == 1) {
        User? user = await getUserbyID(1);

        yield SecondPageLoaded(user!);
      }
    }
  }
}
