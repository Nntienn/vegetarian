import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/favorite_ingredients_event.dart';
import 'package:vegetarian/models/list_ingredient_name.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/favorite_ingredients_state.dart';

class FavoriteIngredientsBloc extends Bloc<FavoriteIngredientsBloc, FavoriteIngredientsState> {
  FavoriteIngredientsBloc() :super(FavoriteIngredientsStateInitial());

  @override
  Stream<FavoriteIngredientsState> mapEventToState(FavoriteIngredientsBloc event) async* {
    if (event is FavoriteIngredientsFetchEvent) {
      ListIngredientName? list =await getfavoriteIngredient();
      if (list != null) {
        yield FavoriteIngredientsStateSuccess(list);
      }
    }
    if(event is FavoriteIngredientsEditEvent){
      bool? updatelist = await updatefavoriteIngredient(event.list);
      if(updatelist){
        ListIngredientName? list =await getfavoriteIngredient();
        yield FavoriteIngredientsStateSuccess(list!);
      }
    }
  }
}