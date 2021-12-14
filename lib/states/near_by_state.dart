import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vegetarian/models/nearby.dart';


class NearByState {
  const NearByState();
}

class NearByStateInitial extends NearByState {
}
class NearByStateFailure extends NearByState {}
class NearByStateSuccess extends NearByState {
  final LatLng currentLocation;
  final List<Result> result;
  final String keywword;
  final String type;
  NearByStateSuccess( this.result, this.currentLocation, this.keywword, this.type, );
}