import 'package:vegetarian/models/user.dart';

class ProfileMenuState {
  const ProfileMenuState();
}

class ProfileMenuStateInitial extends ProfileMenuState {}
class ProfileMenuStateFailure extends ProfileMenuState {}
class ProfileMenuStateSuccess extends ProfileMenuState {
  final List<String> path;
  final User user;
  final int lastPageid;
  ProfileMenuStateSuccess(this.path, this.lastPageid, {required this.user});
}