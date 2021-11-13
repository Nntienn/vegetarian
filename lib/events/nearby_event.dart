
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vegetarian/blocs/nearby_bloc.dart';
import 'package:vegetarian/blocs/user_weekly_menu_bloc.dart';

class NearByFetchEvent extends NearByBloc{
  final LatLng pos;

  NearByFetchEvent(this.pos);
}

