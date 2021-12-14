// To parse this JSON data, do
//
//     final recipe = recipeFromJson(jsonString);

import 'dart:convert';

import 'package:vegetarian/models/Ingredient.dart';

class Recipe {
  int recipeId;
  int userId;
  int recipeCategoriesId;
  String recipeTitle;
  String recipeThumbnail;
  List<RecipeStep> steps;
  int recipeDifficulty;
  int portionSize;
  String portionType;
  int prepTimeMinutes;
  int bakingTimeMinutes;
  int restingTimeMinutes;
  DateTime timeCreated;
  dynamic timeUpdated;
  String firstName;
  String lastName;
  Nutrition nutrition;
  List<Ingredient> ingredients;
  int totalLike;
  bool isPrivate;
  int status;
  bool isLike;

  Recipe({
    required this.recipeId,
    required this.userId,
    required this.recipeCategoriesId,
    required this.recipeTitle,
    required this.recipeThumbnail,
    required this.steps,
    required this.recipeDifficulty,
    required this.portionSize,
    required this.portionType,
    required this.prepTimeMinutes,
    required this.bakingTimeMinutes,
    required this.restingTimeMinutes,
    required this.timeCreated,
    required this.timeUpdated,
    required this.firstName,
    required this.lastName,
    required this.nutrition,
    required this.ingredients,
    required this.totalLike,
    required this.isPrivate,
    required this.status,
    required this.isLike,
  });

  factory Recipe.fromRawJson(String str) => Recipe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    recipeId: json["recipe_id"],
    userId: json["user_id"],
    recipeCategoriesId: json["recipe_categories_id"],
    recipeTitle: json["recipe_title"],
    recipeThumbnail: json["recipe_thumbnail"],
    steps: List<RecipeStep>.from(json["steps"].map((x) => RecipeStep.fromJson(x))),
    recipeDifficulty: json["recipe_difficulty"],
    portionSize: json["portion_size"],
    portionType: json["portion_type"],
    prepTimeMinutes: json["prep_time_minutes"],
    bakingTimeMinutes: json["baking_time_minutes"],
    restingTimeMinutes: json["resting_time_minutes"],
    timeCreated: DateTime.parse(json["time_created"]),
    timeUpdated: json["time_updated"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    nutrition: Nutrition.fromJson(json["nutrition"]),
    ingredients: List<Ingredient>.from(json["ingredients"].map((x) => Ingredient.fromJson(x))),
    totalLike: json["totalLike"],
    isPrivate: json["is_private"],
    status: json["status"],
    isLike: json["is_like"],
  );

  Map<String, dynamic> toJson() => {
    "recipe_id": recipeId,
    "user_id": userId,
    "recipe_categories_id": recipeCategoriesId,
    "recipe_title": recipeTitle,
    "recipe_thumbnail": recipeThumbnail,
    "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
    "recipe_difficulty": recipeDifficulty,
    "portion_size": portionSize,
    "portion_type": portionType,
    "prep_time_minutes": prepTimeMinutes,
    "baking_time_minutes": bakingTimeMinutes,
    "resting_time_minutes": restingTimeMinutes,
    "time_created": timeCreated.toIso8601String(),
    "time_updated": timeUpdated,
    "first_name": firstName,
    "last_name": lastName,
    // "nutrition": nutrition.toJson(),
    "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
    "totalLike": totalLike,
    "is_private": isPrivate,
    "status": status,
    "is_like": isLike,
  };
}



class Nutrition {
  Nutrition({
    required this.protein,
    required this.fat,
    required this.carb,
    required this.calories,
  });

  double protein;
  double fat;
  double carb;
  double calories;

  factory Nutrition.fromRawJson(String str) => Nutrition.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Nutrition.fromJson(Map<String, dynamic> json) => Nutrition(
    protein: json["protein"].toDouble(),
    fat: json["fat"].toDouble(),
    carb: json["carb"].toDouble(),
    calories: json["calories"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "protein": protein,
    "fat": fat,
    "carb": carb,
    "calories": calories,
  };
}

class RecipeStep {
  RecipeStep({
    required this.recipeId,
    required this.stepIndex,
    required this.stepContent,
  });

  int recipeId;
  int stepIndex;
  String stepContent;

  factory RecipeStep.fromRawJson(String str) => RecipeStep.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeStep.fromJson(Map<String, dynamic> json) => RecipeStep(
    recipeId: json["recipe_id"],
    stepIndex: json["step_index"],
    stepContent: json["step_content"],
  );

  Map<String, dynamic> toJson() => {
    "recipe_id": recipeId,
    "step_index": stepIndex,
    "step_content": stepContent,
  };
}
