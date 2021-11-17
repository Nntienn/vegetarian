import 'dart:convert';
import 'dart:io';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/models/comment.dart';
import 'package:vegetarian/models/create_recipe.dart';
import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/models/edit_recipe.dart';
import 'package:vegetarian/models/list_categories.dart';
import 'package:vegetarian/models/list_comments.dart';
import 'package:vegetarian/models/list_recipes.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/recipes_card.dart';
import 'package:http/http.dart' as http;
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/models/recommend_recipes.dart';
import 'package:vegetarian/repositories/local_data.dart';

Future<List<RecipesCard>> get10Recipes() async {
  try {
    String? token = await LocalData().getToken();
    int uid;
    if(token!=null){
      Map<String?, dynamic> payload = Jwt.parseJwt(token);
      int uid = payload['id'];
      var request = http.Request('GET', Uri.parse('$GET_10_RECIPES_FROM_API?userID=$uid'));
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        Map<String, dynamic> parse = jsonDecode(respStr);
        var result = ListRecipes.fromJson(parse);
        return result.listResult;
      }
      else {
        return List.empty();
      }

    }else{
      final response = await http.get(Uri.parse('$GET_10_RECIPES_FROM_API'));
      print(response.statusCode.toString() + " get 10 recipes");
      if (response.statusCode == 200) {
        Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
        var list = ListRecipes.fromJson(parse);
        return list.listResult;
      } else {
        return List.empty();
      }
    }

  } catch (exception) {
    print(exception.toString());
    return List.empty();
  }
}

Future<List<RecipesCard>> get5bestRecipes() async {
  try {
    String? token = await LocalData().getToken();
    int uid;
    if(token!=null){
      Map<String?, dynamic> payload = Jwt.parseJwt(token);
      int uid = payload['id'];
      var request = http.Request('GET', Uri.parse('$GET_5_BEST_RECIPES_FROM_API?userID=$uid'));
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        Map<String, dynamic> parse = jsonDecode(respStr);
        var result = ListRecipes.fromJson(parse);
        return result.listResult;
      }
      else {
        return List.empty();
      }

    }else{
      final response = await http.get(Uri.parse('$GET_5_BEST_RECIPES_FROM_API'));
      print(response.statusCode.toString() + " get 10 recipes");
      if (response.statusCode == 200) {
        Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
        var list = ListRecipes.fromJson(parse);
        return list.listResult;
      } else {
        return List.empty();
      }
    }

  } catch (exception) {
    print(exception.toString());
    return List.empty();
  }
}

Future<Recipe?> getRecipebyID(int id) async {
  try {
    final response = await http.get(Uri.parse('$GET_RECIPE_BY_ID$id'));
    print(response.statusCode.toString() + 'recipe detail');
    print('$GET_RECIPE_BY_ID$id');
    Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
    final recipe = Recipe.fromJson(parse);
    print(recipe.recipeTitle + "title ne");
    return recipe;
  } catch (exeption) {
    print(exeption.toString());
  }
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
    print(response.statusCode.toString()+ "all recipes");
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
Future<ListRecipes2?> getRecipeVisitor(int page, int limit, int id) async {
  final url = "http://14.161.47.36:8080/hiepphat-0.0.1-SNAPSHOT/api/recipes/getallbyuserIDdifferent/$id?page=$page&limit=$limit";
  final http.Client httpClient = http.Client();
  try{
    final response = await httpClient.get(Uri.parse(url));
    print(response.statusCode);
    if(response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListRecipes2.fromJson(parse);
      return list;
    } else {
      return null;
    }
  } catch(exception) {
    print('Exception sending api : '+exception.toString());
    return null;
  }
}
Future<List<Category>> getCategory() async {
  try {
    final response = await http.get(Uri.parse('$GET_CATEGORY'));
    print(response.statusCode.toString() + 'lay category');
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

Future<bool> createRecipe(CreateRecipe createRecipe) async {
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

Future<bool> deleteRecipe(int recipeID) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    token = 'Bearer ' + token;
    final response =
        await http.delete(Uri.parse('$DELETE_RECIPE$recipeID'), headers: {
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
    final response =
        await http.get(Uri.parse('$RECIPE_COMMENT$recipeid/comments'));
    print('$RECIPE_COMMENT$recipeid/comments');
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListComment.fromJson(parse);
      if (list.listResult.isEmpty) {
        print('khong co comment');
      } else {
        print(list.listResult[0].content);
      }
      return list.listResult;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print(exception.toString());
    return List.empty();
  }
}

Future<bool> likeRecipes(int recipeId) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    var params = {"recipe_id": recipeId, "user_id": uid};
    final response = await http
        .post(Uri.parse('$LIKE_RECIPE'), body: json.encode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.authorizationHeader: token
    });
    print(response.statusCode.toString()+ "like thu");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    print(exception.toString());
    return false;
  }
}

Future<bool> editRecipe(EditRecipe editRecipe, int recipeId) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    print(json.encode(editRecipe.toJson()));
    final response = await http.put(Uri.parse('$EDIT_RECIPE$recipeId'),
        body: json.encode(editRecipe.toJson()),
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


Future<List<RRecipesCard>> recommendRecipe() async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    final response = await http.get(Uri.parse('$RECOMMENT_RECIPE_FOR_USER$uid'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        });
    print(response.statusCode.toString() +"get recommend");
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
      final List<RRecipesCard> recommend = responseData.map<RRecipesCard>((json) => RRecipesCard.fromJson(json)).toList();
      return recommend;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print('Create Recipe error: ' + exception.toString());
    return List.empty();
  }
}
