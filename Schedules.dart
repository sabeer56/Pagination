import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class ScheduleDetail {
  final String departure;
  final String arrival;
  final int price;

  ScheduleDetail({required this.departure, required this.arrival, required this.price});

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) {
    return ScheduleDetail(
      departure: json['departure'],
      arrival: json['arrival'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departure': departure,
      'arrival': arrival,
      'price': price,
    };
  }
}

class Schedule {
  final String from;
  final String to;
  final List<ScheduleDetail> schedule;

  Schedule({required this.from, required this.to, required this.schedule});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    var list = json['schedule'] as List;
    List<ScheduleDetail> scheduleList = list.map((i) => ScheduleDetail.fromJson(i)).toList();
    return Schedule(
      from: json['from'],
      to: json['to'],
      schedule: scheduleList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'schedule': schedule.map((detail) => detail.toJson()).toList(),
    };
  }
}

class Schedules {
  final List<Schedule> schedules;

  Schedules({required this.schedules});

  factory Schedules.fromJson(Map<String, dynamic> json) {
    var list = json['schedules'] as List;
    List<Schedule> schedulesList = list.map((i) => Schedule.fromJson(i)).toList();
    return Schedules(schedules: schedulesList);
  }

  Map<String, dynamic> toJson() {
    return {
      'schedules': schedules.map((schedule) => schedule.toJson()).toList(),
    };
  }

  String toJsonString() {
    return jsonEncode(this.toJson());
  }
}

Schedules SchedulesFromJson(String str) => Schedules.fromJson(jsonDecode(str));
String SchedulesToJson(Schedules data) => data.toJsonString();
class SelectedSchedule {
  final String from;
  final String to;
  final String departure;
  final String arrival;
  final String price;

  SelectedSchedule({
    required this.from,
    required this.to,
    required this.departure,
    required this.arrival,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'departure': departure,
      'arrival': arrival,
      'price': price,
    };
  }

  factory SelectedSchedule.fromJson(Map<String, dynamic> json) {
    return SelectedSchedule(
      from: json['from'],
      to: json['to'],
      departure: json['departure'],
      arrival: json['arrival'],
      price: json['price'],
    );
  }
}


CurrentCard CurrentCardFromJson(String str) => CurrentCard.fromJson(jsonDecode(str));
String CurrentCardToJson(Schedules data) => data.toJsonString();

class CurrentCard {
  final String name;
  final String cardNumber;
  final String ExpiryDate;
  final String CVV;
   num Amount;

  CurrentCard({
    required this.name,
    required this.cardNumber,
    required this.ExpiryDate,
    required this.CVV,
    required this.Amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cardNumber': cardNumber,
      'ExpiryDate': ExpiryDate,
      'CVV': CVV,
      'Amount': Amount,
    };
  }

  factory CurrentCard.fromJson(Map<String, dynamic> json) {
    return CurrentCard(
      name: json['name'],
      cardNumber: json['cardNumber'],
      ExpiryDate: json['ExpiryDate'],
      CVV: json['CVV'],
      Amount: json['Amount'],
    );
  }
}


class CurrentCardPreferences {
  static const String _cardKey = 'user_key';

 static Future<List<CurrentCard>> getCards() async {
  final prefs = await SharedPreferences.getInstance();
  final cardsJson = prefs.getString(_cardKey);
  print('Retrieved cards JSON: $cardsJson'); // Debugging line
  if (cardsJson != null) {
    final List<dynamic> cardsList = jsonDecode(cardsJson);
    print('Parsed cards list: $cardsList'); // Debugging line
    return cardsList.map((json) => CurrentCard.fromJson(json as Map<String, dynamic>)).toList();
  }
  return [];
}

static Future<void> addCard(CurrentCard card) async {
  final prefs = await SharedPreferences.getInstance();
  List<CurrentCard> cards = await CurrentCardPreferences.getCards();
  
  // Convert card data to JSON and add to the list
  cards.add(card);
  String cardsJson = jsonEncode(cards.map((c) => c.toJson()).toList());
  
  // Save updated list to SharedPreferences
  await prefs.setString(_cardKey, cardsJson);
}
   static Future<void> updateCard(CurrentCard updatedCard) async {
    final prefs = await SharedPreferences.getInstance();
    List<CurrentCard> cards = await getCards();

    // Find the index of the card to update
    final index = cards.indexWhere((card) => card.name == updatedCard.name);
     print(index);
    if (index != -1) {
      // Update the existing card
      cards[index] = updatedCard;
    } else {
      // Add the new card if it doesn't exist
      cards.add(updatedCard);
    }

    // Save the updated list to SharedPreferences
    await saveCards(cards);
  }
    static Future<void> saveCards(List<CurrentCard> cards) async {
    final prefs = await SharedPreferences.getInstance();
    final cardsJson = jsonEncode(cards.map((c) => c.toJson()).toList());
    await prefs.setString(_cardKey, cardsJson);
  }
  static Future<void> deleteCard(int Amount) async {
    final prefs = await SharedPreferences.getInstance();
    List<CurrentCard> cards = await getCards();

    // Remove the card with the given cardNumber
    cards.removeWhere((card) => card.Amount == Amount);

    // Save the updated list back to SharedPreferences
    await saveCards(cards);
  }
}