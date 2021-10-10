import 'package:vegetarian/blocs/create_recipe_bloc.dart';
import 'package:vegetarian/models/create_recipe.dart';


class CreateRecipeEvent extends CreateRecipeBloc{

  final CreateRecipe createRecipe;

  CreateRecipeEvent(this.createRecipe);
}
class CreateRecipeFetchEvent extends CreateRecipeBloc{
}