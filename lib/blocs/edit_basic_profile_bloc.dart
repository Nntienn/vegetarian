import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/edit_basic_profile_event.dart';
import 'package:vegetarian/events/edit_recipe_events.dart';
import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/edit_basic_profile_state.dart';
import 'package:vegetarian/states/edit_recipe_state.dart';

class EditProfileBloc extends Bloc<EditProfileBloc, EditProfileState> {
  EditProfileBloc() : super(EditProfileStateInitial());

  @override
  Stream<EditProfileState> mapEventToState(EditProfileBloc event) async* {
    if (event is EditProfileFetchEvent) {
      User? user = await getUser();
      yield EditProfileFetchStateSuccess(user: user!);
    }
    if (event is EditProfileEvent) {
      try {
        var currentState = state as EditProfileFetchStateSuccess;
        bool? updatedUser = await updateUserDetail(
            event.firstName,
            event.lastName,
            event.aboutMe,
            event.phoneNumber,
            event.country,
            event.facebookLink,
            event.instagramLink,
            event.birthdate,
            event.gender);
        if (updatedUser!) {
          User? user = await getUser();
          yield EditProfileStateSuccess(user: user!);
        } else {
          yield currentState;
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        var currentState = state as EditProfileFetchStateSuccess;
        yield currentState;
      }
    }
  }
}
