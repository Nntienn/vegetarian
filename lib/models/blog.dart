// To parse this JSON data, do
//
//     final blog = blogFromJson(jsonString);

import 'dart:convert';

class Blog {
  int blogId;
  int userId;
  String blogTitle;
  String blogSubtitle;
  String blogContent;
  DateTime time;
  String firstName;
  String lastName;
  String blogThumbnail;
  Blog({
    required this.blogId,
    required this.userId,
    required this.blogTitle,
    required this.blogSubtitle,
    required this.blogContent,
    required this.time,
    required this.firstName,
    required this.lastName,
    required this.blogThumbnail,
  });



  factory Blog.fromRawJson(String str) => Blog.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    blogId: json["blog_id"],
    userId: json["user_id"],
    blogTitle: json["blog_title"],
    blogSubtitle: json["blog_subtitle"],
    blogContent: json["blog_content"],
    time: DateTime.parse(json["time"]),
    firstName: json["first_name"],
    lastName: json["last_name"],
    blogThumbnail: json["blog_thumbnail"].toString().length > 20 ? json["blog_thumbnail"] : "https://picsum.photos/536/354",
  );

  Map<String, dynamic> toJson() => {
    "blog_id": blogId,
    "user_id": userId,
    "blog_title": blogTitle,
    "blog_subtitle": blogSubtitle,
    "blog_content": blogContent,
    "time": "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}",
    "first_name": firstName,
    "last_name": lastName,
    "blog_thumbnail": blogThumbnail,
  };
}
