import 'package:vegetarian/models/recipes_card.dart';

class ListRecipes2 {

  List<RecipesCard> listResult;
  int page;
  int totalPage;
  ListRecipes2({required this.listResult,required this.page,
    required this.totalPage,});

  factory ListRecipes2.fromJson(Map<String, dynamic> json) => ListRecipes2(
    page: json["page"],
    totalPage: json["totalPage"],
    listResult: List<RecipesCard>.from(json["listResult"].map((x) => RecipesCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "totalPage": totalPage,
    "listResult": List<dynamic>.from(listResult.map((x) => x.toJson())),
  };
}
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