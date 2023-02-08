import 'package:flutter/material.dart';

class TicketStatusDropdownService with ChangeNotifier {
  var statusDropdownList = ['Open', 'Close'];
  var statusDropdownIndexList = ['Open', 'Close'];
  var selectedstatus = 'Open';
  var selectedstatusId = 'Open';

  setstatusValue(value) {
    selectedstatus = value;
    notifyListeners();
  }

  setSelectedstatusId(value) {
    selectedstatusId = value;
    notifyListeners();
  }
}
