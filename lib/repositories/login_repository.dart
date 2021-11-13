import 'dart:convert';
import 'dart:io';

import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/models/userjson.dart';

Future<bool> login(String email, String password) async {
  try {
    var params = {"email": email, "password": password};
    final response = await http
        .post(Uri.parse('$LOGIN'), body: json.encode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    if (response.statusCode == 200) {
      // String token = response.body.toString();
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

Future<bool> googlelogin(
    String email, String firstName, String lastName) async {
  try {
    var params = {
      "email": email,
      "first_name": firstName,
      "last_name": lastName
    };
    final response = await http
        .post(Uri.parse('$GOOGLE_LOGIN'), body: json.encode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    print(response.statusCode.toString() + "dang nhap google");
    if (response.statusCode == 200) {
      // String token = response.body.toString();
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
