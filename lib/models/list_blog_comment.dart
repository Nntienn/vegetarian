import 'package:vegetarian/models/blog_comment.dart';
import 'package:vegetarian/models/comment.dart';

class ListBlogComment {
  List<BlogComment> listResult;

  ListBlogComment({required this.listResult});

  factory ListBlogComment.fromJson(Map<String, dynamic> json) => ListBlogComment(
    listResult: List<BlogComment>.from(json["listCommentBlog"].map((x) => BlogComment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listCommentRecipe": List<dynamic>.from(listResult.map((x) => x.toJson())),
  };
}