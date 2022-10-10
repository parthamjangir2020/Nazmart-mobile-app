import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaika/profile/profile_home/ticket/model/department_model.dart';
import 'package:zaika/profile/profile_home/ticket/service/support_ticket_service.dart';
import 'package:zaika/utils/common_service.dart';
import 'package:zaika/utils/others_helper.dart';

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

  //department list dropdown
  var departmentDropdownList = [];
  var departmentDropdownIndexList = [];
  var selectedDepartment;
  var selectedDepartmentId;

  setDepartmentValue(value) {
    selectedDepartment = value;
    notifyListeners();
  }

  setSelectedDepartmentId(value) {
    selectedDepartmentId = value;
    notifyListeners();
  }

  makedepartmentlistEmpty() {
    departmentDropdownList = [];
    departmentDropdownIndexList = [];
    notifyListeners();
  }

  fetchDepartment(BuildContext context) async {
    if (departmentDropdownList.isEmpty) {
      hasError = false;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.get(Uri.parse('$baseApi/user/get-department'),
          headers: header);

      if (response.statusCode == 201) {
        var data = DepartmentModel.fromJson(jsonDecode(response.body));
        for (int i = 0; i < data.data.length; i++) {
          departmentDropdownList.add(data.data[i].name);
          departmentDropdownIndexList.add(data.data[i].id.toString());
        }

        selectedDepartment = departmentDropdownList[0];
        selectedDepartmentId = departmentDropdownIndexList[0];
        notifyListeners();
      } else {
        print('error fetching department list ${response.body}');
        hasError = true;
      }
    } else {
      print('category already loaded');
    }
  }

  //create ticket ====>

  createTicket(title, subject, priority, description, departmentId,
      BuildContext context) async {
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
      'departments': departmentId
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
                title, subject, priority, description, departmentId, 'open');

        //======>
        Navigator.pop(context);
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
        print('ticket create failed ${response.body}');
      }
    }
  }
}
