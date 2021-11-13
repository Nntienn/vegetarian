import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/events/create_recipe_events.dart';
import 'package:vegetarian/events/upload_video_event.dart';
import 'package:vegetarian/models/category.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/recipes_repository.dart';
import 'package:vegetarian/repositories/video_repository.dart';

import 'package:vegetarian/states/upload_video.dart';

class UploadVideoBloc extends Bloc<UploadVideoBloc, UploadVideoState> {
  UploadVideoBloc():super(UploadVideoStateInitial());

  @override
  Stream<UploadVideoState> mapEventToState(UploadVideoBloc event) async* {
    if(event is UploadVideoFetchEvent){
      yield UploadVideoStateLoadSuccess();
    }
    if(event is UploadVideoEvent){
      String? token = await LocalData().getToken();
        Map<String?, dynamic> payload = Jwt.parseJwt(token!);
        int id = payload['id'];
      event.video.userId = id;
      bool upload = await uploadVideo(event.video);
      if(upload){
        yield UploadVideoStateSuccess();
      }else{
        yield UploadVideoStateFailure();
      }
    }
  }
}
