import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/models/comment.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/user.dart';
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
        print(recipeID);
        Recipe? recipe = await getRecipebyID(recipeID);
        User? author = await getUserbyID(recipe!.userId);
        User? user = await getUserbyID(id);
        List<Comment> comments = await getRecipeComments(recipeID);
        bool isLiked = await checkLike(recipeID);
        List<String>? path = await LocalData().getPath();
        if(path == null){
          path = [];
        }
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        path.add(event.lastPage);
        print(path);
        await LocalData().savePath(path);
        if (recipe != null) {
          yield RecipeStateSuccess(
              recipe, comments, user == null ? null :user, isLiked, author!, path,commentImage);
        }
      }else{
        int recipeID = event.recipeID;
        print(recipeID);
        Recipe? recipe = await getRecipebyID(recipeID);
        User? author = await getUserbyID(recipe!.userId);
        List<Comment> comments = await getRecipeComments(recipeID);
        bool isLiked = await checkLike(recipeID);
        List<String>? path = await LocalData().getPath();
        if(path == null){
          path = [];
        }
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        path.add(event.lastPage);
        print(path);
        await LocalData().savePath(path);
        if (recipe != null) {
          yield RecipeStateSuccess(
              recipe, comments, null, isLiked, author!, path,commentImage);
        }
      }
    }
    if (event is RecipeCommentEvent) {
      bool comment = await commentRecipe(event.recipeId, event.comment);
      if (comment) {
        String? token = await LocalData().getToken();
        Map<String?, dynamic> payload = Jwt.parseJwt(token!);
        int id = payload['id'];
        int recipeID = event.recipeId;
        Recipe? recipe = await getRecipebyID(recipeID);
        User? author = await getUserbyID(recipe!.userId);
        User? user = await getUserbyID(id);
        List<Comment> comments = await getRecipeComments(recipeID);
        bool isLiked = await checkLike(recipeID);
        List<String>? path = await LocalData().getPath();
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        yield RecipeStateSuccess(recipe, comments, user, isLiked, author!, path!,commentImage);
      }
    }
    if (event is EditRecipeCommentEvent) {
      bool? result = await editComment(event.comment, event.commentId);
      if (result) {
        String? token = await LocalData().getToken();
        Map<String?, dynamic> payload = Jwt.parseJwt(token!);
        int id = payload['id'];
        int recipeID = event.recipeId;
        Recipe? recipe = await getRecipebyID(recipeID);
        User? author = await getUserbyID(recipe!.userId);
        User? user = await getUserbyID(id);
        List<Comment> comments = await getRecipeComments(recipeID);
        bool isLiked = await checkLike(recipeID);
        List<String>? path = await LocalData().getPath();
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        yield RecipeStateSuccess(recipe, comments, user == null ? null :user, isLiked, author!, path!, commentImage);
      }
    }

    if (event is RecipeLikeEvent) {
      bool like = await likeRecipes(event.recipeID);
      if (like) {
        String? token = await LocalData().getToken();
        Map<String?, dynamic> payload = Jwt.parseJwt(token!);
        int id = payload['id'];
        int recipeID = event.recipeID;
        Recipe? recipe = await getRecipebyID(recipeID);
        User? author = await getUserbyID(recipe!.userId);
        User? user = await getUserbyID(id);
        List<Comment> comments = await getRecipeComments(recipeID);
        bool isLiked = await checkLike(recipeID);
        List<String>? path = await LocalData().getPath();
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        yield RecipeStateSuccess(recipe, comments, user == null ? null :user, isLiked, author!, path!,commentImage);
      }
    }

    if (event is RecipeDeleteCommentEvent) {
      bool delete = await deleteComment(event.commentId);
      if (delete) {
        String? token = await LocalData().getToken();
        Map<String?, dynamic> payload = Jwt.parseJwt(token!);
        int id = payload['id'];
        int recipeID = event.recipeId;
        Recipe? recipe = await getRecipebyID(recipeID);
        User? author = await getUserbyID(recipe!.userId);
        User? user = await getUserbyID(id);
        List<Comment> comments = await getRecipeComments(recipeID);
        bool isLiked = await checkLike(recipeID);
        List<String>? path = await LocalData().getPath();
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        yield RecipeStateSuccess(recipe, comments, user == null ? null :user, isLiked, author!, path!, commentImage);
      }
    }
    if (event is RecipeprivateEvent) {
      bool delete = await privateRecipes(event.recipeId);
      if (delete) {
        String? token = await LocalData().getToken();
        Map<String?, dynamic> payload = Jwt.parseJwt(token!);
        int id = payload['id'];
        int recipeID = event.recipeId;
        Recipe? recipe = await getRecipebyID(recipeID);
        User? author = await getUserbyID(recipe!.userId);
        User? user = await getUserbyID(id);
        List<Comment> comments = await getRecipeComments(recipeID);
        bool isLiked = await checkLike(recipeID);
        List<String>? path = await LocalData().getPath();
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        yield RecipeStateSuccess(recipe, comments, user == null ? null :user, isLiked, author!, path!, commentImage);
      }
    }
  }
}
