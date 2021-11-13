import 'package:vegetarian/blocs/edit_basic_profile_bloc.dart';
import 'package:vegetarian/blocs/edit_recipe_bloc.dart';
import 'package:vegetarian/models/edit_recipe.dart';

class EditProfileEvent extends EditProfileBloc {
  final String firstName;
  final String lastName;
  final String aboutMe;
  final String phoneNumber;
  final String country;
  final String facebookLink;
  final String instagramLink;
  final DateTime birthdate;
  final String gender;

  EditProfileEvent(
      this.firstName,
      this.lastName,
      this.aboutMe,
      this.phoneNumber,
      this.country,
      this.facebookLink,
      this.instagramLink,
      this.birthdate,
      this.gender);
}

class EditProfileFetchEvent extends EditProfileBloc {}
