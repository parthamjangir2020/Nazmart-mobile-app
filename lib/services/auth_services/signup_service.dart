// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/bottom_nav_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

import '../../view/auth/signup/components/email_verify_page.dart';
import '../common_service.dart';
import '../country_states_service.dart';
import 'email_verify_service.dart';

class SignupService with ChangeNotifier {
  bool isloading = false;

  setLoadingStatus(bool status) {
    isloading = status;
    notifyListeners();
  }

  Future<bool> signup(BuildContext context,
      {required userName,
      required password,
      required fullName,
      required email,
      required mobile,
      required cityName,
      bool isFromDeliveryAddressPage = false}) async {
    var connection = await checkConnection();

    var countryName = Provider.of<CountryStatesService>(context, listen: false)
        .selectedCountry;
    var stateName =
        Provider.of<CountryStatesService>(context, listen: false).selectedState;
    if (stateName == 'Select State') {
      stateName = null;
    }

    if (!connection) return false;

    setLoadingStatus(true);

    var data = jsonEncode({
      'username': userName,
      'password': password,
      'full_name': fullName,
      'email': email,
      'mobile': mobile,
      'country_name': countryName,
      'city_name': cityName,
      'state_name': stateName,
      'terms_conditions': 'on'
    });
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var response = await http.post(Uri.parse(ApiUrl.registerUri),
        body: data, headers: header);

    print(response.body);

    setLoadingStatus(false);

    if (response.statusCode == 200) {
      showToast("Registration successful", successColor);

      print('token is ${jsonDecode(response.body)['token']}');
      String token = jsonDecode(response.body)['token'];

      int userId = jsonDecode(response.body)['users']['id'];

      if (isFromDeliveryAddressPage) return true;

      //Send otp
      var isOtepSent =
          await Provider.of<EmailVerifyService>(context, listen: false)
              .sendOtpForEmailValidation(email, context, token);

      if (isOtepSent) {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => EmailVerifyPage(
              email: email,
              pass: password,
              token: token,
              userId: userId,
            ),
          ),
        );
      } else {
        showToast('Otp send failed', Colors.black);
      }

      Provider.of<BottomNavService>(context, listen: false).resetIndex();

      return true;
    } else {
      //Sign up unsuccessful ==========>
      print(response.body);

      if (jsonDecode(response.body).containsKey('validation_errors')) {
        showError(jsonDecode(response.body)['validation_errors']);
      } else {
        showToast(jsonDecode(response.body)['message'], Colors.black);
      }

      return false;
    }
  }

  showError(error) {
    if (error.containsKey('email')) {
      showToast(error['email'][0], Colors.black);
    } else if (error.containsKey('username')) {
      showToast(error['username'][0], Colors.black);
    } else if (error.containsKey('phone')) {
      showToast(error['phone'][0], Colors.black);
    } else if (error.containsKey('password')) {
      showToast(error['password'][0], Colors.black);
    } else if (error.containsKey('message')) {
      showToast(error['message'][0], Colors.black);
    } else if (error.containsKey('mobile')) {
      showToast(error['mobile'][0], Colors.black);
    } else {
      showToast('Something went wrong', Colors.black);
    }
  }

  //live check username

  var usernameData;

  checkUsername(username, BuildContext context) async {
    //check internet connection
    var connection = await checkConnection();
    if (!connection) return;

    var data = {'username': username};

    var response =
        await http.post(Uri.parse(ApiUrl.usernameCheckUri), body: data);

    if (response.statusCode == 200) {
      usernameData = jsonDecode(response.body)['msg'];
      notifyListeners();
    } else {
      print(response.body);
    }
  }
}
