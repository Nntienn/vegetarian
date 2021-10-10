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
          var date = new DateTime.fromMicrosecondsSinceEpoch(birthday * 1000);
          String gender = payload['gender'].toString();
          if (gender == "null") {
            gender = "";
          };
          User user = new User(
            id: id,
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

          yield ProfileStateSuccess(user: user);
        } else {
          yield ProfileStateFailure();
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield ProfileStateFailure();
      }
    }
    if (event is ProfileUpdateEvent) {
      try {
        var currentState = state as ProfileStateSuccess;
        User? updatedUser = await editUser(event.id, event.email, event.firstName, event.lastName, event.aboutMe,event.phoneNumber,event.profileImage,event.country,event.facebookLink,event.instagramLink,event.birthdate,event.gender);
        if (updatedUser != null) {
          yield ProfileStateSuccess(user: updatedUser);
        } else {
          yield currentState;
        }
      }catch (exception) {
        print('State error: ' + exception.toString());
        var currentState = state as ProfileStateSuccess;
        yield currentState;
      }
    }
  }
}
