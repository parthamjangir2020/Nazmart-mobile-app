// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ChangePassService with ChangeNotifier {
  bool isloading = false;

  String? otpNumber;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  changePassword(
      currentPass, newPass, repeatNewPass, BuildContext context) async {
    var ln = Provider.of<TranslateStringService>(context, listen: false);

    if (newPass != repeatNewPass) {
      showToast(ln.getString(ConstString.makeSureRepeatedPassCorrectly),
          Colors.black);
      return;
    }

    //check internet connection
    var connection = await checkConnection();
    if (!connection) return;
    //internet connection is on
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
    var data = {'current_password': currentPass, 'new_password': newPass};

    setLoadingTrue();

    var response = await http.post(Uri.parse(ApiUrl.changePassUri),
        headers: header, body: data);

    print(response.body);

    if (response.statusCode == 200) {
      showToast(
          ln.getString(ConstString.passChangedSuccessfully), Colors.black);
      setLoadingFalse();

      prefs.setString("pass", newPass);

      Navigator.pop(context);
    } else {
      print(response.body);

      showToast(jsonDecode(response.body)['message'], Colors.black);

      setLoadingFalse();
    }
  }
}
