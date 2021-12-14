import 'dart:convert';
import 'dart:io';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/models/blog.dart';
import 'package:vegetarian/models/blog_comment.dart';
import 'package:vegetarian/models/blogs_card.dart';
import 'package:http/http.dart' as http;
import 'package:vegetarian/models/list_blog_comment.dart';
import 'package:vegetarian/models/list_blogs.dart';
import 'package:vegetarian/repositories/local_data.dart';

Future<List<BlogsCard>> get10Blogs() async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    if(token!=null){
      final response = await http.get(Uri.parse('$GET_10_BLOGS_FROM_API?userID=$uid'));
      print(response.statusCode.toString() + 'ahiahi');
      if (response.statusCode == 200) {
        Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
        var list = ListBlogs.fromJson(parse);
        return list.listResult;
      } else {
        return List.empty();
      }
    }else{
      final response = await http.get(Uri.parse('$GET_10_BLOGS_FROM_API'));
      print(response.statusCode.toString() + 'ahiahi');
      if (response.statusCode == 200) {
        Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
        var list = ListBlogs.fromJson(parse);
        return list.listResult;
      } else {
        return List.empty();
      }
    }

  } catch (exception) {
    print(exception.toString() + "loi blog");
    return List.empty();
  }
}
Future<List<BlogComment>> getBlogComments(int recipeid) async {
  try {
    final response =
    await http.get(Uri.parse('$BLOG_COMMENT$recipeid/comments'));
    print('$BLOG_COMMENT$recipeid/comments');
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListBlogComment.fromJson(parse);
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
Future<bool> likeBlog(int recipeId) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    var params = {"blog_id": recipeId, "user_id": uid};
    final response = await http
        .post(Uri.parse('$LIKE_BLOG'), body: json.encode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.authorizationHeader: token
    });
    print(response.statusCode.toString() + "like thu");
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
Future<Blog?> getBlogbyID(int id) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    if(token!=null){
      final response = await http.get(Uri.parse('$GET_BLOG_BY_ID$id?userID=$uid'));
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      final blog = Blog.fromJson(parse);
      return blog;
    }else{
    final response = await http.get(Uri.parse('$GET_BLOG_BY_ID$id'));
    Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
    final blog = Blog.fromJson(parse);
    return blog;}
  } catch (exeption) {}
}

Future<List<BlogsCard>> getBlogsbyUserID(int id) async {
  String? token = await LocalData().getToken();
  Map<String?, dynamic> payload = Jwt.parseJwt(token!);
  int uid = payload['id'];
  token = 'Bearer ' + token;
  try {
    final response = await http
        .get(Uri.parse('$GET_USER_BLOGS_FROM_API$id?page=1&limit=10'),headers: {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "*/*",
    HttpHeaders.authorizationHeader: token
    });
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
