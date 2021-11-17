import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/profile_menu_state.dart';

class ProfileMenuBloc extends Bloc<ProfileMenuBloc, ProfileMenuState> {
  ProfileMenuBloc() :super(ProfileMenuStateInitial());

  @override
  Stream<ProfileMenuState> mapEventToState(ProfileMenuBloc event) async* {
    if (event is ProfileMenuFetchEvent) {
      try {
        String? token = await LocalData().getToken();
        print(token);
        if (token != null) {
          Map<String?, dynamic> payload = Jwt.parseJwt(token);
          int id = payload['id'];
          User? user = await getUser();
          List<String>? path = await LocalData().getPath();

          if(path==null){
            path = [];
          }
          path!.add(event.path);
          print(path);
          yield
          ProfileMenuStateSuccess(path!,event.lastPageId,user: user!);
        } else {
          yield ProfileMenuStateFailure();
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield ProfileMenuStateFailure();
      }
    }else if(event is ProfileMenuUpdateImageEvent){
      bool? changeImage = await updateProfileImage(event.image);
      if(changeImage!){
        User? user = await getUser();
        List<String>? path = await LocalData().getPath();
        var current = state as ProfileMenuStateSuccess;
        yield
        ProfileMenuStateSuccess(path!,current.lastPageid,user: user!);
      }
    }
  }
}