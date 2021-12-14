import 'dart:convert';

import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/models/search_result.dart';
import 'package:http/http.dart' as http;
import 'package:vegetarian/repositories/local_data.dart';

Future<Search?> search(String search, String? type, String? diff, String? category,
    String? prepTime, String? sort) async {
  String? token = await LocalData().getToken();
  int uid;
  String searchString = "";
  String typeString = "";
  String diffString = "";
  String categoryString = "";
  String preptimeString = "";
  String sortString = "";
  if (search != null) {
    searchString = "search=" + search;
  }
  if (type != null) {
    typeString = "type=" + type;
  }
  if (prepTime != null) {
    preptimeString = "prepare_time=" + prepTime;
  }
  if (diff != null) {
    diffString = "difficulty=" + diff;
  }
  if (category != null) {
    categoryString = "category=" + category;
  }
  if (sort != null) {
    sortString = "sort=" + sort;
  }
  String url = SEARCH +
      "?" +
      searchString +
      "&" +typeString +
      "&" +diffString +
      "&" +categoryString +
      "&" +preptimeString +
      "&" + sortString ;
  try {
    final response;
    print(url);
      response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> parse =
            jsonDecode(utf8.decode(response.bodyBytes));
        var list = Search.fromJson(parse);
        return list;
      } else {
        return null;}

  } catch (exception) {
    print(exception.toString());
    return null;
  }
}
