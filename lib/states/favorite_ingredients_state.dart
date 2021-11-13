import 'package:vegetarian/models/list_ingredient_name.dart';


class FavoriteIngredientsState {
  const FavoriteIngredientsState();
}

class FavoriteIngredientsStateInitial extends FavoriteIngredientsState {
}
class FavoriteIngredientsStateFailure extends FavoriteIngredientsState {}
class FavoriteIngredientsStateSuccess extends FavoriteIngredientsState {
  final ListIngredientName list;
  FavoriteIngredientsStateSuccess(this.list);
}