import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';

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
    if (newPass != repeatNewPass) {
      showToast('Make sure you repeated new password correctly', Colors.black);
    } else {
      //check internet connection
      var connection = await checkConnection();
      if (connection) {
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

        var response = await http.post(
            Uri.parse('$baseApi/user/change-password'),
            headers: header,
            body: data);

        if (response.statusCode == 200) {
          showToast("Password changed successfully", primaryColor);
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
  }
}
