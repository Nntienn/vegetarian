import 'package:vegetarian/models/user.dart';

class ProfileState {
  const ProfileState();
}

class ProfileStateInitial extends ProfileState {}
class ProfileStateFailure extends ProfileState {}
class ProfileStateSuccess extends ProfileState {
  final User user;
  ProfileStateSuccess({required this.user});
}
// class ProfileUpdateSuccess extends ProfileState{}
