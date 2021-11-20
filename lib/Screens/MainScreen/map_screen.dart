import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
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
      body: BlocBuilder<NearByBloc, NearByState>(builder: (context, state) {
        if (state is NearByStateSuccess) {
          final CameraPosition _kGooglePlex = CameraPosition(
            target: LatLng(37.42796133580664, -122.085749655962),
            zoom: 2,
          );
          return Stack(
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
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(
                          5,
                          MediaQuery.of(context).size.height * 0.025,
                          5,
                          MediaQuery.of(context).size.height * 0.025),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.result.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap:() => MapsLauncher.launchQuery(
                                  state.result[index].name + ", "+ state.result[index].vicinity + state.result[index].plusCode.compoundCode.split(",").first.substring(state.result[index].plusCode.compoundCode.split(",").first.split(" ").first.length)),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: MediaQuery.of(context).size.height * 0.15,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name: " + state.result[index].name),
                                    state.result[index].openingHours != null? state.result[index].openingHours!.openNow ==
                                            false
                                        ? Text("Closed")
                                        : Text("Open"):SizedBox(),
                                    Text("Address: " + state.result[index].vicinity + state.result[index].plusCode.compoundCode.split(",").first.substring(state.result[index].plusCode.compoundCode.split(",").first.split(" ").first.length)),
                                    Geolocator.distanceBetween(state.result[index].geometry.location.lat, state.result[index].geometry.location.lng, state.currentLocation.latitude,state.currentLocation.longitude) < 900.0 ?
                                    Text("Distance: " +Geolocator.distanceBetween(state.result[index].geometry.location.lat, state.result[index].geometry.location.lng, state.currentLocation.latitude,state.currentLocation.longitude).toStringAsFixed(2)+" m"):
                                    Text("Distance: " +(Geolocator.distanceBetween(state.result[index].geometry.location.lat, state.result[index].geometry.location.lng, state.currentLocation.latitude,state.currentLocation.longitude)/1000).toStringAsFixed(1)+" km" ),
                                    Text("Rating: " + state.result[index].rating.toString())
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              )
            ],
          );
        }
        return SizedBox();
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => locatePosition(),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
