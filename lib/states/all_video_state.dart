import 'package:vegetarian/models/list_4_videos.dart';

class AllVideosState {
  const AllVideosState();
}

class AllVideosStateInitial extends AllVideosState {
}
class AllVideosStateFailure extends AllVideosState {}
class AllVideosStateSuccess extends AllVideosState {
  final Listvideo videos;
  AllVideosStateSuccess(this.videos);
}