import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/user_videos_event.dart';
import 'package:vegetarian/models/list_video.dart';
import 'package:vegetarian/repositories/video_repository.dart';
import 'package:vegetarian/states/user_videos_state.dart';

class UserVideosBloc extends Bloc<UserVideosBloc, UserVideosState> {
  UserVideosBloc() :super(UserVideosStateInitial());

  @override
  Stream<UserVideosState> mapEventToState(UserVideosBloc event) async* {
    if (event is UserVideosFetchEvent) {
      ListVideos? listVideos = await getVideosbyUserID();
      print("user video");
        yield UserVideosStateSuccess(listVideos!);
    }
  }
}