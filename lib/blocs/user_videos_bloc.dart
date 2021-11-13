import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/events/user_recipes_events.dart';
import 'package:vegetarian/states/user_videos_state.dart';

class UserVideosBloc extends Bloc<UserVideosBloc, UserVideosState> {
  UserVideosBloc() :super(UserVideosStateInitial());

  @override
  Stream<UserVideosState> mapEventToState(UserVideosBloc event) async* {
    if (event is UserRecipesFetchEvent) {
        yield UserVideosStateSuccess();
    }
  }
}