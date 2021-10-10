import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/recipes_card.dart';
import 'package:vegetarian/repositories/blog_repository.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
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
      if (token != null) {
        yield HomeStateSuccess(token,tenRecipes, fiveRecipes, tenBlogs);
      }else{
        yield HomeStateUnLogged(tenRecipes, fiveRecipes, tenBlogs);
      }
    }
  }
}