import 'dart:io'; // For Platform
import 'package:flutter/material.dart';
import 'package:myfl/Temp1/Schedules.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For FontAwesomeIcons
import 'package:shared_preferences/shared_preferences.dart'; // For SharedPreferences

// Import necessary packages for your other pages
import 'TicketBooking.dart';
import 'TicketBookingPersonalPage.dart';

class LocationPage extends StatefulWidget {
  final SelectedSchedule selectedSchedule;
  final CurrentCard? currentCard;
 
  LocationPage({required this.selectedSchedule, this.currentCard});
  
  @override
  LocationPageState createState() => LocationPageState();
}

class LocationPageState extends State<LocationPage> {
  int _currentIndex = 0; // Index for the selected bottom navigation item
  String _selectedPaymentMethod = ''; // Store selected payment method
  final TextEditingController _amountController = TextEditingController();

  double _eWalletBalance = 0.0;

  void _scanQRCode() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRViewExample(),
      ),
    );
  }

  @override
void initState() {
  super.initState();
  _loadBalances();
}

Future<void> _loadBalances() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    _eWalletBalance = prefs.getDouble('ewallet_amount') ?? 0.0;
    // Load credit card balance if needed
  });
}

Future<void> _showPaymentDialog1(String paymentType) async {
  if(widget.currentCard!=null)
  {
    paymentType == 'Credit Card' ? 'Credit Card' : 'E-Wallet';
    _selectedPaymentMethod=paymentType;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment Method Is Clicked ')),
      );
    return;
  }
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
  
      final _nameController = TextEditingController();
      final _cardNumberController = TextEditingController();
      final _expiryDateController = TextEditingController();
      final _cvvController = TextEditingController();
      final _cardAmountController = TextEditingController();

      return AlertDialog(
        title: Text(paymentType == 'Credit Card' ? 'Credit Card Details' : 'E-Wallet Details'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              if (paymentType == 'Credit Card') ...[
                if (widget.currentCard == null) ...[
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Cardholder Name'),
                  ),
                  TextField(
                    controller: _cardNumberController,
                    decoration: InputDecoration(labelText: 'Card Number'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _expiryDateController,
                    decoration: InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                  ),
                  TextField(
                    controller: _cvvController,
                    decoration: InputDecoration(labelText: 'CVV'),
                    keyboardType: TextInputType.number,
                  ),
                ],
                TextField(
                  controller: _cardAmountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
              ] 
              else if(paymentType=='E-Wallet') ...[
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  if (paymentType == 'Credit Card') {
                    if (widget.currentCard == null) {
                      // Handle adding a new credit card
                      List<CurrentCard> cards = await CurrentCardPreferences.getCards();
                      bool existingCard = cards.any((card) => card.cardNumber == _cardNumberController.text);

                      if (!existingCard) {
                        CurrentCard newCard = CurrentCard(
                          name: _nameController.text,
                          cardNumber: _cardNumberController.text,
                          ExpiryDate: _expiryDateController.text,
                          CVV: _cvvController.text,
                          Amount: double.parse(_cardAmountController.text),
                        );
                        await CurrentCardPreferences.addCard(newCard);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Card already exists.')),
                        );
                      }
                    }
                    // Proceed with payment using the selected card or newly added card
                  } else if (paymentType == 'E-Wallet') {
                    // Handle E-Wallet payment
                    final amount = double.parse(_amountController.text);
                    print('E-Wallet Payment: Amount: \$${amount}');
                    await prefs.setDouble('ewallet_amount', amount);
                    // Clear fields or handle payment processing
                  }
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> _showPaymentDialog(String paymentType) async {
  final amount = double.tryParse(_amountController.text) ?? 0.0;

  if (paymentType == 'Credit Card') {
    if (widget.currentCard == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please add a credit card first.')),
      );
      return;
    }

    if (amount > widget.currentCard!.Amount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Insufficient credit card balance.')),
      );
      return;
    }

    // Update credit card balance
    final newCardAmount = widget.currentCard!.Amount - amount;
    widget.currentCard!.Amount = newCardAmount;

    // Save the updated card details
    await CurrentCardPreferences.updateCard(widget.currentCard!);
   ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ticket is Booked')),
      );
  } else if(paymentType=='E-Wallet') {
    if (amount > _eWalletBalance) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Insufficient e-wallet balance.')),
      );
      return;
    }

    // Update e-wallet balance
    final prefs = await SharedPreferences.getInstance();
    final newWalletBalance = _eWalletBalance - amount;
    await prefs.setDouble('ewallet_amount', newWalletBalance);
  }

  // Show success dialog
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Payment Successful'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Schedule Details:'),
            Text('From: ${widget.selectedSchedule.from}'),
            Text('To: ${widget.selectedSchedule.to}'),
            Text('Departure: ${widget.selectedSchedule.departure}'),
            Text('Arrival: ${widget.selectedSchedule.arrival}'),
            Text('Price: ${widget.selectedSchedule.price}'),
            SizedBox(height: 20),
            Image.asset('assets/qr_code_image.png'), // Replace with actual QR code image
            Text('Your QR code to show to the driver'),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Download QR Code'),
            onPressed: () {
              // Implement QR code download functionality if needed
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => LocationPage(
      selectedSchedule: widget.selectedSchedule,
      currentCard: widget.currentCard ?? null, // or simply use `null` if you want to pass `null`
    ),
  ),
);

            },
          ),
        ],
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final selectedSchedule = widget.selectedSchedule;

    return Scaffold(
      body: SingleChildScrollView(
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
                          subtitle: Text(selectedSchedule.from),
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
                          subtitle: Text(selectedSchedule.to),
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
                                    text: selectedSchedule.departure+" ",
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
                                    text: " "+selectedSchedule.arrival,
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
                              child: Text(selectedSchedule.to),
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
                                      text: selectedSchedule.price,
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
    controller: _amountController,
    decoration: InputDecoration(
      icon: FaIcon(FontAwesomeIcons.dollarSign, size: 16),
      border: InputBorder.none,
      hintText: 'Enter amount',
      filled: true,
      fillColor: Colors.grey[200], // Light grey background
    ),
    keyboardType: TextInputType.number,
    
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
                    leading: GestureDetector(
                      onTap: () => _showPaymentDialog1('Credit Card'),
                      child: Container(
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
                    ),
                    trailing: Text(widget.currentCard != null 
                      ? 'Balance: \$${widget.currentCard!.Amount}'
                      : 'Add Card'),
                  ),
                  ListTile(
                    leading: GestureDetector(
                      onTap: () => _showPaymentDialog1('E-Wallet'),
                      child: Container(
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
                    ),
                    trailing: Text('Balance: \$${_eWalletBalance.toStringAsFixed(2)}'),
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
    onPressed: () {
      if(_selectedPaymentMethod.isEmpty){
 ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Select The Payment Method')),
      );
      }else{
      _showPaymentDialog(_selectedPaymentMethod);
      }
    },
    child: Text('Buy Ticket', style: TextStyle(color: Colors.white)),
  ),
),

          ],
        ),
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
