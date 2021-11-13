import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/edit_basic_profile_event.dart';
import 'package:vegetarian/events/edit_body_event.dart';
import 'package:vegetarian/events/edit_recipe_events.dart';
import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/edit_basic_profile_state.dart';
import 'package:vegetarian/states/edit_body_state.dart';
import 'package:vegetarian/states/edit_recipe_state.dart';

class EditBodyBloc extends Bloc<EditBodyBloc, EditBodyState> {
  EditBodyBloc() : super(EditBodyStateInitial());

  @override
  Stream<EditBodyState> mapEventToState(EditBodyBloc event) async* {
    if (event is EditBodyFetchEvent) {
      User? user = await getUser();
      yield EditBodyStateFetchSuccess(user: user!);
    }
    if (event is EditBodyEvent) {
      try {
        var currentState = state as EditBodyStateFetchSuccess;
        bool? updateBodyIndex = await updateUserBodyIndex(
            event.height, event.weight, event.typeWorkout);
        if (updateBodyIndex!) {
          User? user = await getUser();
          yield EditBodyStateSuccess(user: user!);
        } else {
          yield currentState;
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        var currentState = state as EditBodyStateFetchSuccess;
        yield currentState;
      }
    }
  }
}
