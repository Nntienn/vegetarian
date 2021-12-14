// To parse this JSON data, do
//
//     final blog = blogFromJson(jsonString);

import 'dart:convert';

class Blog {
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
    required this.totalLike,
    required this.timeUpdated,
    required this.isPrivate,
    required this.status,
    required this.isLike,
  });

  int blogId;
  int userId;
  String blogTitle;
  String blogSubtitle;
  String blogContent;
  DateTime time;
  String firstName;
  String lastName;
  String blogThumbnail;
  int totalLike;
  dynamic timeUpdated;
  bool isPrivate;
  int status;
  bool isLike;

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
    blogThumbnail: json["blog_thumbnail"] == null ? "https://picsum.photos/536/354" :json["blog_thumbnail"],
    totalLike: json["totalLike"],
    timeUpdated: json["time_updated"],
    isPrivate: json["is_private"],
    status: json["status"],
    isLike: json["is_like"],
  );

  Map<String, dynamic> toJson() => {
    "blog_id": blogId,
    "user_id": userId,
    "blog_title": blogTitle,
    "blog_subtitle": blogSubtitle,
    "blog_content": blogContent,
    "time": time.toIso8601String(),
    "first_name": firstName,
    "last_name": lastName,
    "blog_thumbnail": blogThumbnail,
    "totalLike": totalLike,
    "time_updated": timeUpdated,
    "is_private": isPrivate,
    "status": status,
    "is_like": isLike,
  };
}
