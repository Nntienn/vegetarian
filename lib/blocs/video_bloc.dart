import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/events/recipe_event.dart';
import 'package:vegetarian/events/video_event.dart';
import 'package:vegetarian/models/comment.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/video.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/repositories/video_repository.dart';
import 'package:vegetarian/states/recipes_state.dart';
import 'package:vegetarian/states/video_state.dart';

class VideoBloc extends Bloc<VideoBloc, VideoState> {
  VideoBloc() : super(VideoStateInitial());

  @override
  Stream<VideoState> mapEventToState(VideoBloc event) async* {
    if (event is VideoFetchEvent) {
      String? token = await LocalData().getToken();
      print(token);
      if (token != null) {
        Map<String?, dynamic> payload = Jwt.parseJwt(token);
        int id = payload['id'];
        int videoID = event.videoId;
        print(videoID);
        Video? video = await getVideo(videoID);
        if(video != null){
          print('1');
        }else{
          print('2');
        }
        if (video != null) {
          yield VideoStateSuccess(video);
        }
      }
    }
  }
}
