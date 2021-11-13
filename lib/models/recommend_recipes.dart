// To parse this JSON data, do
//
//     final recipesCard = recipesCardFromJson(jsonString);

import 'dart:convert';

class ListRecommend {
  ListRecommend({
    required this.listRecommend,
  });

  List<RRecipesCard> listRecommend;

  factory ListRecommend.fromRawJson(String str) => ListRecommend.fromJson(json.decode(str));

  factory ListRecommend.fromJson(Map<String, dynamic> json) => ListRecommend(
    listRecommend: List<RRecipesCard>.from(json[""].map((x) => RRecipesCard.fromJson(x))),
  );
}

class RRecipesCard {
  RRecipesCard({
    required this.userId,
    required this.recipeTitle,
    required this.recipeThumbnail,
    required this.firstName,
    required this.lastName,
    required this.recipeId,
    required this.totalLike,
    required this.timeCreated,
    required this.criteria,
  });

  int userId;
  String recipeTitle;
  String recipeThumbnail;
  String firstName;
  String lastName;
  int recipeId;
  int totalLike;
  DateTime timeCreated;
  int criteria;

  factory RRecipesCard.fromRawJson(String str) => RRecipesCard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RRecipesCard.fromJson(Map<String, dynamic> json) => RRecipesCard(
    userId: json["user_id"],
    recipeTitle: json["recipe_title"],
    recipeThumbnail: json["recipe_thumbnail"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    recipeId: json["recipe_id"],
    totalLike: json["totalLike"],
    timeCreated: DateTime.parse(json["time_created"]),
    criteria: json["criteria"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "recipe_title": recipeTitle,
    "recipe_thumbnail": recipeThumbnail,
    "first_name": firstName,
    "last_name": lastName,
    "recipe_id": recipeId,
    "totalLike": totalLike,
    "time_created": timeCreated.toIso8601String(),
    "criteria": criteria,
  };
}
