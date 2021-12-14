import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/events/blog_event.dart';
import 'package:vegetarian/models/blog.dart';
import 'package:vegetarian/models/blog_comment.dart';
import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/repositories/blog_repository.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/blog_states.dart';


class BlogBloc extends Bloc<BlogBloc, BlogState> {
  BlogBloc() : super(BlogStateInitial());

  @override
  Stream<BlogState> mapEventToState(BlogBloc event) async* {
    if (event is BlogFetchEvent) {
      String? token = await LocalData().getToken();
      print(token);
      if (token != null) {
        Map<String?, dynamic> payload = Jwt.parseJwt(token);
        int id = payload['id'];
        int blogID = event.blogID;
        Blog? blog = await getBlogbyID(blogID);
        User? author = await getUserbyID(blog!.userId);
        User? user = await getUserbyID(id);
        List<BlogComment> comments = await getBlogComments(blogID);
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
          yield BlogStateSuccess(blog, comments, path, user, author!, commentImage);
        }
      }else{
        int blogID = event.blogID;
        Blog? blog = await getBlogbyID(blogID);
        User? author = await getUserbyID(blog!.userId);
        List<BlogComment> comments = await getBlogComments(blogID);
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
          yield BlogStateSuccess(blog, comments, path, null, author!, commentImage);
        }
      }

    }
    if (event is BlogLikeEvent) {
      bool like = await likeBlog(event.recipeID);
      if (like) {
        String? token = await LocalData().getToken();
        Map<String?, dynamic> payload = Jwt.parseJwt(token!);
        int id = payload['id'];
        int recipeID = event.recipeID;
        User? user = await getUserbyID(id);
        Blog? blog = await getBlogbyID(recipeID);
        User? author = await getUserbyID(blog!.userId);
        List<BlogComment> comments = await getBlogComments(recipeID);
        List<String>? path = await LocalData().getPath();
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        yield BlogStateSuccess(blog, comments, path!, user, author!, commentImage);
      }
    }
    if(event is BlogCommentEvent){
      {
        bool comment = await commentBlog(event.recipeId, event.comment);
        if (comment) {
          String? token = await LocalData().getToken();
          Map<String?, dynamic> payload = Jwt.parseJwt(token!);
          int id = payload['id'];
          int recipeID = event.recipeId;
          Blog? blog = await getBlogbyID(recipeID);
          User? author = await getUserbyID(blog!.userId);
          User? user = await getUserbyID(id);
          List<BlogComment> comments = await getBlogComments(recipeID);
          List<String>? path = await LocalData().getPath();
          List<String> commentImage = [];
          for(int i = 0; i<comments.length;i++){
            User? user1 = await getUserbyID(comments[i].userId);
            commentImage.add(user1!.profileImage);
          }
          yield BlogStateSuccess(blog, comments, path!, user, author!, commentImage);
        }
      }
    }
    if (event is EditBlogCommentEvent) {
      bool? result = await editBlogComment(event.comment, event.commentId);
      if (result) {
        String? token = await LocalData().getToken();
        Map<String?, dynamic> payload = Jwt.parseJwt(token!);
        int id = payload['id'];
        int recipeID = event.recipeId;
        Blog? blog = await getBlogbyID(recipeID);
        User? author = await getUserbyID(blog!.userId);
        User? user = await getUserbyID(id);
        List<BlogComment> comments = await getBlogComments(recipeID);
        bool isLiked = await checkLike(recipeID);
        List<String>? path = await LocalData().getPath();
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        yield BlogStateSuccess(blog, comments, path!, user, author!, commentImage);
      }
    }
    if (event is BlogDeleteCommentEvent) {
      bool delete = await deleteBlogComment(event.commentId);
      if (delete) {
        String? token = await LocalData().getToken();
        Map<String?, dynamic> payload = Jwt.parseJwt(token!);
        int id = payload['id'];
        int recipeID = event.recipeId;
        Blog? blog = await getBlogbyID(recipeID);
        User? author = await getUserbyID(blog!.userId);
        User? user = await getUserbyID(id);
        List<BlogComment> comments = await getBlogComments(recipeID);
        bool isLiked = await checkLike(recipeID);
        List<String>? path = await LocalData().getPath();
        List<String> commentImage = [];
        for(int i = 0; i<comments.length;i++){
          User? user1 = await getUserbyID(comments[i].userId);
          commentImage.add(user1!.profileImage);
        }
        yield BlogStateSuccess(blog, comments, path!, user, author!, commentImage);
      }
    }
  }
}
