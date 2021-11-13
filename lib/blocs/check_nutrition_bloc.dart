import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/check_nutrition_events.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/check_nutrition_state.dart';
import 'package:vegetarian/states/edit_recipe_state.dart';

class CheckNutritionBloc extends Bloc<CheckNutritionBloc, CheckNutritionState> {
  CheckNutritionBloc() : super(CheckNutritionState());

  @override
  Stream<CheckNutritionState> mapEventToState(CheckNutritionBloc event) async* {
    if (event is CheckNutritionFetchEvent) {
      User? user = await getUser();
      yield CheckNutritionStateFetchSuccess(user!);
    }
    if (event is CheckNutritionEvent) {

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
          Nutrition? nutri =
          await getUserDailyNutrition(user.height,user.weight , user.workoutRoutine, age, user.gender);

          if (nutri != null) {
            yield CheckNutritionStateSuccess(nutri, user);
            print(nutri.protein.toString() +'nutri ne');
          } else {
            yield CheckNutritionStateFailure();
          }
        }
      }

    }
  }
}
