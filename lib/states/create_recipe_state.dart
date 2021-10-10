import 'package:vegetarian/models/category.dart';

class CreateRecipeState {
}
class CreateRecipeStateInitial extends CreateRecipeState {
}
class CreateRecipeStateFailure extends CreateRecipeState {
}
class CreateRecipeStateLoadSuccess extends CreateRecipeState {
  final List<Category> list ;
  CreateRecipeStateLoadSuccess(this.list);
}
class CreateRecipeStateSuccess extends CreateRecipeState {
}