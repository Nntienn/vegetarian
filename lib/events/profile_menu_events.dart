
import 'package:vegetarian/blocs/profile_menu_blocs.dart';
import 'package:vegetarian/models/user.dart';


class ProfileMenuFetchEvent extends ProfileMenuBloc{
  final String path;
  final int lastPageId;
  ProfileMenuFetchEvent(this.path, this.lastPageId);
}

class ProfileMenuUpdateEvent extends ProfileMenuBloc{
  final User user;
  ProfileMenuUpdateEvent({required this.user});
}

class ProfileMenuUpdateImageEvent extends ProfileMenuBloc{
  final String image;
  ProfileMenuUpdateImageEvent({required this.image});
}
