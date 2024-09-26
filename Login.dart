import 'package:flutter/material.dart';
import 'package:myfl/Temp1/Schedules.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myfl/Temp1/TicketBooking.dart'; // Ensure this import is correct for your project

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

Future<void> _login() async {
  if (_formKey.currentState?.validate() ?? false) {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Check if the username and password are correct
    if (username == 'sabeer' && password == 'sabeer008') {
      // Retrieve the list of current cards
      List<CurrentCard> cards = await CurrentCardPreferences.getCards();

       print(cards);
      // Find the card matching the username
      CurrentCard? currentCard;
      try {
        currentCard = cards.firstWhere(
          (card) => card.name == username,
        );
        // int amount=currentCard.Amount as int;
        //   await CurrentCardPreferences.deleteCard(amount);
      } catch (e) {
        // Handle case where no card matches
        currentCard = null;
      }

      // If no card was found, show a snack bar and navigate with null or default card
      if (currentCard == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No card found for this username')),
        );
      }
 
      // Navigate to the next page with the found card or null
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicketBooking(currentCard: currentCard),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 158, 194, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _login,
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 36),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          // This should navigate to a password recovery page or similar
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
