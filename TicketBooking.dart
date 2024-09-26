import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfl/Temp1/Schedules.dart';
import 'TicketBookingLocationPage.dart';
import 'TicketBookingPersonalPage.dart';

class TicketBooking extends StatefulWidget {
  final CurrentCard? currentCard;
  TicketBooking({ this.currentCard});
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<TicketBooking> {
  int _currentIndex = 0; // Index for the selected bottom navigation item
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allTransportOptions = ['BUS', 'MRT'];
  List<String> _filteredTransportOptions = [];

  @override
  void initState() {
    super.initState();
    _filteredTransportOptions = List.from(_allTransportOptions);
  }

  void _onItemTapped(int index) {
    
    setState(() {
      _currentIndex = index; // Update the current index for the bottom navigation bar
    });
  }

  void _filterTransportOptions(String query) {
    final filtered = _allTransportOptions
        .where((option) => option.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _filteredTransportOptions = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Blue Container
                Container(
                  width: double.infinity,
                  height: 350,
                  color: Color.fromRGBO(58, 158, 194, 1),
                ),
                // Yellow Container with overlapping border radius
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
                // Greeting and icon
                Positioned(
                  top: 15,
                  left: 10,
                  child: Text('Hello',
                      style: TextStyle(fontSize: 37, color: Colors.white)),
                ),
                Positioned(
                  top: 15,
                  right: 10,
                  child: Icon(Icons.circle, size: 40, color: Colors.white),
                ),
                // Subtext
                Positioned(
                  top: 70,
                  left: 10,
                  child: Text('Where you will go',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
                // Search TextField
                Positioned(
                  top: 100,
                  left: 10,
                  right: 10,
                  child: Container(
                    width: screenWidth - 20,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        border: InputBorder.none,
                        hintText: 'Search...',
                      ),
                      onChanged: _filterTransportOptions,
                    ),
                  ),
                ),
                // Amber Container with balance details
                Positioned(
                  top: 150,
                  left: 10,
                  right: 10,
                  child: Container(
                    width: screenWidth - 40,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildBalanceDetails('Balance', '18'),
                          _buildBalanceDetails('Rewards', '10.25'),
                          _buildBalanceDetails('Total Trips', '189'),
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
            SizedBox(height: 20), // Gap between Amber Container and Transport options
            // Transport options container
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: _filteredTransportOptions.map((option) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      width: screenWidth - 20,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(58, 158, 194, 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                option == 'BUS'
                                    ? 'assets/bus2.png'
                                    : 'assets/train1.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            bottom: 140,
                            child: Text(
                              option,
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
                              width: 100,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: TextButton(
                                child: Text('Select'),
                                onPressed: () {
                                  if (option == 'MRT') {
                                   Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => PersonalPage(
      currentCard: widget.currentCard ?? null, // or simply use `null` if you want to pass `null`
    ),
  ),
);

                                  }
                                  // Add other navigation or action logic here
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color.fromRGBO(58, 158, 194, 1),
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

  Widget _buildBalanceDetails(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        Row(
          children: [
            FaIcon(FontAwesomeIcons.dollarSign, size: 15),
            SizedBox(width: 5),
            Text(value,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
