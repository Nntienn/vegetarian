import 'dart:convert';

import 'package:vegetarian/models/list_blogs.dart';
import 'package:vegetarian/models/list_recipes.dart';
import 'package:vegetarian/models/list_video.dart';

class Search {
  Search({
    required this.listRecipe,
    required this.listBlog,
    required this.listVideo,
  });

  List<ListRecipes> listRecipe;
  List<ListBlogs> listBlog;
  List<ListVideos> listVideo;

  factory Search.fromRawJson(String str) => Search.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    listRecipe: List<ListRecipes>.from(json["listRecipe"].map((x) => ListRecipes.fromJson(x))),
    listBlog: List<ListBlogs>.from(json["listBlog"].map((x) => ListBlogs.fromJson(x))),
    listVideo: List<ListVideos>.from(json["listVideo"].map((x) => ListVideos.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listRecipe": List<dynamic>.from(listRecipe.map((x) => x.toJson())),
    "listBlog": List<dynamic>.from(listBlog.map((x) => x.toJson())),
    "listVideo": List<dynamic>.from(listVideo.map((x) => x.toJson())),
  };
}