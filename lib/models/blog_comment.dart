// To parse this JSON data, do
//
//     final blogComment = blogCommentFromJson(jsonString);

import 'dart:convert';

class BlogComment {
  BlogComment({
    required this.id,
    required this.userId,
    required this.blogId,
    required this.firstName,
    required this.lastName,
    required this.content,
    required this.time,
  });

  int id;
  int userId;
  int blogId;
  String firstName;
  String lastName;
  String content;
  DateTime time;

  factory BlogComment.fromRawJson(String str) => BlogComment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlogComment.fromJson(Map<String, dynamic> json) => BlogComment(
    id: json["id"],
    userId: json["user_id"],
    blogId: json["blog_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    content: json["content"],
    time: DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "blog_id": blogId,
    "first_name": firstName,
    "last_name": lastName,
    "content": content,
    "time": time.toIso8601String(),
  };
}
