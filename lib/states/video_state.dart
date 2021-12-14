
import 'package:vegetarian/models/comment.dart';
import 'package:vegetarian/models/recipe.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/models/video.dart';
import 'package:vegetarian/models/video_comment.dart';

class VideoState {
  const VideoState();
}

class VideoStateInitial extends VideoState {
}
class VideoStateFailure extends VideoState {}
class VideoStateSuccess extends VideoState {
  final Video video;
  final List<VideoComment> comments;
  final List<String> path;
  final User? user;
  final User author;
  final List<String> commentImage;

  VideoStateSuccess(this.video, this.comments, this.path, this.user, this.author, this.commentImage);

}