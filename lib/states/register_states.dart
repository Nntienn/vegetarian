
class RegisterState {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? confirm;
  final bool? status;
  const RegisterState({required this.firstName, required this.lastName, required this.email, required this.password, required this.confirm, required this.status});
}

class RegisterStateInitial extends RegisterState {
  RegisterStateInitial() : super(firstName: null, lastName: null, email: null, password: null, confirm: null, status: false);
}
class RegisterStateFailure extends RegisterState {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? confirm;
  final bool? status;
  const RegisterStateFailure({required this.firstName, required this.lastName, required this.email, required this.password, required this.confirm, required this.status}) : super(firstName: firstName, lastName: lastName, email: email, password: password, confirm: confirm, status: status);
}
class RegisterStateSuccess extends RegisterState {
  RegisterStateSuccess() : super(firstName: null, lastName: null, email: null, password: null, confirm: null, status: true);
}