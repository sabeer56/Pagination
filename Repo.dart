import 'dart:convert';

import 'package:myfl/Temp1/Locations.dart';
import 'package:myfl/Temp1/Schedules.dart';

String? jsonString ;
   String? jsonData;
   dynamic results;
    dynamic results2;
void addLocations() {
  // Your JSON string
 jsonString = '''
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

  // Parsing the JSON string
  Locations locations = LocationsFromJson(jsonString!);
  results=locations;
  // Printing the parsed data
  print(locations.locations.map((loc) => '${loc.name}: (${loc.latitude}, ${loc.longitude})').join('\n'));
}
  
  void addSchedule() {
     jsonData = '''
    {
      "schedules": [
        {
          "from": "Chennai",
          "to": "Coimbatore",
          "schedule": [
            { "departure": "08:00", "arrival": "11:00", "price": 200 },
            { "departure": "14:00", "arrival": "17:00", "price": 200 }
          ]
        },
        {
          "from": "Chennai",
          "to": "Madurai",
          "schedule": [
            { "departure": "07:00", "arrival": "12:00", "price": 250 },
            { "departure": "15:00", "arrival": "20:00", "price": 250 }
          ]
        },
        {
          "from": "Bengaluru",
          "to": "Mysuru",
          "schedule": [
            { "departure": "09:00", "arrival": "11:00", "price": 150 },
            { "departure": "16:00", "arrival": "18:00", "price": 150 }
          ]
        },
        {
          "from": "Hyderabad",
          "to": "Warangal",
          "schedule": [
            { "departure": "10:00", "arrival": "12:00", "price": 180 },
            { "departure": "13:00", "arrival": "15:00", "price": 180 }
          ]
        },
        {
          "from": "Visakhapatnam",
          "to": "Vijayawada",
          "schedule": [
            { "departure": "06:00", "arrival": "08:00", "price": 160 },
            { "departure": "12:00", "arrival": "14:00", "price": 160 }
          ]
        }
      ]
    }
    ''';

    Schedules schedules = SchedulesFromJson(jsonData!);
  results2=schedules;
    // For demonstration, print out the schedules in JSON format
    print(SchedulesToJson(schedules));
}
String getSchedules() {
  // Ensure `jsonData` is the raw JSON data (e.g., a JSON string)
   String schedules=SchedulesToJson(results2);  // Replace with actual JSON data source
  return schedules;
}

String getLocations() {
  // Ensure `jsonString` is the raw JSON data (e.g., a JSON string)
 String locations=LocationsToJson(results); // Replace with actual JSON data source
  return locations;
}




  // Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 ListTile(
  //                   leading: GestureDetector(
  //                     onTap: () => _showPaymentDialog('Credit Card'),
  //                     child: Container(
  //                       width: 120,
  //                       height: 35,
  //                       decoration: BoxDecoration(
  //                         color: Colors.blue, // Background color
  //                         borderRadius: BorderRadius.circular(10), // Rounded corners
  //                       ),
  //                       child: Center( // Center text within the container
  //                         child: Text(
  //                           'Credit Card',
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   trailing: Text('Balance: \$XX.XX'),
  //                 ),
  //                 ListTile(
                    // leading: GestureDetector(
                    //   onTap: () => _showPaymentDialog('E-Wallet'),
                    //   child: Container(
                    //     width: 120,
                    //     height: 35,
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey[400], // Background color
                    //       borderRadius: BorderRadius.circular(10), // Rounded corners
                    //     ),
                    //     child: Center( // Center text within the container
                    //       child: Text(
                    //         'E-Wallet',
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
  //                   trailing: Text('Balance: \$XX.XX'),
  //                 ),
  //               ],
  //             ),
  //           ),


  //            Future<void> _showPaymentDialog(String paymentType) async {
  //   final _amountController = TextEditingController();
  //   final _nameController = TextEditingController();
  //   final _cardNumberController = TextEditingController();
  //   final _expiryDateController = TextEditingController();
  //   final _cvvController = TextEditingController();
  //   final _cardAmountController=TextEditingController();
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(paymentType == 'Credit Card' ? 'Credit Card Details' : 'E-Wallet Details'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               if (paymentType == 'Credit Card') ...[
  //                 TextField(
  //                   controller: _nameController,
  //                   decoration: InputDecoration(labelText: 'Cardholder Name'),
  //                 ),
  //                 TextField(
  //                   controller: _cardNumberController,
  //                   decoration: InputDecoration(labelText: 'Card Number'),
  //                   keyboardType: TextInputType.number,
  //                 ),
  //                 TextField(
  //                   controller: _expiryDateController,
  //                   decoration: InputDecoration(labelText: 'Expiry Date (MM/YY)'),
  //                 ),
  //                 TextField(
  //                   controller: _cvvController,
  //                   decoration: InputDecoration(labelText: 'CVV'),
  //                   keyboardType: TextInputType.number,
  //                 ),
  //                  TextField(
  //                   controller: _cardAmountController,
  //                   decoration: InputDecoration(labelText: 'Amount'),
  //                   keyboardType: TextInputType.number,
  //                 ),
  //               ] else ...[
  //                 TextField(
  //                   controller: _amountController,
  //                   decoration: InputDecoration(labelText: 'Amount'),
  //                   keyboardType: TextInputType.number,
  //                 ),
  //               ],
  //               SizedBox(height: 20),
  //               ElevatedButton(
  //                 onPressed: () async {
  //                   // Save amount to shared preferences
  //                   final prefs = await SharedPreferences.getInstance();
  //                   if (paymentType == 'Credit Card') {
  //                     // Handle Credit Card payment
  //                     print('Credit Card Payment:');
  //                     print('Name: ${_nameController.text}');
  //                     print('Card Number: ${_cardNumberController.text}');
  //                     print('Expiry Date: ${_expiryDateController.text}');
  //                     print('CVV: ${_cvvController.text}');
  //                    print('Amount: ${_cardAmountController.text}');
  //                     // Clear fields or handle payment pr ocessing
  //                   } else {
  //                     // Handle E-Wallet payment
  //                     final amount = _amountController.text;
  //                     print('E-Wallet Payment: Amount: \$${amount}');
  //                     await prefs.setString('ewallet_amount', amount);
  //                     // Clear fields or handle payment processing
  //                   }
  //                   Navigator.of(context).pop(); // Close the dialog
  //                 },
  //                 child: Text('Submit'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }