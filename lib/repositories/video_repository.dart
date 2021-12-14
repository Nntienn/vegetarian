

import 'dart:convert';
import 'dart:io';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/models/list_4_videos.dart';
import 'package:vegetarian/models/list_video.dart';
import 'package:vegetarian/models/upload_video.dart';
import 'package:vegetarian/models/video.dart';
import 'package:vegetarian/models/video_comment.dart';

import 'local_data.dart';
import 'package:http/http.dart' as http;

Future<bool> uploadVideo(UploadVideo video) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.post(Uri.parse('$UPLOAD_VIDEO'),
        body: json.encode(video.toJson()),
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
    print(exception.toString() +"loi upload video");
    return false;
  }
}
Future<Listvideo?> get4bestVideos() async {
  try {
    final response = await http.get(Uri.parse('$GET_4_VIDEOS'));
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = Listvideo.fromJson(parse);
      return list;
    } else {
      return null;
    }
  } catch (exception) {
    print(exception.toString());
    return null;
  }
}
Future<bool> likeVideo(int recipeId) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    var params = {"video_id": recipeId, "user_id": uid};
    final response = await http
        .post(Uri.parse('$LIKE_VIDEO'), body: json.encode(params), headers: {
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
Future<List<VideoComment>> getVideoComments(int recipeid) async {
  try {
    final response =
    await http.get(Uri.parse('$VIDEO_COMMENT$recipeid/comments'));
    print('$RECIPE_COMMENT$recipeid/comments');
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListVideoComment.fromJson(parse);
      if (list.listCommentVideo.isEmpty) {
        print('khong co comment');
      } else {
        print(list.listCommentVideo[0].content);
      }
      return list.listCommentVideo;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print(exception.toString());
    return List.empty();
  }
}
Future<Listvideo?> getallVideos(int page, int limit) async {
  try {
    page = 1;
    limit = 100;
    final response = await http.get(Uri.parse('$GET_ALL_VIDEOS?page=$page&limit=$limit'));
    print('$GET_ALL_VIDEOS?page=$page&limit=$limit');
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = Listvideo.fromJson(parse);
      print(list.listResult.length);
      return list;
    } else {
      return null;
    }
  } catch (exception) {
    print(exception.toString());
    return null;
  }
}

Future<Video?> getVideo(int videoId) async {
  try {
    String? token = await LocalData().getToken();
    Map<String?, dynamic> payload = Jwt.parseJwt(token!);
    int uid = payload['id'];
    token = 'Bearer ' + token;
    if(token != null){
      final response = await http.get(Uri.parse('$GET_VIDEO$videoId?userID=$uid'));
      print(response.statusCode.toString() + "lay video");
      if (response.statusCode == 200) {
        Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
        var video = Video.fromJson(parse);
        print(video.videoLink + "video link");
        return video;
      }
    }else{
      final response = await http.get(Uri.parse('$GET_VIDEO$videoId'));
      print(response.statusCode.toString() + "lay video");
      if (response.statusCode == 200) {
        Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
        var video = Video.fromJson(parse);
        print(video.videoLink + "video link");
        return video;
      }
    }

  } catch (exception) {
    print(exception.toString());
  }
}
Future<ListVideos?> getVideosbyUserID() async {
  String? token = await LocalData().getToken();
  Map<String?, dynamic> payload = Jwt.parseJwt(token!);
  int uid = payload['id'];
  token = 'Bearer ' + token;
  try {
    final response = await http.get(
        Uri.parse('$GET_USER_VIDEOS$uid?page=1&limit=100'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "*/*",
          HttpHeaders.authorizationHeader: token
        });
    print('$GET_USER_VIDEOS$uid?page=1&limit=100');
    print(token);
    print(response.statusCode.toString() + "get user recipe");
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = ListVideos.fromJson(parse);
      return list;
    } else {
      return null;
    }
  } catch (exception) {
    print(exception.toString());
    return null;
  }
}