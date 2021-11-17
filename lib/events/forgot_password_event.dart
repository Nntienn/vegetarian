import 'package:vegetarian/blocs/change_password_bloc.dart';
import 'package:vegetarian/blocs/edit_basic_profile_bloc.dart';
import 'package:vegetarian/blocs/edit_body_bloc.dart';
import 'package:vegetarian/blocs/edit_recipe_bloc.dart';
import 'package:vegetarian/blocs/forgot_password_bloc.dart';
import 'package:vegetarian/models/edit_recipe.dart';

class ForgotPasswordResetEvent extends ForgotPasswordBloc {
  final String email;
  final String newPassword;
  final String confirmnewPassword;

  ForgotPasswordResetEvent(
       this.newPassword, this.confirmnewPassword, this.email);
}
class ForgotPasswordFetchEvent extends ForgotPasswordBloc {
  final String mail;
  ForgotPasswordFetchEvent(this.mail);
}
class ForgotPasswordConfirmFetchEvent extends ForgotPasswordBloc {
  final String mail;
  ForgotPasswordConfirmFetchEvent(this.mail);
}
class ForgotPasswordResendCodeEvent extends ForgotPasswordBloc {
  final String mail;

  ForgotPasswordResendCodeEvent(this.mail);
}
class ForgotPasswordInputMailEvent extends ForgotPasswordBloc {
  final String mail;

  ForgotPasswordInputMailEvent(this.mail);
}
class ForgotPasswordVerifyEvent extends ForgotPasswordBloc {
  final String mail;
  final String code;
  ForgotPasswordVerifyEvent(this.mail, this.code);
}
