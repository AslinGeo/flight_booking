import 'package:flight_booking/constants/assets.dart';
import 'package:flight_booking/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewModel extends ChangeNotifier {
  List<bool> isSelected = [false, true, false];
  List destinationList = [
    'BLR - Bengaluru',
    'DXB - Dubai',
    'LHR - London',
    'JFK - New York',
    'SIN - Singapore',
    'HND - Tokyo',
    'SYD - Sydney',
    'DEL - Delhi',
    'CDG - Paris',
    'CPT - Cape Town',
  ];
  List tours = [
    {
      "imageUrl": AppAssets.tour1,
      "destination": "Saudi Arabia",
      "description": "From AED867"
    },
    {
      "imageUrl": AppAssets.tour2,
      "destination": "Kuwait",
      "description": "From AED867"
    }
  ];
  List passengerList = ['1 Passenger', '2 Passenger', '3 Passenger'];
  List classList = ['Economy Class', 'Business Class', 'First Class'];

  String fromDestination = '';
  String toDestination = '';
  final departureDateController = TextEditingController();
  final returnDateController = TextEditingController();

  void onSelectToggle(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = false;
    }
    isSelected[index] = true;
    notifyListeners();
  }

  void swapDestinations() {
    String temp = fromDestination;
    fromDestination = toDestination;
    toDestination = temp;
    notifyListeners();
  }

  void navigateToSearchList(context) {
    if (fromDestination.isNotEmpty &&
        toDestination.isNotEmpty &&
        departureDateController.text != "" &&
        returnDateController.text != "") {
      Map<String,dynamic> response = {
        "fromDestination": fromDestination,
        "toDestination": toDestination,
        "departureDate": departureDateController.text,
        "returnDate": returnDateController.text,
      };
      router.push('/flightList', extra: response);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields correctly.'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.fixed,
        ),
      );
    }
  }
}
