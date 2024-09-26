
import 'dart:convert';

import 'package:flutter/foundation.dart';


Locations LocationsFromJson(String str) => Locations.fromJson(json.decode(str));

String LocationsToJson(Locations data) => json.encode(data.toJson());
class Locations {
    List<Location> locations;

    Locations({
        required this.locations,
    });
  
   factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),

      );

  Map<String, dynamic> toJson() => {
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
      };

}

class Location {
    String name;
    double latitude;
    double longitude;

    Location({
        required this.name,
        required this.latitude,
        required this.longitude,
    });
  factory Location.fromJson(Map<String, dynamic> json) => Location(
       name:json["name"],
       latitude: json["latitude"],
       longitude:json["longitude"]
 );
 Map<String, dynamic> toJson() => {
        "name":name,
        "latitude":latitude,
        "longitude":longitude
 };
}


