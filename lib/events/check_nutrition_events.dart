import 'package:vegetarian/blocs/check_nutrition_bloc.dart';
import 'package:vegetarian/blocs/edit_recipe_bloc.dart';
import 'package:vegetarian/models/edit_recipe.dart';
import 'package:vegetarian/models/user.dart';

class CheckNutritionEvent extends CheckNutritionBloc {
  final int height;
  final double weight;
  final int typeWorkout;
  final DateTime birthDay;
  final String gender;
  final User user;

  CheckNutritionEvent(this.user, this.height, this.weight, this.typeWorkout,
      this.birthDay, this.gender);
}

class CheckNutritionFetchEvent extends CheckNutritionBloc {}
