
import 'package:vegetarian/blocs/edit_recipe_bloc.dart';
import 'package:vegetarian/models/edit_recipe.dart';


class EditRecipeEvent extends EditRecipeBloc{
  final int recipeID;
  final EditRecipe editRecipe;
  EditRecipeEvent(this.editRecipe, this.recipeID);
}
class EditRecipeFetchEvent extends EditRecipeBloc{
  final int recipeID;
  EditRecipeFetchEvent(this.recipeID);
}