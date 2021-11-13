import 'package:vegetarian/models/list_ingredient_name.dart';


class AllergiesState {
  const AllergiesState();
}

class AllergiesStateInitial extends AllergiesState {
}
class AllergiesStateFailure extends AllergiesState {}
class AllergiesStateSuccess extends AllergiesState {
  final ListIngredientName list;
  AllergiesStateSuccess(this.list);
}