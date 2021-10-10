import 'dart:convert';

class UserJson {
  UserJson({
    required this.token,
  });

  String token;

  factory UserJson.fromRawJson(String str) => UserJson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserJson.fromJson(Map<String, dynamic> json) => UserJson(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}