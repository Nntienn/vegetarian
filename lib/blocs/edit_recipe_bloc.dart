import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/edit_recipe_events.dart';
import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/states/edit_recipe_state.dart';

class EditRecipeBloc extends Bloc<EditRecipeBloc, EditRecipeState> {
  EditRecipeBloc():super(EditRecipeStateInitial());

  @override
  Stream<EditRecipeState> mapEventToState(EditRecipeBloc event) async* {
    if(event is EditRecipeFetchEvent){
      List<Category> list = await getCategory();
      Recipe? recipe = await getRecipebyID(event.recipeID);
      yield EditRecipeStateLoadSuccess(list, recipe!, event.recipeID);
    }
    if(event is EditRecipeEvent){
      bool result = await editRecipe(event.editRecipe, event.recipeID);
      if(result){
        yield EditRecipeStateSuccess();
      }else{
        yield EditRecipeStateFailure();
      }
    }
  }
}
