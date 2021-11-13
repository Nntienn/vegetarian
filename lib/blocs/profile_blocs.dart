import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/events/profile_events.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/repositories/local_data.dart';
import 'package:vegetarian/repositories/users_repository.dart';
import 'package:vegetarian/states/profile_states.dart';

class ProfileBloc extends Bloc<ProfileBloc, ProfileState> {
  ProfileBloc() : super(ProfileStateInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileBloc event) async* {
    if (event is ProfileFetchEvent) {
      try {
        String? token = await LocalData().getToken();
        if (token != null) {
          Map<String?, dynamic> payload = Jwt.parseJwt(token);
          int id = payload['id'];
          User? user = await getUser();
          yield ProfileStateSuccess(user: user!);
        } else {
          yield ProfileStateFailure();
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield ProfileStateFailure();
      }
    }
    if (event is ProfileUpdateEvent) {

    }
  }
}
