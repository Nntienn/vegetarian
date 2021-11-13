import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/change_password_event.dart';
import 'package:vegetarian/events/edit_basic_profile_event.dart';
import 'package:vegetarian/events/edit_body_event.dart';
import 'package:vegetarian/events/edit_recipe_events.dart';
import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/change_password_state.dart';
import 'package:vegetarian/states/edit_basic_profile_state.dart';
import 'package:vegetarian/states/edit_body_state.dart';
import 'package:vegetarian/states/edit_recipe_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordBloc, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordStateInitial());

  @override
  Stream<ChangePasswordState> mapEventToState(ChangePasswordBloc event) async* {
    if (event is ChangePasswordFetchEvent) {
      yield ChangePasswordStateFetchSuccess();
    }
    if (event is ChangePasswordEvent) {
      try {
        if(event.newPassword != event.confirmnewPassword){
          yield ChangePasswordStateFailure(errorMessage: "Confirm password doesn't match new password");
        }else{
          bool? changepassword = await updateUserPassword(
              event.oldPassword,event.newPassword);
          if (changepassword!) {
            yield ChangePasswordStateSuccess();
          } else {
            yield ChangePasswordStateFailure(errorMessage: "Wrong old password");
          }
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield ChangePasswordStateFailure(errorMessage: "System Error");
      }
    }
  }
}
