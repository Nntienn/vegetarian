import 'dart:convert';

import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/recipes_card.dart';
import 'package:vegetarian/models/video.dart';

class Search {
  Search({
    required this.listRecipe,
    required this.listBlog,
    required this.listVideo,
  });

  List<RecipesCard> listRecipe;
  List<BlogsCard> listBlog;
  List<Video> listVideo;

  factory Search.fromRawJson(String str) => Search.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    listRecipe: List<RecipesCard>.from(json["listRecipe"].map((x) => RecipesCard.fromJson(x))),
    listBlog: List<BlogsCard>.from(json["listBlog"].map((x) => BlogsCard.fromJson(x))),
    listVideo: List<Video>.from(json["listVideo"].map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listRecipe": List<dynamic>.from(listRecipe.map((x) => x.toJson())),
    "listBlog": List<dynamic>.from(listBlog.map((x) => x.toJson())),
    "listVideo": List<dynamic>.from(listVideo.map((x) => x.toJson())),
  };
}