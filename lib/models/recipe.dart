// To parse this JSON data, do
//
//     final recipes = recipesFromJson(jsonString);

import 'dart:convert';

class Recipe {
  Recipe({
    required this.recipeId,
    required this.userId,
    required this.recipeCategoriesId,
    required this.recipeTitle,
    required this.recipeThumbnail,
    required this.recipeContent,
    required this.recipeDifficulty,
    required this.portionSize,
    required this.portionType,
    required this.prepTimeMinutes,
    required this.bakingTimeMinutes,
    required this.restingTimeMinutes,
    required this.timeCreated,
    required this.firstName,
    required this.lastName,
  });

  int recipeId;
  int userId;
  int recipeCategoriesId;
  String recipeTitle;
  String recipeThumbnail;
  String recipeContent;
  int recipeDifficulty;
  int portionSize;
  String portionType;
  int prepTimeMinutes;
  int bakingTimeMinutes;
  int restingTimeMinutes;
  DateTime timeCreated;
  String firstName;
  String lastName;

  factory Recipe.fromRawJson(String str) => Recipe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    recipeId: json["recipe_id"],
    userId: json["user_id"],
    recipeCategoriesId: json["recipe_categories_id"],
    recipeTitle: json["recipe_title"],
    recipeThumbnail: json["recipe_thumbnail"].toString().length > 20 ? json["recipe_thumbnail"] : "https://images.unsplash.com/photo-1599020792689-9fde458e7e17?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dmVnZXRhcmlhbiUyMGZvb2R8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80&fbclid=IwAR2lbdXG_WZiw2dq25_C3jbMvjJNqBvdpYjWasPupjuhbfbcfd-y8AWs6sI",
    recipeContent: json["recipe_content"],
    recipeDifficulty: json["recipe_difficulty"],
    portionSize: json["portion_size"],
    portionType: json["portion_type"],
    prepTimeMinutes: json["prep_time_minutes"],
    bakingTimeMinutes: json["baking_time_minutes"],
    restingTimeMinutes: json["resting_time_minutes"],
    timeCreated: DateTime.parse(json["time_created"]),
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "recipe_id": recipeId,
    "user_id": userId,
    "recipe_categories_id": recipeCategoriesId,
    "recipe_title": recipeTitle,
    "recipe_thumbnail": recipeThumbnail,
    "recipe_content": recipeContent,
    "recipe_difficulty": recipeDifficulty,
    "portion_size": portionSize,
    "portion_type": portionType,
    "prep_time_minutes": prepTimeMinutes,
    "baking_time_minutes": bakingTimeMinutes,
    "resting_time_minutes": restingTimeMinutes,
    "time_created": "${timeCreated.year.toString().padLeft(4, '0')}-${timeCreated.month.toString().padLeft(2, '0')}-${timeCreated.day.toString().padLeft(2, '0')}",
    "first_name": firstName,
    "last_name": lastName,
  };
}
