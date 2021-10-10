// To parse this JSON data, do
//
//     final recipes = recipesFromJson(jsonString);

import 'dart:convert';

class RecipesCard {

  String recipeTitle;
  String recipeThumbnail;
  String firstName;
  String lastName;
  int recipeId;

  RecipesCard({
    required this.recipeTitle,
    required this.recipeThumbnail,
    required this.firstName,
    required this.lastName,
    required this.recipeId,
  });


  factory RecipesCard.fromRawJson(String str) => RecipesCard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipesCard.fromJson(Map<String, dynamic> json) => RecipesCard(
    recipeTitle: json["recipe_title"],
    recipeThumbnail: json["recipe_thumbnail"].toString().length > 20 ? json["recipe_thumbnail"] : "https://images.unsplash.com/photo-1599020792689-9fde458e7e17?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dmVnZXRhcmlhbiUyMGZvb2R8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80&fbclid=IwAR2lbdXG_WZiw2dq25_C3jbMvjJNqBvdpYjWasPupjuhbfbcfd-y8AWs6sI",
    firstName: json["first_name"],
    lastName: json["last_name"],
    recipeId: json["recipe_id"],
  );

  Map<String, dynamic> toJson() => {
    "recipe_title": recipeTitle,
    "recipe_thumbnail": recipeThumbnail,
    "first_name": firstName,
    "last_name": lastName,
    "recipe_id": recipeId,
  };
}
