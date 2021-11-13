import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/allergies_event.dart';
import 'package:vegetarian/events/user_weekly_menu_event.dart';
import 'package:vegetarian/events/weekly_menu_event.dart';
import 'package:vegetarian/models/weekly_menu.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/user_weekly_menu_state.dart';
import 'package:vegetarian/states/weekly_menu_state.dart';


class UserWeeklyMenuBloc extends Bloc<UserWeeklyMenuBloc, UserWeeklyMenuState> {
  UserWeeklyMenuBloc() :super(UserWeeklyMenuStateInitial());

  @override
  Stream<UserWeeklyMenuState> mapEventToState(UserWeeklyMenuBloc event) async* {
    if (event is UserWeeklyMenuFetchEvent) {
      WeeklyMenu? menu = await getWeeklyMenu();
      if (menu != null) {
        print("co menu");
        yield UserWeeklyMenuStateSuccess(menu);
      }
    }
  }
}