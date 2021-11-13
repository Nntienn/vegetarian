
import 'package:vegetarian/models/comment.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/video.dart';

class VideoState {
  const VideoState();
}

class VideoStateInitial extends VideoState {
}
class VideoStateFailure extends VideoState {}
class VideoStateSuccess extends VideoState {
  final Video video;

  VideoStateSuccess(this.video);

}