
import 'package:vegetarian/blocs/allergies_bloc.dart';
import 'package:vegetarian/models/list_ingredient_name.dart';

class AllergiesFetchEvent extends AllergiesBloc{
}

class AllergiesEditEvent extends AllergiesBloc{
  final ListIngredientName list;

  AllergiesEditEvent(this.list);

}
