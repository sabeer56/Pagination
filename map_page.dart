import 'dart:convert'; // Import this for JSON handling
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// Define the JSON data as a Dart constant
const String locationsJson = '''
{
  "locations": [
    { "name": "Chennai", "latitude": 13.0827, "longitude": 80.2707 },
    { "name": "Coimbatore", "latitude": 11.0168, "longitude": 76.9558 },
    { "name": "Madurai", "latitude": 9.9251, "longitude": 78.1198 },
    { "name": "Tiruchirappalli", "latitude": 10.7905, "longitude": 78.7047 },
    { "name": "Salem", "latitude": 11.6643, "longitude": 78.1460 },
    { "name": "Erode", "latitude": 11.3414, "longitude": 77.7172 },
    { "name": "Vellore", "latitude": 12.9165, "longitude": 79.1328 },
    { "name": "Tirunelveli", "latitude": 8.7102, "longitude": 77.7740 },
    { "name": "Ramanathapuram", "latitude": 9.3530, "longitude": 78.5767 },

    { "name": "Bengaluru", "latitude": 12.9716, "longitude": 77.5946 },
    { "name": "Mysuru", "latitude": 12.2958, "longitude": 76.6394 },
    { "name": "Hubballi", "latitude": 15.3647, "longitude": 75.1198 },
    { "name": "Mangaluru", "latitude": 12.9141, "longitude": 74.8560 },
    { "name": "Bellary", "latitude": 15.1394, "longitude": 76.9211 },
    { "name": "Davanagere", "latitude": 14.4661, "longitude": 75.9919 },
    { "name": "Tumakuru", "latitude": 13.3404, "longitude": 77.1011 },
    { "name": "Udupi", "latitude": 13.3406, "longitude": 74.7883 },

    { "name": "Hyderabad", "latitude": 17.3850, "longitude": 78.4867 },
    { "name": "Secunderabad", "latitude": 17.4397, "longitude": 78.4980 },
    { "name": "Warangal", "latitude": 17.9784, "longitude": 79.5941 },
    { "name": "Karimnagar", "latitude": 17.3408, "longitude": 79.1162 },
    { "name": "Khammam", "latitude": 17.2474, "longitude": 80.1504 },
    { "name": "Nizamabad", "latitude": 17.6730, "longitude": 78.0961 },
    { "name": "Mahbubnagar", "latitude": 16.7481, "longitude": 77.9854 },

    { "name": "Visakhapatnam", "latitude": 17.6868, "longitude": 83.2185 },
    { "name": "Vijayawada", "latitude": 16.5062, "longitude": 80.6480 },
    { "name": "Guntur", "latitude": 16.3067, "longitude": 80.4366 },
    { "name": "Tirupati", "latitude": 13.6288, "longitude": 79.4192 },
    { "name": "Kakinada", "latitude": 16.9890, "longitude": 82.2488 },
    { "name": "Nellore", "latitude": 14.4426, "longitude": 79.9864 },
    { "name": "Anantapur", "latitude": 14.6811, "longitude": 77.6068 },
    { "name": "Rajamahendravaram", "latitude": 17.0033, "longitude": 81.7700 }
  ]
}
''';




class DistanceCalculator extends StatefulWidget {
  @override
  _DistanceCalculatorState createState() => _DistanceCalculatorState();
}

class _DistanceCalculatorState extends State<DistanceCalculator> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  String _result = '';
  Map<String, dynamic> _locations = {};

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  void _loadLocations() {
    // Parse the embedded JSON string
    final data = json.decode(locationsJson);
    setState(() {
      _locations = data;
    });
  }

  Future<void> _calculateDistance() async {
    if (_locations.isEmpty) {
      setState(() {
        _result = 'Error: Locations data not loaded';
      });
      return;
    }

    try {
      final fromLocation = _locations['locations'].firstWhere((loc) => loc['name'] == _fromController.text);
      final toLocation = _locations['locations'].firstWhere((loc) => loc['name'] == _toController.text);

      if (fromLocation != null && toLocation != null) {
        double distance = Geolocator.distanceBetween(
          fromLocation['latitude'],
          fromLocation['longitude'],
          toLocation['latitude'],
          toLocation['longitude'],
        );

        setState(() {
          _result = 'Distance: ${distance / 1000} km'; // Convert to kilometers
        });
      } else {
        setState(() {
          _result = 'Error: One or both locations are invalid';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distance Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _fromController,
              decoration: InputDecoration(
                labelText: 'From Location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _toController,
              decoration: InputDecoration(
                labelText: 'To Location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateDistance,
              child: Text('Calculate Distance'),
            ),
            SizedBox(height: 16),
            Text(
              _result,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
