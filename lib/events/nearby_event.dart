
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vegetarian/blocs/nearby_bloc.dart';
import 'package:vegetarian/blocs/user_weekly_menu_bloc.dart';

class NearByFetchEvent extends NearByBloc{
  final String keywword;
  final String type;
  final LatLng pos;
  final int radius;
  NearByFetchEvent(this.pos, this.radius, this.keywword, this.type);
}

