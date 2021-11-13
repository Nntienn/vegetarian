import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/user.dart';

class CheckNutritionState {
}
class CheckNutritionStateInitial extends CheckNutritionState {
}
class CheckNutritionStateFailure extends CheckNutritionState {
}
class CheckNutritionStateSuccess extends CheckNutritionState {
  final User user;
  final Nutrition nutri;
  CheckNutritionStateSuccess(this.nutri, this.user);
}
class CheckNutritionStateFetchSuccess extends CheckNutritionState {
  final User user;
  CheckNutritionStateFetchSuccess(this.user);
}