
import 'package:vegetarian/blocs/favorite_ingredients_bloc.dart';
import 'package:vegetarian/models/list_ingredient_name.dart';

class FavoriteIngredientsFetchEvent extends FavoriteIngredientsBloc{
}

class FavoriteIngredientsEditEvent extends FavoriteIngredientsBloc{
  final ListIngredientName list;

  FavoriteIngredientsEditEvent(this.list);

}
