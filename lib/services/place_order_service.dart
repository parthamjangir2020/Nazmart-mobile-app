// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/cart_services/coupon_service.dart';
import 'package:no_name_ecommerce/services/cart_services/delivery_address_service.dart';
import 'package:no_name_ecommerce/services/checkout_service.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/services/dropdown_services/country_dropdown_service.dart';
import 'package:no_name_ecommerce/services/dropdown_services/state_dropdown_services.dart';
import 'package:no_name_ecommerce/services/payment_services/payment_gateway_list_service.dart';
import 'package:no_name_ecommerce/services/product_db_service.dart';
import 'package:no_name_ecommerce/view/home/landing_page.dart';
import 'package:no_name_ecommerce/view/order/order_success_page.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PlaceOrderService with ChangeNotifier {
  bool isloading = false;

  var orderId;
  var successUrl = 'https://www.google.com/';
  var cancelUrl;

  var paytmHtmlForm;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future<bool> placeOrder(BuildContext context, String? imagePath,
      {bool isManualOrCod = false}) async {
    setLoadingTrue();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

//Delivery details========>
    var address = Provider.of<DeliveryAddressService>(context, listen: false)
        .enteredDeliveryAddress;
    var selectedPaymentMethodName =
        Provider.of<PaymentGatewayListService>(context, listen: false)
            .selectedMethodName;
    var selectedShipId =
        Provider.of<DeliveryAddressService>(context, listen: false)
            .selectedShipId;
    var coupon =
        Provider.of<CouponService>(context, listen: false).appliedCoupon;

    var countryId = Provider.of<CountryDropdownService>(context, listen: false)
        .selectedCountryId;
    var stateId = Provider.of<StateDropdownService>(context, listen: false)
        .selectedStateId;

    var cartItems = await CheckoutService().formatCart(context);

    var formData;
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['x-api-key'] = xApiKey;
    dio.options.headers['Authorization'] = "Bearer $token";

    formData = FormData.fromMap({
      'name': address['name'],
      'email': address['email'],
      'phone': address['phone'],
      'country': countryId,
      'state': stateId,
      'address': address['address'],
      'city': address['city'],
      'shipping_method': selectedShipId,
      'used_coupon': coupon ?? '',
      'message': '',
      'payment_gateway': selectedPaymentMethodName,
      // 'bank_payment_input': imagePath !=null ? await MultipartFile.fromFile(imagePath,
      //     filename: '${address['name']}$imagePath.jpg') : null,

      'cart': jsonEncode(cartItems)
    });

    var response = await dio.post(
      ApiUrl.checkoutUri,
      data: formData,
    );

    print(response.data);

    if (response.statusCode == 200) {
      print(response.data);

      orderId = response.data['order_id'];
      print('order id is $orderId');

      notifyListeners();

      if (isManualOrCod == true) {
        //cod means cash on delivery
        //if user placed order in manual transfer or cash on delivery then make payment pending
        Provider.of<PlaceOrderService>(context, listen: false)
            .makePaymentSuccess(context); //make payment status pending
        doNext(context, 'Pending');
      }

      setLoadingFalse();
      return true;
    } else {
      setLoadingFalse();
      print(response.data);

      if (response.data.containsKey('message')) {
        showToast(response.data['message'].toString(), Colors.black);
      } else {
        showToast('Something went wrong', Colors.black);
      }

      return false;
    }

    //
  }

  //make payment successfull
  makePaymentSuccess(BuildContext context) async {
//payment status =====>
// 0 Pending , 1 Complete , 2 Failed

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var connection = await checkConnection();

    if (connection) {
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      print('order id is $orderId');

      var data = jsonEncode({'order_id': orderId, 'status': '1'});

      var response = await http.post(Uri.parse(ApiUrl.paymentUpdateUri),
          headers: header, body: data);
      setLoadingFalse();
      if (response.statusCode == 200 || response.statusCode == 201) {
        showToast('Order placed successfully', Colors.black);
        doNext(context, 'Complete');
        //make cart table empty
        ProductDbService().emptyCartTable();
      } else {
        print(response.body);
        showToast('Failed to make payment status successfull', Colors.black);
        doNext(context, 'Pending');
      }
    } else {
      showToast('Check your internet connection and try again', Colors.black);
    }
  }

  ///////////==========>
  doNext(BuildContext context, String paymentStatus) {
    //Refresh profile page so that user can see updated total orders

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LandingPage()),
        (Route<dynamic> route) => false);

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const OrderSuccessPage(),
      ),
    );
  }
}
