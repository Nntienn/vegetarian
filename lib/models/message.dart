// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

class Message {
  Message({
    required this.message,
  });

  String message;

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
