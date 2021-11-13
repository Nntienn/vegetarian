
import 'package:vegetarian/blocs/video_bloc.dart';

class VideoFetchEvent extends VideoBloc{
  final int videoId;
  VideoFetchEvent(this.videoId);
}