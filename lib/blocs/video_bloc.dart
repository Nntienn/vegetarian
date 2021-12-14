import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/events/video_event.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/models/video.dart';
import 'package:vegetarian/models/video_comment.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/repositories/video_repository.dart';

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
        User? author = await getUserbyID(video!.userId);
        User? user = await getUserbyID(id);
        List<VideoComment> comments = await getVideoComments(videoID);
        List<String>? path = await LocalData().getPath();
        if(path == null){
          path = [];
        }
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        path.add(event.lastPage);
        print(path);
        await LocalData().savePath(path);
        if (video != null) {
          yield VideoStateSuccess(video, comments, path, user, author!, commentImage);
        }
      }else{
        int blogID = event.videoId;
        Video? blog = await getVideo(blogID);
        User? author = await getUserbyID(blog!.userId);
        List<VideoComment> comments = await getVideoComments(blogID);
        List<String>? path = await LocalData().getPath();
        if(path == null){
          path = [];
        }
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        path.add(event.lastPage);
        print(path);
        await LocalData().savePath(path);
        if(blog != null){
          yield VideoStateSuccess(blog, comments, path, null, author!, commentImage);
        }
      }
    }
    if (event is VideoLikeEvent) {
      bool like = await likeVideo(event.recipeID);
      if (like) {
        String? token = await LocalData().getToken();
        Map<String?, dynamic> payload = Jwt.parseJwt(token!);
        int id = payload['id'];
        int recipeID = event.recipeID;
        User? user = await getUserbyID(id);
        Video? blog = await getVideo(recipeID);
        User? author = await getUserbyID(blog!.userId);
        List<VideoComment> comments = await getVideoComments(recipeID);
        List<String>? path = await LocalData().getPath();
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        yield VideoStateSuccess(blog, comments, path!, user, author!, commentImage);
      }
    }
    if(event is VideoCommentEvent){
      {
        bool comment = await commentVideo(event.recipeId, event.comment);
        if (comment) {
          String? token = await LocalData().getToken();
          Map<String?, dynamic> payload = Jwt.parseJwt(token!);
          int id = payload['id'];
          int recipeID = event.recipeId;
          Video? blog = await getVideo(recipeID);
          User? author = await getUserbyID(blog!.userId);
          User? user = await getUserbyID(id);
          List<VideoComment> comments = await getVideoComments(recipeID);
          List<String>? path = await LocalData().getPath();
          List<String> commentImage = [];
          for(int i = 0; i<comments.length;i++){
            User? user1 = await getUserbyID(comments[i].userId);
            commentImage.add(user1!.profileImage);
          }
          yield VideoStateSuccess(blog, comments, path!, user, author!, commentImage);
        }
      }
    }
    if (event is EditVideoCommentEvent) {
      bool? result = await editBlogComment(event.comment, event.commentId);
      if (result) {
        String? token = await LocalData().getToken();
        Map<String?, dynamic> payload = Jwt.parseJwt(token!);
        int id = payload['id'];
        int recipeID = event.recipeId;
        Video? blog = await getVideo(recipeID);
        User? author = await getUserbyID(blog!.userId);
        User? user = await getUserbyID(id);
        List<VideoComment> comments = await getVideoComments(recipeID);
        bool isLiked = await checkLike(recipeID);
        List<String>? path = await LocalData().getPath();
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        yield VideoStateSuccess(blog, comments, path!, user, author!, commentImage);
      }
    }
    if (event is VideoDeleteCommentEvent) {
      bool delete = await deleteVideoComment(event.commentId);
      if (delete) {
        String? token = await LocalData().getToken();
        Map<String?, dynamic> payload = Jwt.parseJwt(token!);
        int id = payload['id'];
        int recipeID = event.recipeId;
        Video? blog = await getVideo(recipeID);
        User? author = await getUserbyID(blog!.userId);
        User? user = await getUserbyID(id);
        List<VideoComment> comments = await getVideoComments(recipeID);
        bool isLiked = await checkLike(recipeID);
        List<String>? path = await LocalData().getPath();
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        yield VideoStateSuccess(blog, comments, path!, user, author!, commentImage);
      }
    }
  }
}
