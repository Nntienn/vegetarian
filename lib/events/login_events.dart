
import 'package:vegetarian/blocs/login_blocs.dart';

class LoginFetchEvent extends LoginBloc {}

class LoginEvent extends LoginBloc {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}
class LoginWithGoogleEvent extends LoginBloc{
}