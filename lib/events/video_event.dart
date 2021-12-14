
import 'package:vegetarian/blocs/video_bloc.dart';

class VideoFetchEvent extends VideoBloc{
  final String lastPage;
  final int videoId;
  VideoFetchEvent(this.videoId, this.lastPage);
}
class VideoLikeEvent extends VideoBloc{
  final int recipeID;
  VideoLikeEvent(this.recipeID);
}
class VideoCommentEvent extends VideoBloc{
  final int recipeId;
  final String comment;
  VideoCommentEvent(this.comment, this.recipeId);
}
class EditVideoCommentEvent extends VideoBloc{
  final int commentId;
  final int recipeId;
  final String comment;
  EditVideoCommentEvent(this.comment, this.commentId, this.recipeId);
}
class VideoDeleteCommentEvent extends VideoBloc{
  final int recipeId;
  final int commentId;
  VideoDeleteCommentEvent(this.commentId, this.recipeId);
}