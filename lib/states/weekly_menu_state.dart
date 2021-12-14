import 'package:vegetarian/models/list_ingredient_name.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/models/weekly_menu.dart';

class WeeklyMenuState {
  const WeeklyMenuState();
}

class WeeklyMenuStateInitial extends WeeklyMenuState {}

class WeeklyMenuStateEmpty extends WeeklyMenuState {}
class WeeklyMenuStateLackInfo extends WeeklyMenuState {}
class WeeklyMenuStateFailure extends WeeklyMenuState {
  final User user;
  WeeklyMenuStateFailure(this.user);
}
class WeeklyMenuCreateStateFailure extends WeeklyMenuState {
  final WeeklyMenu weeklyMenu;
  final bool isNew;
  final int number;
  WeeklyMenuCreateStateFailure(this.weeklyMenu, this.isNew, this.number);

}
class WeeklyMenuStateSuccess extends WeeklyMenuState {
  final WeeklyMenu weeklyMenu;
  final bool isNew;
  WeeklyMenuStateSuccess(this.weeklyMenu, this.isNew);
}

class SaveWeeklyMenuStateSuccess extends WeeklyMenuState {
  final WeeklyMenu weeklyMenu;
  final bool isNew;

  SaveWeeklyMenuStateSuccess(this.weeklyMenu, this.isNew);
}
