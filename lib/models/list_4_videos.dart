// To parse this JSON data, do
//
//     final listvideo = listvideoFromJson(jsonString);

import 'dart:convert';

class Listvideo {
  Listvideo({
    required this.listResult,
  });

  List<ListResult> listResult;

  factory Listvideo.fromRawJson(String str) => Listvideo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Listvideo.fromJson(Map<String, dynamic> json) => Listvideo(
    listResult: List<ListResult>.from(json["listResult"].map((x) => ListResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listResult": List<dynamic>.from(listResult.map((x) => x.toJson())),
  };
}

class ListResult {
  ListResult({
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

  factory ListResult.fromRawJson(String str) => ListResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListResult.fromJson(Map<String, dynamic> json) => ListResult(
    id: json["id"],
    userId: json["user_id"],
    videoCategoryId: json["video_category_id"],
    videoTitle: json["video_title"],
    videoThumbnail: json["video_thumbnail"] == null ? "https://media.wired.com/photos/5b74a1ca8a992b7a26e92da5/master/w_2560%2Cc_limit/comeout_videos-01.jpg" :json["video_thumbnail"] ,
    videoLink: json["video_link"],
    videoDescription: json["video_description"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    timeCreated: DateTime.parse(json["time_created"]),
    isPrivate: json["is_private"],
    status: json["status"],
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
  };
}
