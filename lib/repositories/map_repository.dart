import 'dart:convert';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vegetarian/constants/constants.dart';
import 'package:vegetarian/models/nearby.dart';
import 'package:http/http.dart' as http;
Future<List<Result>> getNearby(LatLng pos) async {
  try {
    double lat = pos.latitude;
    double lng = pos.longitude;

    var request = http.Request('GET', Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=Vergan+Restaurant&location=10.8568098%2C106.6926794&radius=2000&type=restaurant&key=AIzaSyCjh4wjUFsNKfo6pcPMiBGLQi5_bziD3ig'));

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    final respStr = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(respStr);
      var result = NearBy.fromJson(parse);
      return result.results;
    }
    else {
      print(response.reasonPhrase);
      return List.empty();
    }
    return List.empty();
  } catch (exception) {
    print('Create Recipe error: ' + exception.toString());
    return List.empty();
  }
}