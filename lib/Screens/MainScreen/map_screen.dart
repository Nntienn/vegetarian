import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:vegetarian/blocs/nearby_bloc.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/events/nearby_event.dart';
import 'package:vegetarian/models/directions_model.dart';
import 'package:vegetarian/repositories/directions_repository.dart';
import 'package:vegetarian/states/near_by_state.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Marker? _origin;
  Marker? _destination;
  Directions? _info;
  late NearByBloc _nearByBloc;
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapControlller;
  Position? currentPosition;
  var geoLocator = Geolocator();
  double bottomPadding = 0;
  List<int> distance = [1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000];
  int radius = 4000;

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
  void initState() {
    super.initState();
    _nearByBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kPrimaryButtonTextColor,
        foregroundColor: Colors.black,
        title: Text('Find Store'),
        actions: [],
      ),
      body: BlocBuilder<NearByBloc, NearByState>(builder: (context, state) {
        if (state is NearByStateInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is NearByStateSuccess) {
          _origin = Marker(
            markerId: const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: state.currentLocation,
          );
          final CameraPosition _kGooglePlex = CameraPosition(
            target: LatLng(
                state.currentLocation.latitude, state.currentLocation.latitude),
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
                markers: {
                  if (_destination != null) _destination!
                },
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: kPrimaryButtonColor2,
                      width: 5,
                      points: _info!.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
              ),
              // Positioned(
              //   top: 20.0,
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //       vertical: 6.0,
              //       horizontal: 12.0,
              //     ),
              //     decoration: BoxDecoration(
              //       color: Colors.yellowAccent,
              //       borderRadius: BorderRadius.circular(20.0),
              //       boxShadow: const [
              //         BoxShadow(
              //           color: Colors.black26,
              //           offset: Offset(0, 2),
              //           blurRadius: 6.0,
              //         )
              //       ],
              //     ),
              //     child: Text(
              //       '${_info!.totalDistance}, ${_info!.totalDuration}',
              //       style: const TextStyle(
              //         fontSize: 18.0,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.225,
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
                            return Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: NetworkImage(state
                                                  .result[index].photos !=
                                              null
                                          ? "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${state.result[index].photos![0].photoReference}&key=AIzaSyCjh4wjUFsNKfo6pcPMiBGLQi5_bziD3ig"
                                          : "http://vegetarian-app.herokuapp.com/static/media/card-thumbnail-default.a5b0bfe9.png"),
                                      fit: BoxFit.cover,
                                    )),
                                    // child: Text(state.result[index].photos![0].photoReference),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.025,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.result[index].name,
                                          style: TextStyle(
                                              fontFamily: "Quicksand",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // state.result[index].openingHours != null? state.result[index].openingHours!.openNow ==
                                        //         false
                                        //     ? Text("Closed")
                                        //     : Text("Open"):SizedBox(),
                                        Text(
                                          state.result[index].vicinity +
                                              state.result[index].plusCode
                                                  .compoundCode
                                                  .split(",")
                                                  .first
                                                  .substring(state.result[index]
                                                      .plusCode.compoundCode
                                                      .split(",")
                                                      .first
                                                      .split(" ")
                                                      .first
                                                      .length),
                                          style: TextStyle(
                                              fontFamily: "Quicksand",
                                              fontSize: 13),
                                        ),
                                        Geolocator.distanceBetween(
                                                    state.result[index].geometry
                                                        .location.lat,
                                                    state.result[index].geometry
                                                        .location.lng,
                                                    state.currentLocation
                                                        .latitude,
                                                    state.currentLocation
                                                        .longitude) <
                                                900.0
                                            ? Text(
                                                "Distance: " +
                                                    Geolocator.distanceBetween(
                                                            state
                                                                .result[index]
                                                                .geometry
                                                                .location
                                                                .lat,
                                                            state
                                                                .result[index]
                                                                .geometry
                                                                .location
                                                                .lng,
                                                            state
                                                                .currentLocation
                                                                .latitude,
                                                            state
                                                                .currentLocation
                                                                .longitude)
                                                        .toStringAsFixed(2) +
                                                    " m",
                                                style: TextStyle(
                                                    fontFamily: "Quicksand",
                                                    fontSize: 13),
                                              )
                                            : Text(
                                                "Distance: " +
                                                    (Geolocator.distanceBetween(
                                                                state
                                                                    .result[
                                                                        index]
                                                                    .geometry
                                                                    .location
                                                                    .lat,
                                                                state
                                                                    .result[
                                                                        index]
                                                                    .geometry
                                                                    .location
                                                                    .lng,
                                                                state
                                                                    .currentLocation
                                                                    .latitude,
                                                                state
                                                                    .currentLocation
                                                                    .longitude) /
                                                            1000)
                                                        .toStringAsFixed(1) +
                                                    " km",
                                                style: TextStyle(
                                                    fontFamily: "Quicksand",
                                                    fontSize: 13),
                                              ),
                                        Spacer(),
                                        Text(
                                          "Rating: " +
                                              state.result[index].rating
                                                  .toString(),
                                          style: TextStyle(
                                              fontFamily: "Quicksand",
                                              fontSize: 13),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                  padding: EdgeInsets.all(0)),
                                              onPressed: (){_addMarker(LatLng(state.result[index].geometry.location.lat, state.result[index].geometry.location.lng));},
                                                  // () =>
                                                  // MapsLauncher.launchQuery(
                                                  //     state.result[index].name +
                                                  //         ", " +
                                                  //         state.result[index]
                                                  //             .vicinity +
                                                  //         state
                                                  //             .result[index]
                                                  //             .plusCode
                                                  //             .compoundCode
                                                  //             .split(",")
                                                  //             .first
                                                  //             .substring(state
                                                  //                 .result[index]
                                                  //                 .plusCode
                                                  //                 .compoundCode
                                                  //                 .split(",")
                                                  //                 .first
                                                  //                 .split(" ")
                                                  //                 .first
                                                  //                 .length)),
                                              child: Text(
                                                  "Tap here to get directions")),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: BlocBuilder<NearByBloc, NearByState>(
                    builder: (context, state) {
                  if (state is NearByStateSuccess) {
                    return Container(
                      margin: EdgeInsets.only(top: 6, right: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.465,
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          hint: new Text("Choose Radius"),
                          value: radius,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: distance.map((int items) {
                            return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  "Radius: " + items.toString() + "m",
                                  style: TextStyle(color: Colors.black),
                                ));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              this.radius = value!;
                              _nearByBloc
                                ..add(NearByFetchEvent(state.currentLocation,
                                    radius, state.keywword, state.type));
                            });
                          },
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                }),
              ),
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

  void _addMarker(LatLng pos) async {
    // if (_origin == null || (_origin != null && _destination != null)) {
    //   // Origin is not set OR Origin/Destination are both set
    //   // Set origin
    //   setState(() {
    //     _origin = Marker(
    //       markerId: const MarkerId('origin'),
    //       infoWindow: const InfoWindow(title: 'Origin'),
    //       icon:
    //       BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    //       position: pos,
    //     );
    //     // Reset destination
    //     _destination = null;
    //
    //     // Reset info
    //     _info = null;
    //   });
    // } else {
    // Origin is already set
    // Set destination
    setState(() {
      _destination = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos,
      );
    });

    // Get directions
    final directions = await DirectionsRepository()
        .getDirections(origin: _origin!.position, destination: pos);
    setState(() => _info = directions);
    // }
  }
}
