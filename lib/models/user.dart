import 'dart:convert';

// To parse this JSON data, do
//
//     final allRecipes = allRecipesFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.aboutMe,
    required this.phoneNumber,
    required this.profileImage,
    required this.country,
    required this.facebookLink,
    required this.instagramLink,
    required this.birthDate,
    required this.gender,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String aboutMe;
  String phoneNumber;
  String profileImage;
  String country;
  String facebookLink;
  dynamic instagramLink;
  DateTime birthDate;
  String gender;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    aboutMe: json["about_me"],
    phoneNumber: json["phone_number"],
    profileImage: json["profile_image"],
    country: json["country"],
    facebookLink: json["facebook_link"],
    instagramLink: json["instagram_link"],
    birthDate: DateTime.parse(json["birth_date"]) as DateTime,
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "about_me": aboutMe,
    "phone_number": phoneNumber,
    "profile_image": profileImage,
    "country": country,
    "facebook_link": facebookLink,
    "instagram_link": instagramLink,
    "birth_date": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
    "gender": gender,
  };
}



class Role {
  Role({
    required this.authority,
  });

  String authority;

  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    authority: json["authority"] == null ? null : json["authority"],
  );

  Map<String, dynamic> toJson() => {
    "authority": authority == null ? null : authority,
  };
}
