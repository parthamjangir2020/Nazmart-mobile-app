// ignore_for_file: use_build_context_synchronously

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/bottom_nav_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/auth/login/login.dart';
import '../common_service.dart';

class LogoutService with ChangeNotifier {
  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  logout(BuildContext context) async {
    var connection = await checkConnection();
    if (connection) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        // "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      setLoadingTrue();
      var response = await http.post(
        Uri.parse(ApiUrl.logoutUri),
        headers: header,
      );
      setLoadingFalse();
      if (response.statusCode == 200) {
        notifyListeners();

//pop sidebar
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const LoginPage(),
          ),
          (route) => false,
        );

        // clear profile data =====>
        Future.delayed(const Duration(microseconds: 5500), () {
          Provider.of<ProfileService>(context, listen: false)
              .setEverythingToDefault();
        });

        //set landing page index to 0
        Provider.of<BottomNavService>(context, listen: false)
            .setCurrentIndex(0);

        clear();
      } else {
        print(response.body);
        showToast('Something went wrong', Colors.black);
      }
    }
  }

  //clear saved email, pass and token
  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
