import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/allergies_event.dart';
import 'package:vegetarian/events/weekly_menu_event.dart';
import 'package:vegetarian/models/weekly_menu.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/weekly_menu_state.dart';


class WeeklyMenuBloc extends Bloc<WeeklyMenuBloc, WeeklyMenuState> {
  WeeklyMenuBloc() :super(WeeklyMenuStateInitial());

  @override
  Stream<WeeklyMenuState> mapEventToState(WeeklyMenuBloc event) async* {
    if (event is WeeklyMenuFetchEvent) {
      WeeklyMenu? menu = await generateWeeklyMenu();
      if (menu != null) {
        print("co menu");
        yield WeeklyMenuStateSuccess(menu);
      }
    }
    if(event is WeeklyMenuAddEvent){
      bool? add = await saveWeeklyMenu(event.weeklyMenu);
      if(add){
        yield SaveWeeklyMenuStateSuccess();
      }
    }
  }
}