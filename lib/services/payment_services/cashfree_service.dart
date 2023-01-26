import 'dart:convert';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/services/payment_services/payment_gateway_list_service.dart';
import 'package:no_name_ecommerce/services/place_order_service.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

class CashfreeService {
  getTokenAndPay(BuildContext context) async {
    //========>
    // Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();

    // String amount;
    // var bcProvider =
    //     Provider.of<BookConfirmationService>(context, listen: false);
    // var pProvider = Provider.of<PersonalizationService>(context, listen: false);
    // var bookProvider = Provider.of<BookService>(context, listen: false);

    // var name = bookProvider.name ?? '';
    // var phone = bookProvider.phone ?? '';
    // var email = bookProvider.email ?? '';

    // if (pProvider.isOnline == 0) {
    //   amount = bcProvider.totalPriceAfterAllcalculation.toStringAsFixed(2);
    // } else {
    //   amount = bcProvider.totalPriceOnlineServiceAfterAllCalculation
    //       .toStringAsFixed(2);
    // }

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      // "Accept": "application/json",
      'x-client-id':
          Provider.of<PaymentGatewayListService>(context, listen: false)
              .publicKey
              .toString(),
      'x-client-secret':
          Provider.of<PaymentGatewayListService>(context, listen: false)
              .secretKey
              .toString(),
      "Content-Type": "application/json"
    };

    String orderId = '1';
    String orderCurrency = "INR";
    var data = jsonEncode({
      'orderId': orderId,
      'orderAmount': '100',
      'orderCurrency': orderCurrency
    });

    var response = await http.post(
      Uri.parse(
          'https://test.cashfree.com/api/v2/cftoken/order'), // change url to https://api.cashfree.com/api/v2/cftoken/order when in production
      body: data,
      headers: header,
    );
    print(response.body);

    if (jsonDecode(response.body)['status'] == "OK") {
      cashFreePay(jsonDecode(response.body)['cftoken'], orderId, orderCurrency,
          context, '100', 'name', 'phone', 'email');
    } else {
      showToast('Something went wrong', Colors.black);
    }
    // if()
  }

  cashFreePay(token, orderId, orderCurrency, BuildContext context, amount, name,
      phone, email) {
    //Replace with actual values
    //has to be unique every time
    String stage = "TEST"; // PROD when in production mode// TEST when in test

    String tokenData = token; //generate token data from server

    String appId = "94527832f47d6e74fa6ca5e3c72549";

    String notifyUrl = "";

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": amount,
      "customerName": name,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": phone,
      "customerEmail": email,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl
    };

    // CashfreePGSDK.doPayment(inputParams)
    //     .then((value) => value?.forEach((key, value) {
    //           print("$key : $value");
    //           print('it worked');
    //           //Do something with the result
    //         }));
    CashfreePGSDK.doPayment(
      inputParams,
    ).then((value) {
      print('cashfree payment result $value');
      if (value != null) {
        if (value['txStatus'] == "SUCCESS") {
          print('Cashfree Payment successfull. Do something here');
          Provider.of<PlaceOrderService>(context, listen: false)
              .makePaymentSuccess(context);
        }
      }
    });
  }
}
