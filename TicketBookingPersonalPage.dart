import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myfl/Temp1/TicketBookingLocationPage.dart';
import 'Repo.dart' as repo;
import 'Locations.dart'; // Import your Locations class
import 'Schedules.dart'; // Import your Schedules class

class PersonalPage extends StatefulWidget {
  final CurrentCard? currentCard;
 
  PersonalPage({ this.currentCard});
  @override
  PersonalPageState createState() => PersonalPageState();
}

class PersonalPageState extends State<PersonalPage> {
  int _currentIndex = 1; // Index for the selected bottom navigation item
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  String _result = '';
  List<Map<String, dynamic>> _schedules = [];
  String _toLocation = '';
  Locations _locations = Locations(locations: []); // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    _loadLocations();
    // Add listeners to text controllers
    _fromController.addListener(_updateDistanceAndSchedule);
    _toController.addListener(_updateDistanceAndSchedule);
  }
void _onSelectSchedule({
  required String from,
  required String to,
  required dynamic departure,
  required dynamic arrival,
  required dynamic price,
}) {
  final selectedSchedule = SelectedSchedule(
    from: from,
    to: to,
    departure: departure.toString(),
    arrival: arrival.toString(),
    price: price.toString(),
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LocationPage(
       
        selectedSchedule: selectedSchedule,
         currentCard: widget.currentCard ?? null,
      ),
    ),
  );
}


  @override
  void dispose() {
    // Remove listeners when the widget is disposed
    _fromController.removeListener(_updateDistanceAndSchedule);
    _toController.removeListener(_updateDistanceAndSchedule);
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }
void _loadLocations() {
  try {
    repo.addLocations();
    repo.addSchedule();
    final jsonString = repo.getLocations(); // Assuming this returns a JSON string
    if (jsonString == null || jsonString.isEmpty) {
      throw Exception('Locations data is empty or null');
    }

    final locationsData = Locations.fromJson(jsonDecode(jsonString));
    setState(() {
      _locations = locationsData; // Assign the Locations object to _locations
    });
  } catch (e) {
    setState(() {
      _result = 'Error loading locations: $e';
    });
  }
}



  Future<void> _updateDistanceAndSchedule() async {
    if (_locations.locations.isEmpty) {
      setState(() {
        _result = 'Error: Locations data not loaded';
      });
      return;
    }

    final fromLocation = _locations.locations.firstWhere(
  (loc) => loc.name == _fromController.text,
  orElse: () => Location(name: '', latitude: 0, longitude: 0), // Provide a default or handle the case
);

final toLocation = _locations.locations.firstWhere(
  (loc) => loc.name == _toController.text,
  orElse: () => Location(name: '', latitude: 0, longitude: 0), // Provide a default or handle the case
);


    if (fromLocation != null && toLocation != null) {
      double distance = Geolocator.distanceBetween(
        fromLocation.latitude,
        fromLocation.longitude,
        toLocation.latitude,
        toLocation.longitude,
      );

      setState(() {
        _result = 'Distance: ${distance / 1000} km'; // Convert to kilometers
        _toLocation = _toController.text; // Update the _toLocation state variable
      });
      await _fetchSchedule(fromLocation.name, toLocation.name);
    } else {
      setState(() {
        _result = 'Error: One or both locations are invalid';
        _schedules = [];
      });
    }
  }

Future<void> _fetchSchedule(String from, String to) async {
  final jsonString = repo.getSchedules(); // Assuming this returns a JSON string
  final schedulesData = Schedules.fromJson(jsonDecode(jsonString));

  // Find the schedule that matches 'from' and 'to'
  final schedule = schedulesData.schedules.firstWhere(
    (schedule) => schedule.from == from && schedule.to == to,
    orElse: () => Schedule(from: '', to: '', schedule: []), // Return a default empty Schedule if not found
  );

  setState(() {
    // Convert schedule details to a format suitable for ListView
    _schedules = schedule.schedule.map((detail) => {
      'departure': detail.departure,
      'arrival': detail.arrival,
      'price': detail.price,
    }).toList();
  });
}




  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Blue Container
                Container(
                  width: double.infinity,
                  height: 500,
                  color: Color.fromRGBO(58, 158, 194, 1),
                ),
                Positioned.fill(
                  bottom: 300,
                  left: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/train1.png',
                      fit: BoxFit.fill,
                      width: 350,
                      height: 50,
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: screenHeight - 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          left: 20,
                          right: 20,
                          child: Container(
                            width: double.infinity,
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4), // Shadow color with opacity
                                  offset: Offset(0, 4), // Shadow offset (x, y)
                                  blurRadius: 8, // Blur radius
                                  spreadRadius: 0, // Spread radius
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.location_on),
                                  title: Text('From'),
                                  subtitle: TextField(
                                    
                                    controller: _fromController,
                                    decoration: InputDecoration(
                                      
                                      labelText: ' from location',
                                     border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black,
                                  thickness: 0.9,
                                  indent: 55,
                                  endIndent: 55,
                                ),
                                ListTile(
                                  leading: Icon(Icons.location_on),
                                  title: Text('To'),
                                  subtitle: TextField(
                                    controller: _toController,
                                    decoration: InputDecoration(
                                      labelText: ' To location',
                                     border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 80,
                          left: 48,
                          child: Container(
                            width: 1,
                            height: 70,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'Choose Schedule',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
           Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0),
  child: _schedules.isEmpty
      ? Center(child: Text('No options available'))
      : ListView.builder(
          shrinkWrap: true,
          itemCount: _schedules.length,
          itemBuilder: (context, index) {
            final schedule = _schedules[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4), // Shadow color with opacity
                      offset: Offset(0, 4), // Shadow offset (x, y)
                      blurRadius: 8, // Blur radius
                      spreadRadius: 0, // Spread radius
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.clock,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${schedule['departure']} ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              WidgetSpan(
                                child: FaIcon(
                                  FontAwesomeIcons.arrowsAltH,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '${schedule['arrival']} ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        FaIcon(
                          FontAwesomeIcons.dollarSign,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${schedule['price']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.locationPin,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(_toLocation),
                        ),
                        GestureDetector(
                          onTap: () {
                            _onSelectSchedule(
                              from: _fromController.text,
                              to: _toController.text,
                              departure: schedule['departure'],
                              arrival: schedule['arrival'],
                              price: schedule['price'],
                            );
                          },
                          child: Container(
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Select',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
),

          ],
        ),
      ),
     
    );
  }
}
