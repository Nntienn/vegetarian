

import 'package:vegetarian/models/list_4_videos.dart';
import 'package:vegetarian/models/list_video.dart';

class UserVideosState {
  const UserVideosState();
}

class UserVideosStateInitial extends UserVideosState {
}
class UserVideosStateFailure extends UserVideosState {}

class UserVideosStateSuccess extends UserVideosState {
  final ListVideos list;

  UserVideosStateSuccess(this.list);

}