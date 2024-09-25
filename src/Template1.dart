import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Temp1LocationPage.dart';
import 'Temp1PersonalPage.dart';

class TicketBooking extends StatefulWidget {
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<TicketBooking> {
  int _currentIndex = 0; // Index for the selected bottom navigation item

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TicketBooking()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PersonalPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocationPage()),
        );
        break;
    }
    setState(() {
      _currentIndex =
          index; // Update the current index for the bottom navigation bar
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        // Added SingleChildScrollView here
        child: Column(
          children: [
            Stack(
              children: [
                // Blue Container
                Container(
                  width: double.infinity,
                  height: 350,
                  color: Color.fromRGBO(58, 158, 194, 3), // Background color
                ),
                // Yellow Container with overlapping border radius
                Positioned(
                  top: 180, // Adjusted to overlap with the blue container
                  left: 0,
                  right: 0,
                  child: Container(
                    height:
                        screenHeight - 180, // Extends beyond the blue container
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40), // Top left border radius
                        topRight:
                            Radius.circular(40), // Top right border radius
                      ),
                    ),
                  ),
                ),
                // Greeting and icon
                Positioned(
                  top: 15, // Aligns with the bottom of the blue container
                  left: 10, // Adds margin to center the container
                  child: Text('Hello',
                      style: TextStyle(fontSize: 37, color: Colors.white)),
                ),
                Positioned(
                  top: 15, // Aligns with the bottom of the blue container
                  right: 10, // Adds margin to center the container
                  child: Icon(Icons.circle, size: 40, color: Colors.white),
                ),
                // Subtext
                Positioned(
                  top: 70, // Aligns with the bottom of the blue container
                  left: 10, // Adds margin to center the container
                  child: Text('Where you will go',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
                // Search TextField
                Positioned(
                  top: 100, // Aligns with the bottom of the blue container
                  left: 10, // Adds margin to center the container
                  right: 10, // Adds margin to center the container
                  child: Container(
                    width: screenWidth -
                        20, // Reduces width to fit within the screen
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.3), // Shadow color with opacity
                          offset: Offset(0, 4), // Shadow offset (x, y)
                          blurRadius: 8, // Blur radius
                          spreadRadius: 0, // Spread radius
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        border: InputBorder.none,
                        hintText: 'search',
                      ),
                    ),
                  ),
                ),
                // Amber Container with balance details
                Positioned(
                  top: 150, // Adjust this value if necessary to avoid overlap
                  left: 10, // Adds margin to center the container
                  right: 10, // Adds margin to center the container
                  child: Container(
                    width: screenWidth -
                        40, // Reduces width to fit within the screen
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.4), // Shadow color with opacity
                          offset: Offset(0, 4), // Shadow offset (x, y)
                          blurRadius: 8, // Blur radius
                          spreadRadius: 0, // Spread radius
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Balance',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.dollarSign, size: 15),
                                  SizedBox(width: 5),
                                  Text('18',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Rewards',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.dollarSign, size: 15),
                                  SizedBox(width: 5),
                                  Text('10.25',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Trips',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  SizedBox(width: 5),
                                  Text('189',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Choose Your Transport text
                Positioned(
                  top: 290,
                  left: 10,
                  child: Text(
                    'Choose Your Transport',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            // Transport options container
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // Container with text overlay for the first image
                  Container(
                    width: screenWidth - 20, // Adjusted for padding
                    height: 180,
                    decoration: BoxDecoration(
                      color:
                          Color.fromRGBO(58, 158, 194, 3), // Background color
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/bus2.png',
                              fit: BoxFit
                                  .fill, // Ensures the entire image is visible
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 140,
                          child: Text(
                            'Bus',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Container(
                            width: 60,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  10), // Set the border radius here
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Select',
                              style: TextStyle(
                                  color: Colors
                                      .black), // Optional: Adjust text color if needed
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  // Container with text overlay for the second image
                  Container(
                    width: screenWidth - 20, // Adjusted for padding
                    height: 180,
                    decoration: BoxDecoration(
                      color:
                          Color.fromRGBO(58, 158, 194, 3), // Background color
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/train1.png',
                              fit: BoxFit.fill,
                              width: 100,
                              height:
                                  100, // Ensures the entire image is visible
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Text(
                            'MRT',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          left: 10,
                          child: Container(
                            width: 60,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  10), // Set the border radius here
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Select',
                              style: TextStyle(
                                  color: Colors
                                      .black), // Optional: Adjust text color if needed
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color.fromRGBO(58, 158, 194, 3),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: '',
          ),
        ],
      ),
    );
  }
}
