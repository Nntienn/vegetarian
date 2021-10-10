import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vegetarian/events/profile_events.dart';
import 'package:vegetarian/events/profile_menu_events.dart';
import 'package:vegetarian/models/user.dart';
import 'package:vegetarian/repositories/local_data.dart';
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
          String firstName = payload['first_name'].toString();
          if (firstName == "null") {
            firstName = "";
          };
          String lastName = payload['last_name'].toString();
          if (lastName == "null") {
            lastName = "";
          };
          String email = payload['email'].toString();
          if (email == "null") {
            email = "";
          };
          String aboutMe = payload['about_me'].toString();
          if (aboutMe == "null") {
            aboutMe = "";
          };
          String phoneNumber = payload['phone_number'].toString();
          if (phoneNumber == "null") {
            phoneNumber = "";
          };
          String profileImage = payload['profile_image'].toString();
          if (profileImage == "null") {
            profileImage = "";
          };
          String country = payload['country'].toString();
          if (country == "null") {
            country = "";
          };
          String facebookLink = payload['facebook_link'].toString();
          if (facebookLink == "null") {
            facebookLink = "";
          };
          String instagramLink = payload['instagram_link'].toString();
          if (instagramLink == "null") {
            instagramLink = "";
          };
          int birthday = payload['birth_date'];
          var date = new DateTime.fromMicrosecondsSinceEpoch(birthday* 1000);
          String gender = payload['gender'].toString();
          if (gender == "null") {
            gender = "";
          };
          User user = new User(id: id,
              firstName: firstName,
              lastName: lastName,
              email: email,
              aboutMe: aboutMe,
              phoneNumber: phoneNumber,
              profileImage: profileImage,
              country: country,
              facebookLink: facebookLink,
              instagramLink: instagramLink,
              birthDate: date,
              gender: gender,
          );
          yield
          ProfileMenuStateSuccess(user: user);
        } else {
          yield ProfileMenuStateFailure();
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield ProfileMenuStateFailure();
      }
    }
  }
}