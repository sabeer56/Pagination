import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Temp1LocationPage.dart';
import 'Template1.dart';

class PersonalPage extends StatefulWidget {
  @override
  PersonalPageState createState() => PersonalPageState();
}

class PersonalPageState extends State<PersonalPage> {
  int _currentIndex = 1; // Index for the selected bottom navigation item

  void _onItemTapped(int index) {
    if (_currentIndex == index) return; // Avoid navigating to the same page

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TicketBooking()),
        );
        break;
      case 1:
        // Already on PersonalPage, do nothing
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocationPage()),
        );
        break;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        // Wrap the entire body with SingleChildScrollView
        child: Column(
          children: [
            Stack(
              children: [
                // Blue Container
                Container(
                  width: double.infinity,
                  height: 500,
                  color: Color.fromRGBO(58, 158, 194, 3),
                ),
                Positioned.fill(
                  bottom: 240,
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
                  top: 250,
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
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.4), // Shadow color with opacity
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
                                    decoration: InputDecoration(
                                      labelText: 'Enter your text',
                                      border: OutlineInputBorder(),
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
                                    decoration: InputDecoration(
                                      labelText: 'Enter your text',
                                      border: OutlineInputBorder(),
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
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
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
                                text: '10:00 ',
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
                                text: '10:30 ',
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
                          '5.5',
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
                          child: Text('Lorem MRT Station'),
                        ),
                        Container(
                          width: 60,
                          height: 20,
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
                      ],
                    ),
                  ],
                ),
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
