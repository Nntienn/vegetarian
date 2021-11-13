import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/models/is_liked.dart';
import 'package:vegetarian/models/liked.dart';
import 'package:vegetarian/models/list_ingredient_name.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/models/userjson.dart';
import 'package:vegetarian/models/weekly_menu.dart';
import 'package:vegetarian/repositories/local_data.dart';

Future<String> createUser(
    String email, String password, String firstName, String lastName) async {
  try {
    var params = {
      "email": email,
      "password": password,
      "first_name": firstName,
      "last_name": lastName,
    };
    final response = await http
        .post(Uri.parse('$REGISTER'), body: json.encode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
    });
    print(response.body);
    if (response.statusCode == 200) {
      return 'true';
    } else {
      return 'doubly';
    }
  } catch (exception) {
    print(exception);
    return '0';
  }
}

Future<bool> verifyUser(
    String code) async {
  try {
    final response = await http
        .post(Uri.parse('$VERIFY?code=$code'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
    });
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var userjson = UserJson.fromJson(parse);
      String token = userjson.token;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      print(token);
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    print(exception);
    return false;
  }
}

Future<bool?> updateUserDetail(
    String firstName,
    String lastName,
    String aboutMe,
    String phoneNumber,
    String country,
    String facebookLink,
    String instagramLink,
    DateTime date,
    String gender) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var params = {
      "first_name": firstName,
      "last_name": lastName,
      "about_me": aboutMe,
      "phone_number": phoneNumber,
      "country": country,
      "facebook_link": facebookLink,
      "instagram_link": instagramLink,
      "birth_date": formattedDate,
      "gender": gender
    };
    print(date);
    Map<String?, dynamic> payload = Jwt.parseJwt(token);
    int id = payload['id'];
    final response = await http.put(Uri.parse('$EDIT_USER_API$id'),
        body: json.encode(params),
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
    print('edit User information error: ' + exception.toString());
    return false;
  }
}

Future<bool?> updateUserPassword(
    String oldPassword,
    String newPassword,
    ) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var params = {
      "oldPassword": oldPassword,
      "password": newPassword,

    };
    Map<String?, dynamic> payload = Jwt.parseJwt(token);
    int id = payload['id'];
    final response = await http.put(Uri.parse('$CHANGE_USER_PASSWORD_BY_ID$id'),
        body: json.encode(params),
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
    print('edit User information error: ' + exception.toString());
    return false;
  }
}

Future<bool?> forgotPassword(
    String email,
    ) async {
  try {

    final response = await http.put(Uri.parse('$FORGOT_PASSWORD?email=$email'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
        });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    print('forgot pass error: ' + exception.toString());
    return false;
  }
}

Future<bool?> forgotPasswordresend(
    String email,
    ) async {
  try {
    final response = await http.put(Uri.parse('$FORGOT_PASSWORD_RESEND?email=$email'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
        });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    print('forgot pass error: ' + exception.toString());
    return false;
  }
}

Future<bool?> updateProfileImage(
    String image,
    ) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var params = {
      "profile_image": image,
    };
    Map<String?, dynamic> payload = Jwt.parseJwt(token);
    int id = payload['id'];
    final response = await http.put(Uri.parse('$EDIT_USER_PROFILE_IMAGE$id'),
        body: json.encode(params),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        });
    print(response.body);
    print(response.statusCode.toString() + "update anh");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    print('update image error: ' + exception.toString());
    return false;
  }
}

Future<String?> resetPassword(
    String code,
    String password,
    String confirm,
    ) async {
  try {
    var params = {
      "newPassword": password,
      "confirmPassword": confirm,

    };
    final response = await http.put(Uri.parse('$RESET_PASSWORD?code=$code'),
        body: json.encode(params),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
        });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  } catch (exception) {
    print('forgot pass error: ' + exception.toString());
    return "error";
  }
}

Future<bool?> updateUserBodyIndex(
    int height, double weight, int workout_routine) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var params = {
      "height":height,
      "workout_routine":workout_routine,
      "weight":weight
    };
    Map<String?, dynamic> payload = Jwt.parseJwt(token);
    int id = payload['id'];
    final response = await http.put(Uri.parse('$EDIT_USER_BODY_INDEX$id'),
        body: json.encode(params),
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
    print('edit User information error: ' + exception.toString());
    return false;
  }
}

Future<Liked?> getUserLiked() async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    final response = await http.get(Uri.parse('$GET_USER_LIKED$uid/liked'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        }
    );
    print('$GET_USER_LIKED$uid/liked');
    print(response.statusCode.toString());
    if (response.statusCode == 200) {

      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = Liked.fromJson(parse);
      return list;
    } else {
      return null;
    }
  } catch (exception) {
    print(exception.toString());
    return null;
  }
}

Future<bool> commentRecipe(int recipeId, String content) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    var params = {
      "user_id": uid,
      "recipe_id": recipeId,
      "content": content,
    };
    final response = await http.post(Uri.parse('$COMMENT_RECIPE'),
        body: json.encode(params),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        }
    );
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      print('ngu');
      return false;
    }
  } catch (exception) {
    print(exception.toString());
    return false;
  }
}

Future<bool> checkLike(int recipeId) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    final response = await http.get(Uri.parse('$CHECK_LIKE_RECIPE?recipeID=$recipeId&userID=$uid'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        }
    );
    print('$CHECK_LIKE_RECIPE?recipeID=$recipeId&userID=$uid');
    print(response.statusCode.toString() + "check like thuan ngu");
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = IsLiked.fromJson(parse);
      print(list.isLiked.toString() +"like status");
      return list.isLiked;
    } else {
      print('chua like');
      return false;
    }
  } catch (exception) {
    print(exception.toString());
    return false;
  }
}

Future<bool> deleteComment(
    int commentId
    ) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    token = 'Bearer ' + token;
    final response = await http.delete(Uri.parse('$DELETE_COMMENT$commentId/recipe'),
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
    print('Delete Comment error: ' + exception.toString());
    return false;
  }
}

Future<User?> getUser(
    ) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    Map<String?, dynamic> payload = Jwt.parseJwt(token);
    int id = payload['id'];
    final response = await http.get(Uri.parse('$GET_USER_BY_ID$id'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      final user = User.fromJson(parse);
      return user;
    } else {
      return null;
    }
  } catch (exception) {
    print('edit User information error: ' + exception.toString());
    return null;
  }
}

Future<Nutrition?> getUserDailyNutrition( int height, double weight, int typeWorkout, int age, String gender
    ) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    Map<String?, dynamic> payload = Jwt.parseJwt(token);
    int id = payload['id'];
    final response = await http.get(Uri.parse('$CHECK_USER_DAILY_NUTRITION?height=$height&weight=$weight&type_workout=$typeWorkout&age=$age&gender=$gender'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      final nutrition = Nutrition.fromJson(parse);
      return nutrition;
    } else {
      return null;
    }
  } catch (exception) {
    print('edit User nutrition error: ' + exception.toString());
    return null;
  }
}

Future<ListIngredientName?> getfavoriteIngredient() async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    final response = await http.get(Uri.parse('$GET_USER_FAVORITE_INGREDIENT$uid'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        }
    );
    print(response.statusCode.toString() +"get list favorite ingredient");
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      final list = ListIngredientName.fromJson(parse);
      return list;
    } else {
      print('ngu');
      return null;
    }
  } catch (exception) {
    print(exception.toString());
    return null;
  }
}

Future<bool> updatefavoriteIngredient(ListIngredientName list) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    final response = await http.put(Uri.parse('$EDIT_USER_FAVORITE_INGREDIENT$uid'),
        body: json.encode(list.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        }
    );
    print(response.statusCode.toString() +"get list favorite ingredient");
    if (response.statusCode == 200) {
      return true;
    } else {
      print('ngu');
      return false;
    }
  } catch (exception) {
    print(exception.toString());
    return false;
  }
}

Future<ListIngredientName?> getAllergies() async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    final response = await http.get(Uri.parse('$GET_USER_ALLERGIES_INGREDIENT$uid'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        }
    );
    print(response.statusCode.toString() +"get list favorite ingredient");
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      final list = ListIngredientName.fromJson(parse);
      return list;
    } else {
      print('ngu');
      return null;
    }
  } catch (exception) {
    print(exception.toString());
    return null;
  }
}

Future<bool> updateAllergies(ListIngredientName list) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    final response = await http.put(Uri.parse('$EDIT_USER_ALLERGIES_INGREDIENT$uid'),
        body: json.encode(list.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        }
    );
    print(response.statusCode.toString() +"get list favorite ingredient");
    if (response.statusCode == 200) {
      return true;
    } else {
      print('ngu');
      return false;
    }
  } catch (exception) {
    print(exception.toString());
    return false;
  }
}

Future<WeeklyMenu?> generateWeeklyMenu() async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    final response = await http.get(Uri.parse('$GENERATE_WEEKLYMENU?id=$uid'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        }
    );
    print(response.statusCode.toString() +"get list favorite ingredient");
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      final weeklyMenu = WeeklyMenu.fromJson(parse);
      if(weeklyMenu!= null){
        print(weeklyMenu.menu[0].listWeeklyRecipe[0].recipeTitle);
        return weeklyMenu;
      }else{
        return null;
      }
    } else {
      print('ngu');
      return null;
    }
  } catch (exception) {
    print(exception.toString());
    return null;
  }
}
Future<bool> saveWeeklyMenu(WeeklyMenu menu) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    final response = await http.post(Uri.parse('$SAVE_WEEKLYMENU$uid'),
        body: json.encode(menu.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        }
    );
    print(response.statusCode.toString() +"save menu");
    if (response.statusCode == 200) {
        return true;
      }else{
        return false;
      }

  } catch (exception) {
    print(exception.toString());
    return false;
  }
}

Future<WeeklyMenu?> getWeeklyMenu() async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    final response = await http.get(Uri.parse('$GET_WEEKLYMENU$uid'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        }
    );
    print('$GET_WEEKLYMENU$uid');
    print(response.statusCode.toString() +"get menu");
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      print(parse);
      final weeklyMenu = WeeklyMenu.fromJson(parse);
      if(weeklyMenu!= null){
        print(weeklyMenu.menu[0].listWeeklyRecipe[0].recipeTitle);
        return weeklyMenu;
      }else{
        return null;
      }
    } else {
      print('ngu');
      return null;
    }
  } catch (exception) {
    print(exception.toString() + "loi roi");
    return null;
  }
}
