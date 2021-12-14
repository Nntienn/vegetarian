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
    required this.videoThumbnail,
    required this.videoLink,
    required this.videoDescription,
    required this.firstName,
    required this.lastName,
    required this.timeCreated,
    required this.isPrivate,
    required this.status,
    required this.totalLike,
    required this.isLike,
    required this.isFlagged,
  });

  int id;
  int userId;
  int videoCategoryId;
  String videoTitle;
  String videoThumbnail;
  String videoLink;
  String videoDescription;
  String firstName;
  String lastName;
  DateTime timeCreated;
  bool isPrivate;
  int status;
  int totalLike;
  bool isLike;
  bool isFlagged;

  factory Video.fromRawJson(String str) => Video.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    userId: json["user_id"],
    videoCategoryId: json["video_category_id"],
    videoTitle: json["video_title"]== null ? "":json["video_title"],
    videoThumbnail: json["video_thumbnail"] == null ? "https://media.wired.com/photos/5b74a1ca8a992b7a26e92da5/master/w_2560%2Cc_limit/comeout_videos-01.jpg" :json["video_thumbnail"] ,
    videoLink: json["video_link"]== null ? "":json["video_link"],
    videoDescription: json["video_description"]== null ? "":json["video_title"],
    firstName: json["first_name"]== null ? "":json["first_name"],
    lastName: json["last_name"]== null ? "":json["last_name"],
    timeCreated: DateTime.parse(json["time_created"]),
    isPrivate: json["is_private"],
    status: json["status"],
    totalLike: json["totalLike"],
    isLike: json["is_like"],
    isFlagged: json["is_flagged"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "video_category_id": videoCategoryId,
    "video_title": videoTitle,
    "video_thumbnail": videoThumbnail,
    "video_link": videoLink,
    "video_description": videoDescription,
    "first_name": firstName,
    "last_name": lastName,
    "time_created": timeCreated.toIso8601String(),
    "is_private": isPrivate,
    "status": status,
    "totalLike": totalLike,
    "is_like": isLike,
    "is_flagged": isFlagged,
  };
}
