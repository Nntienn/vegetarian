import 'package:vegetarian/models/recipes_card.dart';

class AllRecipesState {
  const AllRecipesState();
}

class AllRecipesStateInitial extends AllRecipesState {
}
class AllRecipesStateFailure extends AllRecipesState {}
class AllRecipesStateSuccess extends AllRecipesState {
  final List<RecipesCard> recipes;
  AllRecipesStateSuccess(this.recipes);
}