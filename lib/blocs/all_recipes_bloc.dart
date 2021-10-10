import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/all_recipes_events.dart';
import 'package:vegetarian/models/recipes_card.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/states/all_recipes_state.dart';

class AllRecipesBloc extends Bloc<AllRecipesBloc, AllRecipesState> {
  AllRecipesBloc() :super(AllRecipesStateInitial());

  @override
  Stream<AllRecipesState> mapEventToState(AllRecipesBloc event) async* {
    if (event is AllRecipesFetchEvent) {
      String? token = await LocalData().getToken();
      List<RecipesCard> tenRecipes = await getallRecipes();
      if (token != null) {
        yield AllRecipesStateSuccess(tenRecipes);
      }
    }
  }
}