import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/home_events.dart';
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
import 'package:vegetarian/states/home_states.dart';

class HomeBloc extends Bloc<HomeBloc, HomeState> {
  HomeBloc() :super(HomeStateInitial());

  @override
  Stream<HomeState> mapEventToState(HomeBloc event) async* {
    if (event is HomeFetchEvent) {
      String? token = await LocalData().getToken();
      List<RecipesCard> tenRecipes = await get10Recipes();
      List<RecipesCard> fiveRecipes = await get5bestRecipes();
      List<BlogsCard> tenBlogs = await get10Blogs();
      Listvideo? fourvideos = await get4bestVideos();
      ListRecommend? recommend = await recommendRecipe();
      if (token != null) {
        User? user = await getUser();
        yield HomeStateSuccess(token,tenRecipes, fiveRecipes, tenBlogs, fourvideos!,recommend == null? null : recommend,user!);
      }else{
        yield HomeStateUnLogged(tenRecipes, fiveRecipes, tenBlogs,fourvideos!);
      }
    }
  }
}