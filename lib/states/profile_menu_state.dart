import 'package:vegetarian/models/user.dart';

class ProfileMenuState {
  const ProfileMenuState();
}

class ProfileMenuStateInitial extends ProfileMenuState {}
class ProfileMenuStateFailure extends ProfileMenuState {}
class ProfileMenuStateSuccess extends ProfileMenuState {
  final User user;
  ProfileMenuStateSuccess({required this.user});
}