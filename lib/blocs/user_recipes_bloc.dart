import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/events/user_recipes_events.dart';
import 'package:vegetarian/models/recipes_card.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/states/user_recipes_state.dart';

class UserRecipesBloc extends Bloc<UserRecipesBloc, UserRecipeState> {
  UserRecipesBloc() :super(UserRecipeStateInitial());

  @override
  Stream<UserRecipeState> mapEventToState(UserRecipesBloc event) async* {
    if (event is UserRecipesFetchEvent) {
      String? token = await LocalData().getToken();

      List<RecipesCard> tenRecipes = await getRecipesbyUserID();
      if (token != null) {
        yield UserRecipeStateSuccess(tenRecipes, );
      }
    }
    if (event is SetPrivateEvent) {
      String? token = await LocalData().getToken();
      Map<String?, dynamic> payload = Jwt.parseJwt(token!);
      int userId = payload['id'];
      bool like = await privateRecipes(event.recipeID);
      if (like) {
        yield UserRecipeDeleteStateSuccess(userId);
      }
    }
    if(event is UserRecipesDeleteEvent){
      String? token = await LocalData().getToken();
      Map<String?, dynamic> payload = Jwt.parseJwt(token!);
      int userId = payload['id'];
      bool delete = await deleteRecipe(event.recipeId);
      if(delete){
        yield UserRecipeDeleteStateSuccess(userId);
      }
    }
  }
}