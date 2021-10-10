import 'dart:convert';

class Comment {
  int id;
  int userId;
  int recipeId;
  String firstName;
  String lastName;
  String content;
  DateTime time;

  Comment({
    required this.id,
    required this.userId,
    required this.recipeId,
    required this.firstName,
    required this.lastName,
    required this.content,
    required this.time,
  });



  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    userId: json["user_id"],
    recipeId: json["recipe_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    content: json["content"],
    time: DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "recipe_id": recipeId,
    "first_name": firstName,
    "last_name": lastName,
    "content": content,
    "time": time.toIso8601String(),
  };
}
