import 'dart:io';

import 'package:vegetarian/blocs/profile_blocs.dart';
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/models/user.dart';


class ProfileMenuFetchEvent extends ProfileMenuBloc{}

class ProfileMenuUpdateEvent extends ProfileMenuBloc{
  final User user;
  ProfileMenuUpdateEvent({required this.user});
}

class ProfileMenuUpdateImageEvent extends ProfileMenuBloc{
  final String image;
  ProfileMenuUpdateImageEvent({required this.image});
}

class ProfileMenuUpdateLegalEvent extends ProfileMenuBloc{
  final String address;
  final String bloodType;
  final String dob;
  ProfileMenuUpdateLegalEvent({required this.address, required this.bloodType, required this.dob});
}

class ProfileMenuUpdateBodyEvent extends ProfileMenuBloc{
  final String height;
  final String weight;
  final String eyesight;
  ProfileMenuUpdateBodyEvent({required this.height, required this.weight, required this.eyesight});
}

class ProfileMenuUpdateMedicalEvent extends ProfileMenuBloc{
  final String diseaseList;
  final String surgeryList;
  final String allergyList;
  ProfileMenuUpdateMedicalEvent({required this.diseaseList, required this.surgeryList, required this.allergyList});
}