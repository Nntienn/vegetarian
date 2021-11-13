import 'package:vegetarian/blocs/change_password_bloc.dart';
import 'package:vegetarian/blocs/edit_basic_profile_bloc.dart';
import 'package:vegetarian/blocs/edit_body_bloc.dart';
import 'package:vegetarian/blocs/edit_recipe_bloc.dart';
import 'package:vegetarian/models/edit_recipe.dart';

class ChangePasswordEvent extends ChangePasswordBloc {
  final String oldPassword;
  final String newPassword;
  final String confirmnewPassword;

  ChangePasswordEvent(this.oldPassword, this.newPassword, this.confirmnewPassword);


}

class ChangePasswordFetchEvent extends ChangePasswordBloc {}
