import 'package:vegetarian/models/blogs_card.dart';

class ListBlogs{
  List<BlogsCard> listResult;
  ListBlogs({required this.listResult});

  factory ListBlogs.fromJson(Map<String, dynamic> json) => ListBlogs(
    listResult: List<BlogsCard>.from(json["listResult"].map((x) => BlogsCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listResult": List<dynamic>.from(listResult.map((x) => x.toJson())),
  };
}