// To parse this JSON data, do
//
//     final weeklyMenu = weeklyMenuFromJson(jsonString);

import 'dart:convert';

class WeeklyMenu {
  WeeklyMenu({
    required this.startDate,
    required this.endDate,
    required this.menu,
  });

  String startDate;
  String endDate;
  List<Menu> menu;

  factory WeeklyMenu.fromRawJson(String str) => WeeklyMenu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeeklyMenu.fromJson(Map<String, dynamic> json) => WeeklyMenu(
    startDate: json["startDate"] != null ? json["startDate"]:DateTime.now().toString(),
    endDate: json["endDate"] != null ? json["startDate"]:DateTime.now().toString(),
    menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "startDate": startDate,
    "endDate": endDate,
    "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
  };
}

class Menu {
  Menu({
    required this.date,
    required this.listWeeklyRecipe,
  });

  DateTime date;
  List<ListWeeklyRecipe> listWeeklyRecipe;

  factory Menu.fromRawJson(String str) => Menu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    date: DateTime.parse(json["date"]),
    listWeeklyRecipe: List<ListWeeklyRecipe>.from(json["listRecipe"].map((x) => ListWeeklyRecipe.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "listRecipe": List<dynamic>.from(listWeeklyRecipe.map((x) => x.toJson())),
  };
}

class ListWeeklyRecipe {
  ListWeeklyRecipe({
    required this.recipeId,
    required this.recipeTitle,
    required this.recipeThumbnail,
    required this.mealOfDay,
    required this.calo,
  });

  int recipeId;
  String recipeTitle;
  String recipeThumbnail;
  String mealOfDay;
  int calo;

  factory ListWeeklyRecipe.fromRawJson(String str) => ListWeeklyRecipe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListWeeklyRecipe.fromJson(Map<String, dynamic> json) => ListWeeklyRecipe(
    recipeId: json["recipe_id"],
    recipeTitle: json["recipe_title"],
    recipeThumbnail: json["recipe_thumbnail"]== null ?  "":json["recipe_thumbnail"],
    mealOfDay: json["meal_of_day"],
    calo: json["calo"],
  );

  Map<String, dynamic> toJson() => {
    "recipe_id": recipeId,
    "recipe_title": recipeTitle,
    "recipe_thumbnail": recipeThumbnail,
    "meal_of_day": mealOfDay,
    "calo": calo,
  };
}
