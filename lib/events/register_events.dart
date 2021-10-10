

import 'package:vegetarian/blocs/register_blocs.dart';

class RegisterEvent extends RegisterBloc{
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirm;
  RegisterEvent({required this.firstName, required this.lastName, required this.email, required this.password, required this.confirm});
}

class RegisterOnSubmitfirstNameEvent extends RegisterBloc{
  final String firstName;
  RegisterOnSubmitfirstNameEvent({required this.firstName});
}

class RegisterOnSubmitlastNameEvent extends RegisterBloc{
  final String lastName;
  RegisterOnSubmitlastNameEvent({required this.lastName});
}

class RegisterOnSubmitEmailEvent extends RegisterBloc{
  final String email;
  RegisterOnSubmitEmailEvent({required this.email});
}

class RegisterOnSubmitPasswordEvent extends RegisterBloc{
  final String password;
  RegisterOnSubmitPasswordEvent({required this.password});
}

class RegisterOnSubmitConfirmEvent extends RegisterBloc{
  final String password;
  final String confirm;
  RegisterOnSubmitConfirmEvent({required this.password, required this.confirm});
}