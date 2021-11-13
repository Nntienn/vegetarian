// To parse this JSON data, do
//
//     final blogsCard = blogsCardFromJson(jsonString);

import 'dart:convert';

class BlogsCard {
  BlogsCard({
    required this.blogTitle,
    required this.blogThumbnail,
    required this.blogContent,
    required this.firstName,
    required this.lastName,
    required this.blogSubtitle,
    required this.blogId,
    required this.totalLike,
    required this.timeCreated,
    required this.status,
    required this.isPrivate,
    required this.userId,
    required this.isLike,
  });

  String blogTitle;
  String blogThumbnail;
  String blogContent;
  String firstName;
  String lastName;
  String blogSubtitle;
  int blogId;
  int totalLike;
  DateTime timeCreated;
  int status;
  bool isPrivate;
  int userId;
  bool isLike;

  factory BlogsCard.fromRawJson(String str) => BlogsCard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlogsCard.fromJson(Map<String, dynamic> json) => BlogsCard(
    blogTitle: json["blog_title"],
    blogThumbnail: json["blog_thumbnail"],
    blogContent: json["blog_content"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    blogSubtitle: json["blog_subtitle"],
    blogId: json["blog_id"],
    totalLike: json["totalLike"],
    timeCreated: DateTime.parse(json["time_created"]),
    status: json["status"],
    isPrivate: json["is_private"],
    userId: json["user_id"],
    isLike: json["is_like"],
  );

  Map<String, dynamic> toJson() => {
    "blog_title": blogTitle,
    "blog_thumbnail": blogThumbnail,
    "blog_content": blogContent,
    "first_name": firstName,
    "last_name": lastName,
    "blog_subtitle": blogSubtitle,
    "blog_id": blogId,
    "totalLike": totalLike,
    "time_created": timeCreated.toIso8601String(),
    "status": status,
    "is_private": isPrivate,
    "user_id": userId,
    "is_like": isLike,
  };
}
