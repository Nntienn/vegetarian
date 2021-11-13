

import 'dart:convert';
import 'dart:io';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/models/list_4_videos.dart';
import 'package:vegetarian/models/upload_video.dart';
import 'package:vegetarian/models/video.dart';

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

Future<Video?> getVideo(int videoId) async {
  try {
    final response = await http.get(Uri.parse('$GET_VIDEO$videoId'));
    print(response.statusCode.toString() + "lay video");
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var video = Video.fromJson(parse);
      print(video.videoLink + "video link");
      return video;
    }
  } catch (exception) {
    print(exception.toString());
  }
}