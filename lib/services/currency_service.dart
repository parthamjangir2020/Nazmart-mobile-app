import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/view/utils/api_url.dart';

class CurrencyService with ChangeNotifier {
  String currency = '\$';
  bool alreadyLoaded = false;

  fetchCurrency() async {
    if (alreadyLoaded == false) {
      var response = await http.get(Uri.parse(ApiUrl.currencyUri));
      if (response.statusCode == 201) {
        currency = jsonDecode(response.body)['symbol'];
        alreadyLoaded == true;
        notifyListeners();
      } else {
        print('failed loading currency');
        print(response.body);
      }
    } else {
      //already loaded from server. no need to load again
    }
  }
}
