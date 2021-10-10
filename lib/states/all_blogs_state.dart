import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/recipes_card.dart';

class AllBlogsState {
  const AllBlogsState();
}

class AllBlogsStateInitial extends AllBlogsState {
}
class AllBlogsStateFailure extends AllBlogsState {}
class AllBlogsStateSuccess extends AllBlogsState {
  final List<BlogsCard> blogs;
  AllBlogsStateSuccess(this.blogs);
}