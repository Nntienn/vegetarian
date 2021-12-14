import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/allergies_event.dart';
import 'package:vegetarian/events/weekly_menu_event.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/models/weekly_menu.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/weekly_menu_state.dart';


class WeeklyMenuBloc extends Bloc<WeeklyMenuBloc, WeeklyMenuState> {
  WeeklyMenuBloc() :super(WeeklyMenuStateInitial());

  @override
  Stream<WeeklyMenuState> mapEventToState(WeeklyMenuBloc event) async* {
    if (event is WeeklyMenuFetchEvent) {
      User? user = await getUser();
      WeeklyMenu? menu = await getWeeklyMenu();
      // WeeklyMenu? menu = await generateWeeklyMenu();
      if (menu != null) {
            print("co menu");
            yield WeeklyMenuStateSuccess(menu, false);
      }else{
        if(user!.weight == 0 || user.height == 0 || user.workoutRoutine == 0 || user.gender == ""){
          yield WeeklyMenuStateLackInfo();
        }else {
          yield WeeklyMenuStateEmpty();
        }
      }
    }
    if (event is WeeklyMenuGenerateEvent) {
      User? user = await getUser();
      // WeeklyMenu? menu = await getWeeklyMenu();
      WeeklyMenu? menu = await generateWeeklyMenu(event.number);
        print("co menu");
      if (menu != null) {
        yield WeeklyMenuStateSuccess(menu,true);
      }else{
        WeeklyMenu? menu = await getWeeklyMenu();
        if(menu == null) {
          yield WeeklyMenuStateFailure(user!);
        }else{
          yield WeeklyMenuCreateStateFailure(menu, false, event.number);
        }
      }
    }

    if(event is WeeklyMenuAddEvent){
      bool? add = await saveWeeklyMenu(event.weeklyMenu);
      if(add){
        WeeklyMenu? menu = await getWeeklyMenu();
        yield SaveWeeklyMenuStateSuccess(menu!,false);
      }
    }
    if(event is WeeklyMenuUpdateInfoEvent){
      calculateAge(DateTime birthDate) {
        DateTime currentDate = DateTime.now();
        int age = currentDate.year - birthDate.year;
        int month1 = currentDate.month;
        int month2 = birthDate.month;
        if (month2 > month1) {
          age--;
        } else if (month1 == month2) {
          int day1 = currentDate.day;
          int day2 = birthDate.day;
          if (day2 > day1) {
            age--;
          }
        }
        return age;
      }
      bool? updateDetail = await updateUserDetail(
          event.user.firstName,
          event.user.lastName,
          event.user.aboutMe,
          event.user.phoneNumber,
          event.user.country,
          event.user.facebookLink,
          event.user.instagramLink,
          event.birthDay,
          event.gender);
      bool? updateBodyIndex = await updateUserBodyIndex(
          event.height, event.weight, event.typeWorkout);
      if (updateDetail! && updateBodyIndex!) {
        User? user = await getUser();
        if(user!=null){
          int age = calculateAge(user.birthDate);

          WeeklyMenu? menu = await generateWeeklyMenu(5);
          if (menu != null) {
            yield WeeklyMenuStateSuccess(menu,false);
          }
        }
      }
    }
  }
}