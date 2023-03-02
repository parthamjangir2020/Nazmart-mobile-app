// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/services/dropdown_services/ticket_status_dropdown_service.dart';
import 'package:no_name_ecommerce/services/ticket_services/support_ticket_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeTicketStatusService with ChangeNotifier {
  bool isloading = false;

  setLoadingStatus(bool status) {
    isloading = status;
    notifyListeners();
  }

  Future<bool> changeStatus(BuildContext context, {required id}) async {
    var connection = await checkConnection();
    if (!connection) return false;

    var status =
        Provider.of<TicketStatusDropdownService>(context, listen: false)
            .selectedstatus;

    setLoadingStatus(true);

    var data = jsonEncode({
      'id': id,
      'status': status,
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var response = await http.post(Uri.parse(ApiUrl.ticketStatusChangeUri),
        body: data, headers: header);

    if (response.statusCode == 200) {
      Provider.of<SupportTicketService>(context, listen: false).setDefault();

      await Provider.of<SupportTicketService>(context, listen: false)
          .fetchTicketList(context);

      showToast('Status changed', Colors.black);

      Navigator.pop(context);

      setLoadingStatus(false);

      return true;
    } else {
      setLoadingStatus(false);

      return false;
    }
  }
}
