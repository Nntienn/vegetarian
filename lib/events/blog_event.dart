import 'package:vegetarian/blocs/blog_bloc.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';

class BlogFetchEvent extends BlogBloc{
  final int blogID;
  BlogFetchEvent(this.blogID);
}