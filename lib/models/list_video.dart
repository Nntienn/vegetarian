// To parse this JSON data, do
//
//     final listVideos = listVideosFromJson(jsonString);

import 'dart:convert';

import 'package:vegetarian/models/video.dart';

class ListVideos {
  ListVideos({
    required this.page,
    required this.totalPage,
    required this.listResult,
  });

  int page;
  int totalPage;
  List<Video> listResult;

  factory ListVideos.fromRawJson(String str) => ListVideos.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListVideos.fromJson(Map<String, dynamic> json) => ListVideos(
    page: json["page"],
    totalPage: json["totalPage"],
    listResult: List<Video>.from(json["listResult"].map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "totalPage": totalPage,
    "listResult": List<dynamic>.from(listResult.map((x) => x.toJson())),
  };
}

