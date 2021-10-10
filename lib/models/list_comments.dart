import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/models/comment.dart';
import 'package:vegetarian/models/recipes_card.dart';

class ListComment {
  List<Comment> listResult;

  ListComment({required this.listResult});

  factory ListComment.fromJson(Map<String, dynamic> json) => ListComment(
    listResult: List<Comment>.from(json["listCommentRecipe"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listCommentRecipe": List<dynamic>.from(listResult.map((x) => x.toJson())),
  };
}