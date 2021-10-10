import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/user_blogs_events.dart';
import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/repositories/blog_repository.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/states/user_blogs_state.dart';


class UserBlogsBloc extends Bloc<UserBlogsBloc, UserBlogsState> {
  UserBlogsBloc() :super(UserBlogsStateInitial());

  @override
  Stream<UserBlogsState> mapEventToState(UserBlogsBloc event) async* {
    if (event is UserBlogsFetchEvent) {
      String? token = await LocalData().getToken();
      int userId = event.userId;
      List<BlogsCard> tenRecipes = await getBlogsbyUserID(userId);
      if (token != null) {
        yield UserBlogsStateSuccess(tenRecipes);
      }
    }
  }
}