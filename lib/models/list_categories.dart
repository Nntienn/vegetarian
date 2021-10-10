import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/models/recipes_card.dart';

class ListCategories {
  List<Category> listResult;

  ListCategories({required this.listResult});

  factory ListCategories.fromJson(Map<String, dynamic> json) => ListCategories(
    listResult: List<Category>.from(json["listResult"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listResult": List<dynamic>.from(listResult.map((x) => x.toJson())),
  };
}