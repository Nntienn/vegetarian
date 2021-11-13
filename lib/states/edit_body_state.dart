import 'package:vegetarian/models/user.dart';

class EditBodyState {
  const EditBodyState();
}

class EditBodyStateInitial extends EditBodyState {}
class EditBodyStateFailure extends EditBodyState {}
class EditBodyStateFetchSuccess extends EditBodyState {
  final User user;
  EditBodyStateFetchSuccess({required this.user});
}
class EditBodyStateSuccess extends EditBodyState {
  final User user;
  EditBodyStateSuccess({required this.user});
}
// class ProfileUpdateSuccess extends ProfileState{}
