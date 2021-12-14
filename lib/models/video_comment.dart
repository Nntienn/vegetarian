// To parse this JSON data, do
//
//     final videoComment = videoCommentFromJson(jsonString);

import 'dart:convert';

class ListVideoComment {
  ListVideoComment({
    required this.listCommentVideo,
  });

  List<VideoComment> listCommentVideo;

  factory ListVideoComment.fromRawJson(String str) => ListVideoComment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListVideoComment.fromJson(Map<String, dynamic> json) => ListVideoComment(
    listCommentVideo: List<VideoComment>.from(json["listCommentVideo"].map((x) => VideoComment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listCommentVideo": List<dynamic>.from(listCommentVideo.map((x) => x.toJson())),
  };
}

class VideoComment {
  VideoComment({
    required this.id,
    required this.userId,
    required this.videoId,
    required this.firstName,
    required this.lastName,
    required this.content,
    required this.time,
  });

  int id;
  int userId;
  int videoId;
  String firstName;
  String lastName;
  String content;
  DateTime time;

  factory VideoComment.fromRawJson(String str) => VideoComment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideoComment.fromJson(Map<String, dynamic> json) => VideoComment(
    id: json["id"],
    userId: json["user_id"],
    videoId: json["video_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    content: json["content"],
    time: DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "video_id": videoId,
    "first_name": firstName,
    "last_name": lastName,
    "content": content,
    "time": time.toIso8601String(),
  };
}
