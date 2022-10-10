import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/services/support_ticket_service.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateTicketService with ChangeNotifier {
  bool isLoading = false;
  //priority dropdown
  var priorityDropdownList = ['Low', 'High', 'Medium', 'Urgent'];
  var priorityDropdownIndexList = ['Low', 'High', 'Medium', 'Urgent'];
  var selectedPriority = 'Low';
  var selectedPriorityId = 'Low';

  setPriorityValue(value) {
    selectedPriority = value;
    notifyListeners();
  }

  setSelectedPriorityId(value) {
    selectedPriorityId = value;
    notifyListeners();
  }

  bool hasError = false;

  //create ticket ====>

  createTicket(
      title, subject, priority, description, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var data = jsonEncode({
      'title': title,
      'subject': subject,
      'priority': priority,
      'description': description,
    });

    var connection = await checkConnection();
    if (connection) {
      isLoading = true;
      notifyListeners();
      //if connection is ok
      var response = await http.post(Uri.parse('$baseApi/user/ticket/create'),
          headers: header, body: data);
      isLoading = false;
      notifyListeners();
      if (response.statusCode == 201) {
        OthersHelper().showToast('Ticket created successfully', Colors.black);

        //add ticket to ticket list
        Provider.of<SupportTicketService>(context, listen: false)
            .addNewDataToTicketList(jsonDecode(response.body)['ticket']['id'],
                title, subject, priority, description, 'open');

        //======>
        Navigator.pop(context);
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
        print('ticket create failed ${response.body}');
      }
    }
  }
}
