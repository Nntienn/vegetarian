// To parse this JSON data, do
//
//     final blogs = blogsFromJson(jsonString);

import 'dart:convert';

class BlogsCard {
  String blogTitle;
  String blogThumbnail;
  String blogContent;
  String firstName;
  String lastName;
  int blogId;
  DateTime time;
  BlogsCard({
    required this.blogTitle,
    required this.blogThumbnail,
    required this.blogContent,
    required this.firstName,
    required this.lastName,
    required this.blogId,
    required this.time,
  });

  factory BlogsCard.fromRawJson(String str) => BlogsCard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlogsCard.fromJson(Map<String, dynamic> json) => BlogsCard(
    blogTitle: json["blog_title"],
    blogThumbnail: json["blog_thumbnail"].toString().length > 20 ? json["blog_thumbnail"] : "https://picsum.photos/536/354",
    blogContent: json["blog_content"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    blogId: json["blog_id"],
    time: DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "blog_title": blogTitle,
    "blog_thumbnail": blogThumbnail,
    "blog_content": blogContent,
    "first_name": firstName,
    "last_name": lastName,
    "blog_id": blogId,
    "time": "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}",
  };
}
