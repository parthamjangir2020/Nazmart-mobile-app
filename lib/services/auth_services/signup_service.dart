import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

import '../../view/auth/signup/components/email_verify_page.dart';
import '../common_service.dart';
import '../country_states_service.dart';
import 'email_verify_service.dart';

class SignupService with ChangeNotifier {
  bool isloading = false;

  String phoneNumber = '0';
  String countryCode = 'IN';

  setPhone(value) {
    phoneNumber = value;
    notifyListeners();
  }

  setCountryCode(code) {
    countryCode = code;
    notifyListeners();
  }

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future signup(
    String fullName,
    String userName,
    String email,
    String password,
    String city,
    BuildContext context,
  ) async {
    var connection = await checkConnection();

    var selectedCountryId =
        Provider.of<CountryStatesService>(context, listen: false)
            .selectedCountryId;
    // var selectedStateId =
    //     Provider.of<CountryStatesService>(context, listen: false)
    //         .selectedStateId;
    // var selectedAreaId =
    //     Provider.of<CountryStatesService>(context, listen: false)
    //         .selectedAreaId;
    if (connection) {
      setLoadingTrue();
      var data = jsonEncode({
        'full_name': fullName,
        'username': userName,
        'email': email,
        'city': city,
        'password': password,
        'country_id': selectedCountryId,
      });
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json"
      };

      var response = await http.post(Uri.parse('$baseApi/register'),
          body: data, headers: header);
      print(response.body);
      if (response.statusCode == 200) {
        print(response.statusCode);
        showToast("Registration successful", successColor);

        print('token is ${jsonDecode(response.body)['token']}');
        String token = jsonDecode(response.body)['token'];

        int userId = jsonDecode(response.body)['users']['id'];

        //Send otp
        var isOtepSent =
            await Provider.of<EmailVerifyService>(context, listen: false)
                .sendOtpForEmailValidation(email, context, token);
        setLoadingFalse();
        if (isOtepSent) {
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => EmailVerifyPage(
                email: email,
                pass: password,
                token: token,
                userId: userId,
                countryId: selectedCountryId,
              ),
            ),
          );
        } else {
          showToast('Otp send failed', Colors.black);
        }

        return true;
      } else {
        //Sign up unsuccessful ==========>
        print(response.body);

        if (jsonDecode(response.body).containsKey('validation_errors')) {
          showError(jsonDecode(response.body)['validation_errors']);
        } else {
          showToast(jsonDecode(response.body)['message'], Colors.black);
        }

        setLoadingFalse();
        return false;
      }
    } else {
      //internet connection off
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
      showToast(error['password'][0], Colors.black);
    } else {
      showToast('Something went wrong', Colors.black);
    }
  }
}
