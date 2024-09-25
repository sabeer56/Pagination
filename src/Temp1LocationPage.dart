import 'dart:io'; // For Platform
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For FontAwesomeIcons

// Import necessary packages for your other pages
import 'Template1.dart';
import 'Temp1PersonalPage.dart';

class LocationPage extends StatefulWidget {
  @override
  LocationPageState createState() => LocationPageState();
}

class LocationPageState extends State<LocationPage> {
  int _currentIndex = 0; // Index for the selected bottom navigation item

  void _scanQRCode() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRViewExample(),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == _currentIndex) return; // Prevent navigating to the same page
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
      _currentIndex = index; // Update the current index for the bottom navigation bar
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 450,
                  color: Colors.blue,
                ),
                Positioned(
                  top: 20,
                  left: 100,
                  child: Container(
                    width: 200,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Ticket',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 180,
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
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                        boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3), // Shadow color with opacity
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
                          subtitle: Text('Lorem MRT Station'),
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
                          subtitle: Text('Dolor MRT Station'),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            FaIcon(
                              FontAwesomeIcons.clock,
                              size: 17,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '10:00  ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: FaIcon(
                                      FontAwesomeIcons.train,
                                      size: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '  10:30  ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                         SizedBox(width: 100,),
                            GestureDetector(
                              onTap: _scanQRCode,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black),
                                ),
                                alignment: Alignment.bottomLeft,
                                child: Image.asset(
                                  'assets/qr_code_image.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            FaIcon(
                              FontAwesomeIcons.locationPin,
                              size: 17,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text('Lorem MRT Station'),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            FaIcon(
                              FontAwesomeIcons.clock,
                              size: 17,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: FaIcon(FontAwesomeIcons.dollarSign, size: 17),
                                    ),
                                    TextSpan(
                                      text: ' 5.5',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 130,
                  left: 47,
                  child: Container(
                    width: 1,
                    height: 40,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Enter Amount',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Light grey background
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey), // Optional border
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: FaIcon(FontAwesomeIcons.dollarSign, size: 16),
                        border: InputBorder.none,
                        hintText: 'Enter amount',
                        filled: true,
                        fillColor: Colors.grey[200], // Light grey background
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Container( 
                      width: 120,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.blue, // Background color
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                      child: Center( // Center text within the container
                        child: Text(
                          'Credit Card',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    trailing: Text('Balance: \$XX.XX'),
                  ),
                  ListTile(
                    leading: Container( 
                      width: 120,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.grey[400], // Background color
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                      child: Center( // Center text within the container
                        child: Text(
                          'E-Wallet',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    trailing: Text('Balance: \$XX.XX'),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth - 60,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue, // Background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: TextButton(
                onPressed: () {}, 
                child: Text('Buy Ticket', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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

class QRViewExample extends StatefulWidget {
  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller?.pauseCamera();
    }
    _controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    _controller?.scannedDataStream.listen((scanData) {
      // Handle scan data
      print('Scanned QR Code: ${scanData.code}');
      Navigator.pop(context); // Close the scanner after scanning
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}