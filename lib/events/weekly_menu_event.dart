
import 'package:vegetarian/blocs/allergies_bloc.dart';
import 'package:vegetarian/blocs/weekly_menu_bloc.dart';
import 'package:vegetarian/models/list_ingredient_name.dart';
import 'package:vegetarian/models/weekly_menu.dart';

class WeeklyMenuFetchEvent extends WeeklyMenuBloc{
}

class WeeklyMenuAddEvent extends WeeklyMenuBloc{
  final WeeklyMenu weeklyMenu;

  WeeklyMenuAddEvent(this.weeklyMenu);

}
