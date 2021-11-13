import 'package:vegetarian/models/user.dart';

class ChangePasswordState {
  const ChangePasswordState();
}

class ChangePasswordStateInitial extends ChangePasswordState {}
class ChangePasswordStateFetchSuccess extends ChangePasswordState {
}
class ChangePasswordStateFailure extends ChangePasswordState {
  final String errorMessage;
  ChangePasswordStateFailure({required this.errorMessage});
}
class ChangePasswordStateSuccess extends ChangePasswordState {
}
// class ProfileUpdateSuccess extends ProfileState{}
