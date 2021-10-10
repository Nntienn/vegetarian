import 'dart:convert';

import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/recipes_card.dart';

class Liked {
  Liked({
    required this.listRecipe,
    required this.listBlog,
  });

  List<RecipesCard> listRecipe;
  List<BlogsCard> listBlog;

  factory Liked.fromRawJson(String str) => Liked.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Liked.fromJson(Map<String, dynamic> json) => Liked(
    listRecipe: List<RecipesCard>.from(json["listRecipe"].map((x) => RecipesCard.fromJson(x))),
    listBlog: List<BlogsCard>.from(json["listBlog"].map((x) => BlogsCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listRecipe": List<dynamic>.from(listRecipe.map((x) => x.toJson())),
    "listBlog": List<dynamic>.from(listBlog.map((x) => x.toJson())),
  };
}