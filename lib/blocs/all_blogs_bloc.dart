import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/all_blogs_event.dart';
import 'package:vegetarian/models/blogs_card.dart';
import 'package:vegetarian/repositories/blog_repository.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/states/all_blogs_state.dart';

class AllBlogsBloc extends Bloc<AllBlogsBloc, AllBlogsState> {
  AllBlogsBloc() :super(AllBlogsStateInitial());

  @override
  Stream<AllBlogsState> mapEventToState(AllBlogsBloc event) async* {
    if (event is AllBlogsFetchEvent) {
      String? token = await LocalData().getToken();
      List<BlogsCard> allBlogs = await getallBlogs();
      if (token != null) {
        yield AllBlogsStateSuccess(allBlogs);
      }
    }
  }
}