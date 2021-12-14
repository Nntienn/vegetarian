import 'package:vegetarian/blocs/blog_bloc.dart';
import 'package:vegetarian/blocs/recipe_blocs.dart';

class BlogFetchEvent extends BlogBloc{
  final String lastPage;
  final int blogID;
  BlogFetchEvent(this.blogID, this.lastPage);
}
class BlogLikeEvent extends BlogBloc{
  final int recipeID;
  BlogLikeEvent(this.recipeID);
}
class BlogCommentEvent extends BlogBloc{
  final int recipeId;
  final String comment;
  BlogCommentEvent(this.comment, this.recipeId);
}
class EditBlogCommentEvent extends BlogBloc{
  final int commentId;
  final int recipeId;
  final String comment;
  EditBlogCommentEvent(this.comment, this.commentId, this.recipeId);
}
class BlogDeleteCommentEvent extends BlogBloc{
  final int recipeId;
  final int commentId;
  BlogDeleteCommentEvent(this.commentId, this.recipeId);
}