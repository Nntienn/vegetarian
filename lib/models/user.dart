// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

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
    required this.role,
    required this.isActive,
    required this.height,
    required this.weight,
    required this.workoutRoutine,
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
  String instagramLink;
  DateTime birthDate;
  String gender;
  String role;
  bool isActive;
  int height;
  double weight;
  int workoutRoutine;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        aboutMe: json["about_me"] == null ? "" : json["about_me"],
        phoneNumber: json["phone_number"] == null ? "" : json["phone_number"],
        profileImage:
            json["profile_image"] == null ? "" : json["profile_image"],
        country: json["country"] == null ? "" : json["country"],
        facebookLink:
            json["facebook_link"] == null ? "" : json["facebook_link"],
        instagramLink:
            json["instagram_link"] == null ? "" : json["instagram_link"],
        birthDate: DateTime.parse(json["birth_date"] == null
            ? DateFormat('yyyy-MM-dd').format(DateTime.now())
            : json["birth_date"]),
        gender: json["gender"] == null ? "" : json["gender"],
        role: json["role"],
        isActive: json["is_active"],
        height: json["height"],
        weight: json["weight"].toDouble(),
        workoutRoutine: json["workout_routine"],
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
        "birth_date":
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "role": role,
        "is_active": isActive,
        "height": height,
        "weight": weight,
        "workout_routine": workoutRoutine,
      };
}
