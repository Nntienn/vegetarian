// To parse this JSON data, do
//
//     final video = videoFromJson(jsonString);

import 'dart:convert';

class Video {
  Video({
    required this.id,
    required this.userId,
    required this.videoCategoryId,
    required this.videoTitle,
    required this.videoLink,
    required this.videoDescription,
    required this.firstName,
    required this.lastName,
    required this.timeCreated,
  });

  int id;
  int userId;
  int videoCategoryId;
  String videoTitle;
  String videoLink;
  String videoDescription;
  String firstName;
  String lastName;
  DateTime timeCreated;

  factory Video.fromRawJson(String str) => Video.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    userId: json["user_id"],
    videoCategoryId: json["video_category_id"],
    videoTitle: json["video_title"],
    videoLink: json["video_link"],
    videoDescription: json["video_description"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    timeCreated: DateTime.parse(json["time_created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "video_category_id": videoCategoryId,
    "video_title": videoTitle,
    "video_link": videoLink,
    "video_description": videoDescription,
    "first_name": firstName,
    "last_name": lastName,
    "time_created": timeCreated.toIso8601String(),
  };
}
