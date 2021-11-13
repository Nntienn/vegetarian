import 'dart:convert';

import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/models/blog.dart';
import 'package:vegetarian/models/blogs_card.dart';
import 'package:http/http.dart' as http;
import 'package:vegetarian/models/list_blogs.dart';

Future<List<BlogsCard>> get10Blogs() async {
  try {
    final response = await http.get(Uri.parse('$GET_10_BLOGS_FROM_API'));
    print(response.statusCode.toString() + 'ahiahi');
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListBlogs.fromJson(parse);
      return list.listResult;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print(exception.toString() +"loi blog");
    return List.empty();
  }
}
Future<Blog?> getBlogbyID(int id) async {
  try {
    final response = await http.get(Uri.parse('$GET_BLOG_BY_ID$id'));
    Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
    final blog = Blog.fromJson(parse);
    return blog;
  } catch (exeption) {}
}

Future<List<BlogsCard>> getBlogsbyUserID(int id) async {
  try {
    final response = await http.get(Uri.parse('$GET_USER_BLOGS_FROM_API$id?page=1&limit=10'));
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListBlogs.fromJson(parse);
      return list.listResult;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print(exception.toString());
    return List.empty();
  }
}

Future<List<BlogsCard>> getallBlogs() async {
  try {
    final response =
    await http.get(Uri.parse('$GET_ALL_BLOGS?page=1&limit=100'));
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListBlogs.fromJson(parse);
      return list.listResult;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print(exception.toString());
    return List.empty();
  }
}