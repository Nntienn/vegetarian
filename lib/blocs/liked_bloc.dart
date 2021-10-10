import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/liked_events.dart';
import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/liked.dart';
import 'package:vegetarian/models/recipes_card.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/liked_state.dart';
class LikedBloc extends Bloc<LikedBloc, LikedState> {
  LikedBloc() :super(LikedStateInitial());

  @override
  Stream<LikedState> mapEventToState(LikedBloc event) async* {
    if (event is LikedFetchEvent) {
      String? token = await LocalData().getToken();
      Liked? liked = await getUserLiked();
      if (liked != null) {
      List<RecipesCard> recipes = liked.listRecipe;
      List<BlogsCard> blogs = liked.listBlog;
        yield LikedStateSuccess(recipes,blogs);
      }
    }
  }
}