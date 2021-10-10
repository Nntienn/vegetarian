// To parse this JSON data, do
//
//     final createRecipe = createRecipeFromJson(jsonString);

import 'dart:convert';

import 'package:vegetarian/models/ingredient.dart';

class CreateRecipe {
  int userId;
  String recipeCategoriesId;
  String recipeTitle;
  String recipeThumbnail;
  String recipeContent;
  String recipeDifficulty;
  String portionType;
  String portionSize;
  String prepTimeMinutes;
  String bakingTimeMinutes;
  String restingTimeMinutes;
  List<Ingredient> ingredients;
  CreateRecipe({
    required this.userId,
    required this.recipeCategoriesId,
    required this.recipeTitle,
    required this.recipeThumbnail,
    required this.recipeContent,
    required this.recipeDifficulty,
    required this.portionType,
    required this.portionSize,
    required this.prepTimeMinutes,
    required this.bakingTimeMinutes,
    required this.restingTimeMinutes,
    required this.ingredients,
  });



  factory CreateRecipe.fromRawJson(String str) => CreateRecipe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateRecipe.fromJson(Map<String, dynamic> json) => CreateRecipe(
    userId: json["user_id"],
    recipeCategoriesId: json["recipe_categories_id"],
    recipeTitle: json["recipe_title"],
    recipeThumbnail: json["recipe_thumbnail"],
    recipeContent: json["recipe_content"],
    recipeDifficulty: json["recipe_difficulty"],
    portionType: json["portion_type"],
    portionSize: json["portion_size"],
    prepTimeMinutes: json["prep_time_minutes"],
    bakingTimeMinutes: json["baking_time_minutes"],
    restingTimeMinutes: json["resting_time_minutes"],
    ingredients: List<Ingredient>.from(json["ingredients"].map((x) => Ingredient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "recipe_categories_id": recipeCategoriesId,
    "recipe_title": recipeTitle,
    "recipe_thumbnail": recipeThumbnail,
    "recipe_content": recipeContent,
    "recipe_difficulty": recipeDifficulty,
    "portion_type": portionType,
    "portion_size": portionSize,
    "prep_time_minutes": prepTimeMinutes,
    "baking_time_minutes": bakingTimeMinutes,
    "resting_time_minutes": restingTimeMinutes,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
  };
}


