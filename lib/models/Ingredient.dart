import 'dart:convert';

class Ingredient {
  Ingredient({
    required this.ingredientName,
    required this.amountInMg,
  });

  String ingredientName;
  int amountInMg;

  factory Ingredient.fromRawJson(String str) => Ingredient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    ingredientName: json["ingredient_name"],
    amountInMg: json["amount_in_mg"],
  );

  Map<String, dynamic> toJson() => {
    "ingredient_name": ingredientName,
    "amount_in_mg": amountInMg,
  };
}