import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/create_recipe_events.dart';
import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/states/create_recipe_state.dart';

class CreateRecipeBloc extends Bloc<CreateRecipeBloc, CreateRecipeState> {
  CreateRecipeBloc():super(CreateRecipeStateInitial());

  @override
  Stream<CreateRecipeState> mapEventToState(CreateRecipeBloc event) async* {
    if(event is CreateRecipeFetchEvent){
      List<Category> list = await getCategory();
      List<String> listCategory = [];
      // if(list!=null){
      //   for(int i = 0; i< list.length; i++){
      //     listCategory.add(list[i].categoryId.toString() + ' ' + list[i].categoryName);
      //   }
      //   print(listCategory.length);
        yield CreateRecipeStateLoadSuccess(list);
      }
    if(event is CreateRecipeEvent){
      bool create = await createRecipe(event.createRecipe);
      if(create){
        yield CreateRecipeStateSuccess();
      }else{
        yield CreateRecipeStateFailure();
      }
    }
    }
  }
