import 'package:vegetarian/models/blogs_card.dart';

class UserBlogsState {
  const UserBlogsState();
}

class UserBlogsStateInitial extends UserBlogsState {
}
class UserBlogsStateFailure extends UserBlogsState {}
class UserBlogsStateSuccess extends UserBlogsState {
  final List<BlogsCard> blogs;
  UserBlogsStateSuccess(this.blogs);
}