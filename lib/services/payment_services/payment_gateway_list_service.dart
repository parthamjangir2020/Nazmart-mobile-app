// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentGatewayListService with ChangeNotifier {
  List paymentList = [];
  bool? isTestMode;
  var publicKey;
  var secretKey;

  var billPlzCollectionName;
  var paytabProfileId;

  var squareLocationId;

  var zitopayUserName;

  bool isloading = false;
  var selectedMethodName;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  setSelectedMethodName(newName) {
    selectedMethodName = newName;
    notifyListeners();
  }

  Future fetchGatewayList() async {
//TODO if no payment gateway is selected by user.
//set default public and secret key

    //if payment list already loaded, then don't load again
    if (paymentList.isNotEmpty) {
      return;
    }

    var connection = await checkConnection();
    if (connection) {
      setLoadingTrue();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "x-api-key": xApiKey,
        "Authorization": "Bearer $token",
      };

      var response =
          await http.get(Uri.parse(ApiUrl.gatewayListUri), headers: header);
      print(response.body);
      setLoadingFalse();

      if (response.statusCode == 201 || response.statusCode == 200) {
        paymentList = jsonDecode(response.body)['data'];
      } else {
        //something went wrong
        print(response.body);
      }
    } else {
      //internet off
      return false;
    }
  }

  //set clientId or secretId
  //==================>
  setKey(String methodName, int index) {
    print('selected method $methodName');
    switch (methodName) {
      case 'paypal':
        if (paymentList[index]['test_mode'] == 1) {
          publicKey = paymentList[index]['credentials']['sandbox_client_id'];
          secretKey =
              paymentList[index]['credentials']['sandbox_client_secret'];
        } else {
          publicKey = paymentList[index]['credentials']['live_client_id'];
          secretKey = paymentList[index]['credentials']['live_client_secret'];
        }

        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        print('client id is $publicKey');
        print('secret id is $secretKey');
        notifyListeners();
        break;

      case 'cashfree':
        publicKey = paymentList[index]['credentials']['app_id'];
        secretKey = paymentList[index]['credentials']['secret_key'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        print('client id is $publicKey');
        print('secret id is $secretKey');
        notifyListeners();
        break;

      case 'flutterwave':
        publicKey = paymentList[index]['credentials']['public_key'];
        secretKey = paymentList[index]['credentials']['secret_key'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'instamojo':
        publicKey = paymentList[index]['credentials']['client_id'];
        secretKey = paymentList[index]['credentials']['client_secret'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'marcadopago':
        publicKey = paymentList[index]['credentials']['client_id'];
        secretKey = paymentList[index]['credentials']['client_secret'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'midtrans':
        publicKey = paymentList[index]['credentials']['merchant_id'];
        secretKey = paymentList[index]['credentials']['server_key'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'mollie':
        publicKey = paymentList[index]['credentials']['public_key'];
        secretKey = '';
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'payfast':
        publicKey = paymentList[index]['credentials']['merchant_id'];
        secretKey = paymentList[index]['credentials']['merchant_key'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'paystack':
        publicKey = paymentList[index]['credentials']['public_key'];
        secretKey = paymentList[index]['credentials']['secret_key'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'paytm':
        publicKey = paymentList[index]['credentials']['merchant_key'];
        secretKey = paymentList[index]['credentials']['merchant_mid'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'razorpay':
        publicKey = paymentList[index]['credentials']['api_key'];
        secretKey = paymentList[index]['credentials']['api_secret'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'stripe':
        publicKey = paymentList[index]['credentials']['public_key'];
        secretKey = paymentList[index]['credentials']['secret_key'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'cinetpay':
        publicKey = paymentList[index]['credentials']['site_id'];
        secretKey = paymentList[index]['credentials']['apiKey'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'paytabs':
        paytabProfileId = paymentList[index]['credentials']['profile_id'];
        secretKey = paymentList[index]['credentials']['server_key'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'squareup':
        squareLocationId = paymentList[index]['credentials']['location_id'];
        secretKey = paymentList[index]['credentials']['access_token'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'billplz':
        publicKey = paymentList[index]['credentials']['key'];
        secretKey = paymentList[index]['credentials']['x_signature'];
        billPlzCollectionName = paymentList[index]['collection_name'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'zitopay':
        zitopayUserName = paymentList[index]['credentials']['username'];
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'manual_payment':
        publicKey = '';
        secretKey = '';
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      case 'cash_on_delivery':
        publicKey = '';
        secretKey = '';
        isTestMode = paymentList[index]['test_mode'] == 1 ? true : false;
        notifyListeners();
        break;

      //switch end
    }
  }
}
