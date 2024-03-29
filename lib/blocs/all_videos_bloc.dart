import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetarian/events/all_video_bloc.dart';
import 'package:vegetarian/models/list_4_videos.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/video_repository.dart';
import 'package:vegetarian/states/all_video_state.dart';

class AllVideosBloc extends Bloc<AllVideosBloc, AllVideosState> {
  AllVideosBloc() :super(AllVideosStateInitial());

  @override
  Stream<AllVideosState> mapEventToState(AllVideosBloc event) async* {
    if (event is AllVideosFetchEvent) {
      String? token = await LocalData().getToken();
      Listvideo? tenRecipes = await getallVideos(1, 100);
      if (token != null) {
        yield AllVideosStateSuccess(tenRecipes!);
      }
    }
  }
}