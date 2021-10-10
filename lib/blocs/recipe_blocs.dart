import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/models/comment.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/recipes_state.dart';

class RecipeBloc extends Bloc<RecipeBloc, RecipeState> {
  RecipeBloc() : super(RecipeStateInitial());

  @override
  Stream<RecipeState> mapEventToState(RecipeBloc event) async* {
    if (event is RecipeFetchEvent) {
      String? token = await LocalData().getToken();
      print(token);
      if (token != null) {
        Map<String?, dynamic> payload = Jwt.parseJwt(token);
        int id = payload['id'];
        int recipeID = event.recipeID;
        Recipe? recipe = await getRecipebyID(recipeID);
        List<Comment> comments = await getRecipeComments(recipeID);
        if (recipe != null) {
          yield RecipeStateSuccess(recipe, comments, id);
        }
      }
    }
    if(event is RecipeCommentEvent){
      bool comment = await commentRecipe(event.recipeId, event.comment);
      if(comment){
        String? token = await LocalData().getToken();
        Map<String?, dynamic> payload = Jwt.parseJwt(token!);
        int id = payload['id'];
        int recipeID = event.recipeId;
        Recipe? recipe = await getRecipebyID(recipeID);
        List<Comment> comments = await getRecipeComments(recipeID);
        yield RecipeStateSuccess(recipe!, comments, id);
      }
    }
  }
}
