import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vegetarian/blocs/nearby_bloc.dart';
import 'package:vegetarian/states/near_by_state.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapControlller;
  Position? currentPosition;
  var geoLocator = Geolocator();
  double bottomPadding = 0;

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latlngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latlngPosition, zoom: 17);
    newGoogleMapControlller!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Find Store'),
      ),
      body:
      BlocBuilder<NearByBloc, NearByState>(
          builder: (context, state) {
            if(state is NearByStateSuccess){
               final CameraPosition _kGooglePlex = CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 2,
              );
              Stack(
                children: [
                  GoogleMap(
                    padding: EdgeInsets.only(bottom: bottomPadding),
                    mapType: MapType.normal,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controllerGoogleMap.complete(controller);
                      newGoogleMapControlller = controller;
                      setState(() {
                        bottomPadding = 265.0;
                      });
                      locatePosition();
                    },
                  ),
                ],
              );
            }return SizedBox();
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => locatePosition(),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
