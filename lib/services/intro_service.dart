// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';

class IntroService with ChangeNotifier {
  List introDataList = [];

  Future<bool> fetchIntro(BuildContext context) async {
    var connection = await checkConnection();
    if (!connection) return false;

    var response = await http.get(Uri.parse(ApiUrl.introUri));

    if (response.statusCode == 200 &&
        jsonDecode(response.body)['data'].isNotEmpty) {
      introDataList = jsonDecode(response.body)['data'];
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
