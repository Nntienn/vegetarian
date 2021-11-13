// To parse this JSON data, do
//
//     final dailyNutrition = dailyNutritionFromJson(jsonString);

import 'dart:convert';

class DailyNutrition {
  DailyNutrition({
    required this.protein,
    required this.fat,
    required this.carb,
    required this.calories,
  });

  double protein;
  double fat;
  double carb;
  double calories;

  factory DailyNutrition.fromRawJson(String str) => DailyNutrition.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DailyNutrition.fromJson(Map<String, dynamic> json) => DailyNutrition(
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
