import 'package:vegetarian/blocs/create_recipe_bloc.dart';
import 'package:vegetarian/blocs/upload_video_bloc.dart';
import 'package:vegetarian/models/create_recipe.dart';
import 'package:vegetarian/models/upload_video.dart';


class UploadVideoEvent extends UploadVideoBloc{
  final UploadVideo video;

  UploadVideoEvent(this.video);
}
class UploadVideoFetchEvent extends UploadVideoBloc{
}