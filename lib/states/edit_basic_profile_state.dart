import 'package:vegetarian/models/user.dart';

class EditProfileState {
  const EditProfileState();
}

class EditProfileStateInitial extends EditProfileState {}
class EditProfileStateFailure extends EditProfileState {}
class EditProfileStateSuccess extends EditProfileState {
  final User user;
  EditProfileStateSuccess({required this.user});
}
class EditProfileFetchStateSuccess extends EditProfileState {
  final User user;
  EditProfileFetchStateSuccess({required this.user});
}
// class ProfileUpdateSuccess extends ProfileState{}
