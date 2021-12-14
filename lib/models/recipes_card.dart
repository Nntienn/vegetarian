// To parse this JSON data, do
//
//     final recipesCard = recipesCardFromJson(jsonString);

import 'dart:convert';

class RecipesCard {
  RecipesCard({
    required this.recipeTitle,
    required this.recipeThumbnail,
    required this.firstName,
    required this.lastName,
    required this.recipeId,
    required this.totalLike,
    required this.timeCreated,
    required  this.status,
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

  factory RecipesCard.fromRawJson(String str) => RecipesCard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipesCard.fromJson(Map<String, dynamic> json) => RecipesCard(
    recipeTitle: json["recipe_title"]== null ? "https://picsum.photos/536/354":json["recipe_title"],
    recipeThumbnail: json["recipe_thumbnail"]== null ? "":json["recipe_thumbnail"],
    firstName: json["first_name"]== null ? "":json["first_name"],
    lastName: json["last_name"]== null ? "":json["last_name"],
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
