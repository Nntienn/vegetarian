// To parse this JSON data, do
//
//     final isLiked = isLikedFromJson(jsonString);

import 'dart:convert';

class IsLiked {
  IsLiked({
    required this.isLiked,
  });

  bool isLiked;

  factory IsLiked.fromRawJson(String str) => IsLiked.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IsLiked.fromJson(Map<String, dynamic> json) => IsLiked(
    isLiked: json["is_Liked"],
  );

  Map<String, dynamic> toJson() => {
    "is_Liked": isLiked,
  };
}
