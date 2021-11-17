// To parse this JSON data, do
//
//     final uploadv = uploadvFromJson(jsonString);

import 'dart:convert';

class UploadVideo {
  UploadVideo({
    required this.userId,
    required this.videoCategoryId,
    required this.videoTitle,
    required this.videoLink,
    required this.videoDescription,
    required this.videoThumbnail,
  });

  int userId;
  int videoCategoryId;
  String videoTitle;
  String videoLink;
  String videoDescription;
  String videoThumbnail;

  factory UploadVideo.fromRawJson(String str) =>
      UploadVideo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UploadVideo.fromJson(Map<String, dynamic> json) => UploadVideo(
        userId: json["user_id"],
        videoCategoryId: json["video_category_id"],
        videoTitle: json["video_title"],
        videoLink: json["video_link"],
        videoDescription: json["video_description"],
        videoThumbnail: json["video_thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "video_category_id": videoCategoryId,
        "video_title": videoTitle,
        "video_link": videoLink,
        "video_description": videoDescription,
        "video_thumbnail": videoThumbnail,
      };
}
