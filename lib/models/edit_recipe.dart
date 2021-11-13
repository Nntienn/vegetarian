// To parse this JSON data, do
//
//     final editRecipe = editRecipeFromJson(jsonString);

import 'dart:convert';

import 'package:vegetarian/models/Ingredient.dart';
import 'package:vegetarian/models/create_recipe.dart';


class EditRecipe {
  EditRecipe({
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
    required this.ingredients,
  });

  String recipeCategoriesId;
  String recipeTitle;
  String recipeThumbnail;
  List<CreateRecipeStep> steps;
  String recipeDifficulty;
  String portionSize;
  String portionType;
  int prepTimeMinutes;
  int bakingTimeMinutes;
  int restingTimeMinutes;
  List<Ingredient> ingredients;

  factory EditRecipe.fromRawJson(String str) => EditRecipe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EditRecipe.fromJson(Map<String, dynamic> json) => EditRecipe(
    recipeCategoriesId: json["recipe_categories_id"],
    recipeTitle: json["recipe_title"],
    recipeThumbnail: json["recipe_thumbnail"],
    steps: List<CreateRecipeStep>.from(json["steps"].map((x) => CreateRecipeStep.fromJson(x))),
    recipeDifficulty: json["recipe_difficulty"],
    portionSize: json["portion_size"],
    portionType: json["portion_type"],
    prepTimeMinutes: json["prep_time_minute"],
    bakingTimeMinutes: json["baking_time_minute"],
    restingTimeMinutes: json["resting_time_minute"],
    ingredients: List<Ingredient>.from(json["ingredients"].map((x) => Ingredient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
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
    "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
  };
}

