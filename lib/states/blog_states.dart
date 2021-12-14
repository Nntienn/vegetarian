

import 'package:vegetarian/models/blog.dart';
import 'package:vegetarian/models/blog_comment.dart';
import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/user.dart';

class BlogState {
  const BlogState();
}

class BlogStateInitial extends BlogState {
}
class BlogStateFailure extends BlogState {}
class BlogStateSuccess extends BlogState {
  final List<BlogComment> comments;
  final Blog blog;
  final List<String> path;
  final User? user;
  final User author;
  final List<String> commentImage;
  BlogStateSuccess(this.blog, this.comments, this.path, this.user, this.author, this.commentImage);
}