import 'package:vegetarian/models/recipes_card.dart';

class ListRecipes {
  List<RecipesCard> listResult;

  ListRecipes({required this.listResult});

  factory ListRecipes.fromJson(Map<String, dynamic> json) => ListRecipes(
    listResult: List<RecipesCard>.from(json["listResult"].map((x) => RecipesCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listResult": List<dynamic>.from(listResult.map((x) => x.toJson())),
  };
}