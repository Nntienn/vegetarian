import 'package:vegetarian/models/list_ingredient_name.dart';
import 'package:vegetarian/models/weekly_menu.dart';


class UserWeeklyMenuState {
  const UserWeeklyMenuState();
}

class UserWeeklyMenuStateInitial extends UserWeeklyMenuState {
}
class UserWeeklyMenuStateFailure extends UserWeeklyMenuState {}
class UserWeeklyMenuStateSuccess extends UserWeeklyMenuState {
  final WeeklyMenu weeklyMenu;
  UserWeeklyMenuStateSuccess(this.weeklyMenu);
}
