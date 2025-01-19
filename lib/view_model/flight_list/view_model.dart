import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ViewModel extends ChangeNotifier {
  Map<String, dynamic> searchedFlightDetails = {};

  void setFlightDetails(data) {
    searchedFlightDetails = data;
    notifyListeners();
  }

  formatDate(date) {
  DateTime dateV = DateTime.parse(date);
  String formattedDate = DateFormat('MMM d').format(dateV);
  return formattedDate;
}
}
