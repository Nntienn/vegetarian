import 'package:vegetarian/blocs/user_blogs_bloc.dart';
import 'package:vegetarian/blocs/user_recipes_bloc.dart';

class UserBlogsFetchEvent extends UserBlogsBloc{
  final int userId;
  UserBlogsFetchEvent(this.userId);
}