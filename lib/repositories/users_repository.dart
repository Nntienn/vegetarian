import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/models/liked.dart';
import 'package:vegetarian/models/user.dart';
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

Future<User?> editUser(
    int uid,
    String email,
    String firstName,
    String lastName,
    String aboutMe,
    String phoneNumber,
    String profileImage,
    String country,
    String facebookLink,
    String instagramLink,
    String date,
    String gender) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var params = {
      "id": uid,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "about_me": aboutMe,
      "phone_number": phoneNumber,
      "profile_image": profileImage,
      "country": country,
      "facebook_link": facebookLink,
      "instagram_link": instagramLink,
      "birth_date": date,
      "gender": gender
    };
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