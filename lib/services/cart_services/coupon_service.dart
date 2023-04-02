// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CouponService with ChangeNotifier {
  var couponDiscount;
  var oldCouponDiscount;

  var appliedCoupon;

  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  setCouponDefault() {
    couponDiscount = null;
    appliedCoupon = null;
    notifyListeners();
  }

  Future<bool> getCouponDiscount(
      cartItemList, couponCode, BuildContext context) async {
    var connection = await checkConnection();
    if (!connection) return false;

    if (couponCode == appliedCoupon) {
      showToast('You already applied this coupon', primaryColor);
      return false;
    }

    //get products from cart
    List items = [];
    for (int i = 0; i < cartItemList.length; i++) {
      items.add({
        "id": cartItemList[i]['productId'],
        "price": cartItemList[i]['priceWithAttr']
      });
    }

    var total = Provider.of<CartService>(context, listen: false).totalPrice;

    setLoadingTrue();
    var data = jsonEncode({
      'coupon': couponCode,
      'total_amount': total,
      'ids': jsonEncode(items),
    });
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var response = await http.post(Uri.parse(ApiUrl.couponUri),
        body: data, headers: header);

    setLoadingFalse();

    if (response.statusCode == 200 &&
        jsonDecode(response.body)['discounted_price'] != 0) {
      oldCouponDiscount = couponDiscount;
      couponDiscount = jsonDecode(response.body)['discounted_price'];
      appliedCoupon = couponCode;
      print('coupon amount is $couponDiscount');

      showToast('Coupon Applied Successfully', Colors.black);

      Provider.of<CartService>(context, listen: false)
          .calculateTotalAfterCouponApplied(
              oldDiscount: oldCouponDiscount, newDiscount: couponDiscount);

      notifyListeners();
      return true;
    } else {
      //something went wrong
      print(response.body);

      showToast('Please enter a valid coupon', Colors.black);
      return false;
    }
  }
}
