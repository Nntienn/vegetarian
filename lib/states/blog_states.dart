

import 'package:vegetarian/models/blog.dart';
import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/recipe.dart';

class BlogState {
  const BlogState();
}

class BlogStateInitial extends BlogState {
}
class BlogStateFailure extends BlogState {}
class BlogStateSuccess extends BlogState {
  final Blog blog;
  BlogStateSuccess(this.blog);
}