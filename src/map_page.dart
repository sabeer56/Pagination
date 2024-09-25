import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

class DistanceBetweenTwoPoints extends StatefulWidget {
  @override
  State<DistanceBetweenTwoPoints> createState() => DistanceBetweenTwoPointsState();
}

class DistanceBetweenTwoPointsState extends State<DistanceBetweenTwoPoints> {
  GoogleMapController? mapController;
  LatLng? _startPoint;
  LatLng? _endPoint;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Distance Between Two Points'),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.7749, -122.4194),
                zoom: 6.0,
              ),
              markers: markers,
              onTap: addMarker,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: _calculateDistance,
              child: const Text("Calculate Distance"),
            ),
          ),
        ],
      ),
    );
  }

 void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
  print("GoogleMapController created");
}

@override
void initState() {
  super.initState();
  print("Google Maps initialization started.");
}

  void addMarker(LatLng latLng) {
    print("Add Marker called with latLng: $latLng");
    setState(() {
      if (_startPoint == null) {
        _startPoint = latLng;
        markers.add(Marker(markerId: MarkerId('start'), position: _startPoint!));
        print("Start point set to: $_startPoint");
      } else if (_endPoint == null) {
        _endPoint = latLng;
        markers.add(Marker(markerId: MarkerId('end'), position: _endPoint!));
        print("End point set to: $_endPoint");
      } else {
        // Reset if both points are already set
        markers.clear();
        _startPoint = latLng;
        _endPoint = null;
        markers.add(Marker(markerId: MarkerId('start'), position: _startPoint!));
        print("Both points already set. Resetting start point to: $_startPoint");
      }
    });
    print("Markers updated: $markers");
  }

  void _calculateDistance() {
    print("Calculate Distance called");
    if (_startPoint == null || _endPoint == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please select both start and end points.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      print("One or both points are missing");
      return;
    }
    double distance = calculateDistance(
      _startPoint!.latitude,
      _startPoint!.longitude,
      _endPoint!.latitude,
      _endPoint!.longitude,
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Distance'),
        content: Text('The distance between the points is ${distance.toStringAsFixed(2)} km'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    print("Distance calculated: $distance km");
  }

  double calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    print("Calculating distance from ($startLatitude, $startLongitude) to ($endLatitude, $endLongitude)");
    const double earthRadius = 6371.0; // Earth's radius in kilometers
    double dLat = _degreesToRadians(endLatitude - startLatitude);
    double dLon = _degreesToRadians(endLongitude - startLongitude);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(startLatitude)) *
        cos(_degreesToRadians(endLatitude)) *
        sin(dLon / 2) *
        sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;
    print("Calculated distance: $distance km");
    return distance;
  }

  double _degreesToRadians(double degrees) {
    double radians = degrees * pi / 180;
    print("Converted $degrees degrees to $radians radians");
    return radians;
  }
}
