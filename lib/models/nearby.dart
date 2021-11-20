// To parse this JSON data, do
//
//     final nearBy = nearByFromJson(jsonString);

import 'dart:convert';

class NearBy {
  NearBy({
    required this.htmlAttributions,
    required this.results,
    required this.status,
  });

  List<dynamic> htmlAttributions;
  List<Result> results;
  String status;

  factory NearBy.fromRawJson(String str) => NearBy.fromJson(json.decode(str));



  factory NearBy.fromJson(Map<String, dynamic> json) => NearBy(
    htmlAttributions: List<dynamic>.from(json["html_attributions"].map((x) => x)),
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    status: json["status"],
  );

}

class Result {
  Result({
    required this.businessStatus,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required  this.openingHours,
    required this.photos,
    required this.placeId,
    required this.plusCode,
    required this.rating,
    required this.reference,
    required this.scope,
    required this.types,
    required this.userRatingsTotal,
    required this.vicinity,
  });

  String businessStatus;
  Geometry geometry;
  String icon;
  String iconBackgroundColor;
  String iconMaskBaseUri;
  String name;
  OpeningHours? openingHours;
  List<Photo>? photos;
  String placeId;
  PlusCode plusCode;
  double rating;
  String reference;
  String scope;
  List<String> types;
  int userRatingsTotal;
  String vicinity;


  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));



  factory Result.fromJson(Map<String, dynamic> json) => Result(
    businessStatus: json["business_status"],
    geometry: Geometry.fromJson(json["geometry"]),
    icon: json["icon"],
    iconBackgroundColor: json["icon_background_color"],
    iconMaskBaseUri: json["icon_mask_base_uri"],
    name: json["name"],
    openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
    photos: json["photos"] == null ? null : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    placeId: json["place_id"],
    plusCode: PlusCode.fromJson(json["plus_code"]),
    rating: json["rating"].toDouble(),
    reference: json["reference"],
    scope: json["scope"],
    types: List<String>.from(json["types"].map((x) => x)),
    userRatingsTotal: json["user_ratings_total"],
    vicinity: json["vicinity"],
  );


}

class Geometry {
  Geometry({
    required this.location,
    required this.viewport,
  });

  Location location;
  Viewport viewport;

  factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: Location.fromJson(json["location"]),
    viewport: Viewport.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "viewport": viewport.toJson(),
  };
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Viewport {
  Viewport({
    required this.northeast,
    required this.southwest,
  });

  Location northeast;
  Location southwest;

  factory Viewport.fromRawJson(String str) => Viewport.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
    northeast: Location.fromJson(json["northeast"]),
    southwest: Location.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast.toJson(),
    "southwest": southwest.toJson(),
  };
}

class OpeningHours {
  OpeningHours({
    required this.openNow,
  });

  bool openNow;

  factory OpeningHours.fromRawJson(String str) => OpeningHours.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
    openNow: json["open_now"],
  );

  Map<String, dynamic> toJson() => {
    "open_now": openNow,
  };
}

class Photo {
  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  factory Photo.fromRawJson(String str) => Photo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    height: json["height"],
    htmlAttributions: List<String>.from(json["html_attributions"].map((x) => x)),
    photoReference: json["photo_reference"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
    "photo_reference": photoReference,
    "width": width,
  };
}

class PlusCode {
  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  String compoundCode;
  String globalCode;

  factory PlusCode.fromRawJson(String str) => PlusCode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
    compoundCode: json["compound_code"],
    globalCode: json["global_code"],
  );

  Map<String, dynamic> toJson() => {
    "compound_code": compoundCode,
    "global_code": globalCode,
  };
}
