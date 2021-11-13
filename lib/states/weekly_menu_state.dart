import 'package:vegetarian/models/list_ingredient_name.dart';
import 'package:vegetarian/models/weekly_menu.dart';


class WeeklyMenuState {
  const WeeklyMenuState();
}

class WeeklyMenuStateInitial extends WeeklyMenuState {
}
class WeeklyMenuStateFailure extends WeeklyMenuState {}
class WeeklyMenuStateSuccess extends WeeklyMenuState {
  final WeeklyMenu weeklyMenu;
  WeeklyMenuStateSuccess(this.weeklyMenu);
}

class SaveWeeklyMenuStateSuccess extends WeeklyMenuState {
}