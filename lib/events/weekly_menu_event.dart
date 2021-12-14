
import 'package:vegetarian/blocs/allergies_bloc.dart';
import 'package:vegetarian/blocs/weekly_menu_bloc.dart';
import 'package:vegetarian/models/list_ingredient_name.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/models/weekly_menu.dart';

class WeeklyMenuFetchEvent extends WeeklyMenuBloc{
}

class WeeklyMenuGenerateEvent extends WeeklyMenuBloc{
  final int number;

  WeeklyMenuGenerateEvent(this.number);
}
class WeeklyMenuAddEvent extends WeeklyMenuBloc{
  final WeeklyMenu weeklyMenu;
  WeeklyMenuAddEvent(this.weeklyMenu);
}
class WeeklyMenuUpdateInfoEvent extends WeeklyMenuBloc{
  final User user;
  final int height;
  final double weight;
  final int typeWorkout;
  final DateTime birthDay;
  final String gender;


  WeeklyMenuUpdateInfoEvent( this.user,this.height, this.weight, this.typeWorkout, this.birthDay, this.gender);
}

