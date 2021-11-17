import 'package:vegetarian/models/user.dart';

class ForgotPasswordState {
  const ForgotPasswordState();
}

class ForgotPasswordStateInitial extends ForgotPasswordState {}
//input email
class ForgotPasswordStateMailFetchSuccess extends ForgotPasswordState {
}
class ForgotPasswordMailStateFailure extends ForgotPasswordState {
  final String errorMessage;
  ForgotPasswordMailStateFailure({required this.errorMessage});
}
class ForgotPasswordMailStateSuccess extends ForgotPasswordState {
  final String email;
  ForgotPasswordMailStateSuccess(this.email);
}
//verify
class ForgotPasswordVerifyStateFetchSuccess extends ForgotPasswordState {
  final String email;
  ForgotPasswordVerifyStateFetchSuccess(this.email);
}
class ForgotPasswordVerifyStateFailure extends ForgotPasswordState {
  final String errorMessage;
  ForgotPasswordVerifyStateFailure({required this.errorMessage});
}
class ForgotPasswordVerifyStateSuccess extends ForgotPasswordState {
  final String email;
  ForgotPasswordVerifyStateSuccess(this.email);
}
//reset password
class ForgotPasswordStateSuccess extends ForgotPasswordState {
}
class ForgotPasswordStateFetchSuccess extends ForgotPasswordState {
  final String email;
  ForgotPasswordStateFetchSuccess(this.email);
}

class ForgotPasswordStateFailure extends ForgotPasswordState {
  final String errorMessage;
  ForgotPasswordStateFailure({required this.errorMessage});
}



// class ProfileUpdateSuccess extends ProfileState{}
