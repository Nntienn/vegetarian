import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/blog_event.dart';
import 'package:vegetarian/models/blog.dart';
import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/repositories/blog_repository.dart';
import 'package:vegetarian/states/blog_states.dart';


class BlogBloc extends Bloc<BlogBloc, BlogState> {
  BlogBloc() : super(BlogStateInitial());

  @override
  Stream<BlogState> mapEventToState(BlogBloc event) async* {
    if (event is BlogFetchEvent) {
      int blogID = event.blogID;
      Blog? blog = await getBlogbyID(blogID);
      if(blog != null){
        yield BlogStateSuccess(blog);
      }
    }
  }
}
