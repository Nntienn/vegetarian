class LoginState {
  const LoginState();
}

class LoginStateInitial extends LoginState {
  // final String UserName;
  // final String Password;
  // LoginStateInitial(this.UserName, this.Password);
}
class LoginStateFailure extends LoginState {
  final String errorMessage;
  LoginStateFailure({required this.errorMessage});
}
class LoginStateSuccess extends LoginState {
  // final String firstName;
  // final String lastName;
  // LoginStateSuccess({required this.firstName, required this.lastName});
}
class LoginEmptyState extends LoginState{}
