import 'dart:convert';
import 'dart:io';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/models/comment.dart';
import 'package:vegetarian/models/create_recipe.dart';
import 'package:vegetarian/models/ingredient.dart';
import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/models/list_categories.dart';
import 'package:vegetarian/models/list_comments.dart';
import 'package:vegetarian/models/list_recipes.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/recipes_card.dart';
import 'package:http/http.dart' as http;
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/repositories/local_data.dart';

Future<List<RecipesCard>> get10Recipes() async {
  try {
    final response = await http.get(Uri.parse('$GET_10_RECIPES_FROM_API'));
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListRecipes.fromJson(parse);
      return list.listResult;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print(exception.toString());
    return List.empty();
  }
}

Future<List<RecipesCard>> get5bestRecipes() async {
  try {
    final response = await http.get(Uri.parse('$GET_5_BEST_RECIPES_FROM_API'));
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListRecipes.fromJson(parse);
      return list.listResult;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print(exception.toString());
    return List.empty();
  }
}

Future<Recipe?> getRecipebyID(int id) async {
  try {
    final response = await http.get(Uri.parse('$GET_RECIPE_BY_ID$id'));
    Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
    final recipe = Recipe.fromJson(parse);
    return recipe;
  } catch (exeption) {}
}

Future<List<RecipesCard>> getRecipesbyUserID(int id) async {
  try {
    final response = await http
        .get(Uri.parse('$GET_USER_RECIPES_FROM_API$id?page=1&limit=10'));
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListRecipes.fromJson(parse);
      return list.listResult;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print(exception.toString());
    return List.empty();
  }
}

Future<List<RecipesCard>> getallRecipes() async {
  try {
    final response =
        await http.get(Uri.parse('$GET_ALL_RECIPES?page=1&limit=100'));
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListRecipes.fromJson(parse);
      return list.listResult;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print(exception.toString());
    return List.empty();
  }
}

Future<List<Category>> getCategory() async {
  try {
    final response = await http.get(Uri.parse('$GET_CATEGORY'));
    print(response.statusCode.toString() + 'cho nay ne');
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListCategories.fromJson(parse);
      print(list.listResult[0].categoryName);
      return list.listResult;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print(exception.toString());
    return List.empty();
  }
}

Future<bool> createRecipe(
    CreateRecipe createRecipe
    ) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    createRecipe.userId = uid;
    final response = await http.post(Uri.parse('$CREATE_RECIPE'),
        body: json.encode(createRecipe.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    print('Create Recipe error: ' + exception.toString());
    return false;
  }
}
Future<bool> deleteRecipe(
    int recipeID
    ) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    token = 'Bearer ' + token;
    final response = await http.delete(Uri.parse('$DELETE_RECIPE$recipeID'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    print('Delete Recipe error: ' + exception.toString());
    return false;
  }
  return false;
}

Future<List<Comment>> getRecipeComments(int recipeid) async {
  try {
    final response = await http.get(Uri.parse('$RECIPE_COMMENT$recipeid/comments'));
    print('$RECIPE_COMMENT$recipeid/comments');
    print(response.statusCode.toString() + 'lay comments');
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListComment.fromJson(parse);
      print(list.listResult[0].content);
      return list.listResult;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print(exception.toString());
    return List.empty();
  }
}
