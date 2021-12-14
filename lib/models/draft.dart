// To parse this JSON data, do
//
//     final draft = draftFromJson(jsonString);

import 'dart:convert';

class Draft {
  Draft({
    required this.listRecipe,
    required this.listBlog,
    required this.listVideo,
  });

  List<ListRecipe> listRecipe;
  List<ListBlog> listBlog;
  List<dynamic> listVideo;

  factory Draft.fromRawJson(String str) => Draft.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Draft.fromJson(Map<String, dynamic> json) => Draft(
    listRecipe: List<ListRecipe>.from(json["listRecipe"].map((x) => ListRecipe.fromJson(x))),
    listBlog: List<ListBlog>.from(json["listBlog"].map((x) => ListBlog.fromJson(x))),
    listVideo: List<dynamic>.from(json["listVideo"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "listRecipe": List<dynamic>.from(listRecipe.map((x) => x.toJson())),
    "listBlog": List<dynamic>.from(listBlog.map((x) => x.toJson())),
    "listVideo": List<dynamic>.from(listVideo.map((x) => x)),
  };
}

class ListBlog {
  ListBlog({
    required this.blogTitle,
    required this.blogThumbnail,
    required this.blogContent,
    required this.firstName,
    required this.lastName,
    required this.blogSubtitle,
    required this.blogId,
    required this.totalLike,
    required this.timeCreated,
    required this.status,
    required this.isPrivate,
    required this.userId,
    required this.isLike,
    required this.isFlagged,
  });

  String blogTitle;
  String blogThumbnail;
  String blogContent;
  String firstName;
  String lastName;
  String blogSubtitle;
  int blogId;
  int totalLike;
  DateTime timeCreated;
  int status;
  bool isPrivate;
  int userId;
  bool isLike;
  bool isFlagged;

  factory ListBlog.fromRawJson(String str) => ListBlog.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListBlog.fromJson(Map<String, dynamic> json) => ListBlog(
    blogTitle: json["blog_title"],
    blogThumbnail: json["blog_thumbnail"]== null ? "https://picsum.photos/536/354": json["blog_thumbnail"],
    blogContent: json["blog_content"]== null ? "": json["blog_content"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    blogSubtitle: json["blog_subtitle"]== null ? "": json["blog_subtitle"],
    blogId: json["blog_id"],
    totalLike: json["totalLike"],
    timeCreated: DateTime.parse(json["time_created"]),
    status: json["status"],
    isPrivate: json["is_private"],
    userId: json["user_id"],
    isLike: json["is_like"],
    isFlagged: json["is_flagged"],
  );

  Map<String, dynamic> toJson() => {
    "blog_title": blogTitle,
    "blog_thumbnail": blogThumbnail,
    "blog_content": blogContent,
    "first_name": firstName,
    "last_name": lastName,
    "blog_subtitle": blogSubtitle,
    "blog_id": blogId,
    "totalLike": totalLike,
    "time_created": timeCreated.toIso8601String(),
    "status": status,
    "is_private": isPrivate,
    "user_id": userId,
    "is_like": isLike,
    "is_flagged": isFlagged,
  };
}

class ListRecipe {
  ListRecipe({
    required this.recipeTitle,
    required this.recipeThumbnail,
    required this.firstName,
    required this.lastName,
    required this.recipeId,
    required this.totalLike,
    required this.timeCreated,
    required this.status,
    required this.isPrivate,
    required this.userId,
    required this.isLike,
    required this.isFlagged,
  });

  String recipeTitle;
  String recipeThumbnail;
  String firstName;
  String lastName;
  int recipeId;
  int totalLike;
  DateTime timeCreated;
  int status;
  bool isPrivate;
  int userId;
  bool isLike;
  bool isFlagged;

  factory ListRecipe.fromRawJson(String str) => ListRecipe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListRecipe.fromJson(Map<String, dynamic> json) => ListRecipe(
    recipeTitle: json["recipe_title"]== null ? "": json["recipe_title"],
    recipeThumbnail: json["recipe_thumbnail"]== null ? "https://picsum.photos/536/354": json["recipe_thumbnail"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    recipeId: json["recipe_id"],
    totalLike: json["totalLike"],
    timeCreated: DateTime.parse(json["time_created"]),
    status: json["status"],
    isPrivate: json["is_private"],
    userId: json["user_id"],
    isLike: json["is_like"],
    isFlagged: json["is_flagged"],
  );

  Map<String, dynamic> toJson() => {
    "recipe_title": recipeTitle,
    "recipe_thumbnail": recipeThumbnail,
    "first_name": firstName,
    "last_name": lastName,
    "recipe_id": recipeId,
    "totalLike": totalLike,
    "time_created": timeCreated.toIso8601String(),
    "status": status,
    "is_private": isPrivate,
    "user_id": userId,
    "is_like": isLike,
    "is_flagged": isFlagged,
  };
}
