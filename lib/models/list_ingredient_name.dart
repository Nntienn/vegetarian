// To parse this JSON data, do
//
//     final listingredientname = listingredientnameFromJson(jsonString);

import 'dart:convert';

class ListIngredientName {
  ListIngredientName({
    required this.listIngredient,
  });

  List<ListIngredient> listIngredient;

  factory ListIngredientName.fromRawJson(String str) => ListIngredientName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListIngredientName.fromJson(Map<String, dynamic> json) => ListIngredientName(
    listIngredient: List<ListIngredient>.from(json["listIngredient"].map((x) => ListIngredient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listIngredient": List<dynamic>.from(listIngredient.map((x) => x.toJson())),
  };
}

class ListIngredient {
  ListIngredient({
    required this.ingredientName,
  });

  String ingredientName;

  factory ListIngredient.fromRawJson(String str) => ListIngredient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListIngredient.fromJson(Map<String, dynamic> json) => ListIngredient(
    ingredientName: json["ingredient_name"],
  );

  Map<String, dynamic> toJson() => {
    "ingredient_name": ingredientName,
  };
}
