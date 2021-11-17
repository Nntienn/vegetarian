// To parse this JSON data, do
//
//     final listVideos = listVideosFromJson(jsonString);

import 'dart:convert';

class ListVideos {
  ListVideos({
    required this.listVideo,
  });

  List<VideoCard> listVideo;

  factory ListVideos.fromRawJson(String str) => ListVideos.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListVideos.fromJson(Map<String, dynamic> json) => ListVideos(
    listVideo: List<VideoCard>.from(json["listVideo"].map((x) => VideoCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listVideo": List<dynamic>.from(listVideo.map((x) => x.toJson())),
  };
}

class VideoCard {
  VideoCard({
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
  dynamic videoThumbnail;
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

  factory VideoCard.fromRawJson(String str) => VideoCard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideoCard.fromJson(Map<String, dynamic> json) => VideoCard(
    id: json["id"],
    userId: json["user_id"],
    videoCategoryId: json["video_category_id"],
    videoTitle: json["video_title"],
    videoThumbnail: json["video_thumbnail"],
    videoLink: json["video_link"],
    videoDescription: json["video_description"],
    firstName: json["first_name"],
    lastName: json["last_name"],
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
