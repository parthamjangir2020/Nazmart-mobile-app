// ignore_for_file: prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/view/utils/config.dart';

class PrivacyTermsService with ChangeNotifier {
  var termsData;
  var privacyData;

  fetchTerms(BuildContext context) async {
    if (termsData != null) return;

    var connection = await checkConnection();
    if (!connection) return;

    var response =
        await http.get(Uri.parse('$baseApi/terms-and-condition-page'));

    if (response.statusCode == 200) {
      termsData = jsonDecode(response.body)['page_content'];
      notifyListeners();
    }
  }

//============>

  fetchPrivacyData(BuildContext context) async {
    if (privacyData != null) return;

    var connection = await checkConnection();
    if (!connection) return;

    var response = await http.get(Uri.parse('$baseApi/privacy-policy-page'));

    if (response.statusCode == 200) {
      privacyData = jsonDecode(response.body)['page_content'];
      notifyListeners();
    }
  }
}
