// To parse this JSON data, do
//
//     final listRecommend = listRecommendFromJson(jsonString);

import 'dart:convert';

class ListRecommend {
  ListRecommend({
    required this.listBody,
    required this.listSuggest,
  });

  List<ListBodyElement> listBody;
  List<ListBodyElement> listSuggest;

  factory ListRecommend.fromRawJson(String str) => ListRecommend.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListRecommend.fromJson(Map<String, dynamic> json) => ListRecommend(
    listBody: List<ListBodyElement>.from(json["listBody"].map((x) => ListBodyElement.fromJson(x))),
    listSuggest: List<ListBodyElement>.from(json["listSuggest"].map((x) => ListBodyElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listBody": List<dynamic>.from(listBody.map((x) => x.toJson())),
    "listSuggest": List<dynamic>.from(listSuggest.map((x) => x.toJson())),
  };
}

class ListBodyElement {
  ListBodyElement({
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

  factory ListBodyElement.fromRawJson(String str) => ListBodyElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListBodyElement.fromJson(Map<String, dynamic> json) => ListBodyElement(
    userId: json["user_id"],
    recipeTitle: json["recipe_title"] == null ? "": json["recipe_title"],
    recipeThumbnail: json["recipe_thumbnail"] == null ? "https://picsum.photos/536/354": json["recipe_thumbnail"],
    firstName: json["first_name"] == null ? "": json["first_name"],
    lastName: json["last_name"] == null ? "": json["last_name"],
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
