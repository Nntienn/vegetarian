import 'dart:io';

import 'package:vegetarian/blocs/profile_blocs.dart';
import 'package:vegetarian/models/user.dart';

class ProfileFetchEvent extends ProfileBloc {}

class ProfileUpdateEvent extends ProfileBloc {
  final String email;
  final int id;
  final String firstName;
  final String lastName;
  final String aboutMe;
  final String phoneNumber;
  final String profileImage;
  final String country;
  final String facebookLink;
  final String instagramLink;
  final String birthdate;
  final String gender;

  ProfileUpdateEvent(this.aboutMe,
  this.phoneNumber,
  this.profileImage,
  this.country,
  this.facebookLink,
  this.instagramLink,
  this.birthdate,
  this.gender,
      {required this.email,
      required this.id,
      required this.firstName,
      required this.lastName,
       });
}
