import 'package:vegetarian/models/user.dart';

class ForgotPasswordState {
  const ForgotPasswordState();
}

class ForgotPasswordStateInitial extends ForgotPasswordState {}
class ForgotPasswordStateMailFetchSuccess extends ForgotPasswordState {
}
class ForgotPasswordStateFetchSuccess extends ForgotPasswordState {
  final String email;

  ForgotPasswordStateFetchSuccess(this.email);
}
class ForgotPasswordStateFailure extends ForgotPasswordState {
  final String errorMessage;
  ForgotPasswordStateFailure({required this.errorMessage});
}
class ForgotPasswordMailStateFailure extends ForgotPasswordState {
  final String errorMessage;
  ForgotPasswordMailStateFailure({required this.errorMessage});
}
class ForgotPasswordStateSuccess extends ForgotPasswordState {
}
class ForgotPasswordMailStateSuccess extends ForgotPasswordState {
  final String email;

  ForgotPasswordMailStateSuccess(this.email);

}
// class ProfileUpdateSuccess extends ProfileState{}
