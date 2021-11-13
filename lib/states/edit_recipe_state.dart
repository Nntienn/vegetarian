import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/models/recipe.dart';

class EditRecipeState {
}
class EditRecipeStateInitial extends EditRecipeState {
}
class EditRecipeStateFailure extends EditRecipeState {
}
class EditRecipeStateLoadSuccess extends EditRecipeState {
  final Recipe recipe;
  final List<Category> list ;
  final int recipeId;
  EditRecipeStateLoadSuccess(this.list, this.recipe, this.recipeId);
}
class EditRecipeStateSuccess extends EditRecipeState {
}