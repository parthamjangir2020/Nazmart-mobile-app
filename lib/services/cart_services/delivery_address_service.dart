// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/model/shipping_cost_model.dart';
import 'package:no_name_ecommerce/services/auth_services/login_service.dart';
import 'package:no_name_ecommerce/services/auth_services/signup_service.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/services/cart_services/coupon_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryAddressService with ChangeNotifier {
  Map enteredDeliveryAddress = {};

  ShippingCostModel? shippingCostDetails;
  bool hasError = false;

  late int selectedShipId;
  var selectedShipName = '';
  var selectedShipCost = 0;
  int defaultShipId = 0;
  var defaultShipName = '';

  var vatAmount = 0.0;
  double? vatPercentage = 0;

  int selectedShippingIndex = -1;

  bool createAccountWithDeliveryDetails = false;

  setCreateAccountStatus(bool status) {
    createAccountWithDeliveryDetails = status;
    notifyListeners();
  }

  setPass(v) {
    var oldAddress = enteredDeliveryAddress;

    oldAddress["pass"] = v;

    enteredDeliveryAddress = oldAddress;
    notifyListeners();

    print('entererer $enteredDeliveryAddress');
  }

  setSelectedShipIndex(value) {
    selectedShippingIndex = value;
    notifyListeners();
  }

  setDefault() {
    selectedShipId = defaultShipId;
    selectedShipName = defaultShipName;
    selectedShipCost = 0;
    hasError = false;
    notifyListeners();
  }

  setVatAndincreaseTotal(newVatPercent, BuildContext context) {
    vatPercentage = newVatPercent;

    var subtotal = Provider.of<CartService>(context, listen: false).subTotal;

    var oldVat = vatAmount;
    vatAmount = (subtotal * newVatPercent) / 100;

    Provider.of<CartService>(context, listen: false)
        .increaseTotal(oldVat, vatAmount);
  }

  setShipIdAndCosts(shipId, shipCost, shipName, BuildContext context) {
    var oldShipCost = selectedShipCost;
    selectedShipId = shipId;
    selectedShipName = shipName;
    selectedShipCost = shipCost;
    notifyListeners();
    debugPrint('selected shipping id $selectedShipId');
    debugPrint('selected shipping cost $selectedShipCost');

    Provider.of<CartService>(context, listen: false)
        .increaseTotal(oldShipCost, selectedShipCost);
  }

  bool isLoading = false;
  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  setShipCostDeafault() {
    shippingCostDetails = null;
    hasError = false;
    notifyListeners();
  }

//fetch country shipping cost ======>
  fetchCountryShippingCost(BuildContext context, {countryId, stateId}) async {
    Future.delayed(const Duration(milliseconds: 500), () {
      setLoadingTrue();
      setShipCostDeafault();
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
    var data = {'country': countryId.toString(), 'state': stateId.toString()};

    var response = await http.post(Uri.parse(ApiUrl.shippingCostUri),
        headers: header, body: data);

    setLoadingFalse();

    if (response.statusCode == 200) {
      var data = ShippingCostModel.fromJson(jsonDecode(response.body));

      shippingCostDetails = data;

      setShipIdAndCosts(
          data.defaultShippingOptions.options?.shippingMethodId ?? 0,
          data.defaultShippingOptions.options?.cost,
          data.defaultShippingOptions.name,
          context);

      defaultShipId =
          data.defaultShippingOptions.options?.shippingMethodId ?? 0;
      defaultShipName = data.defaultShippingOptions.name ?? '';

      setVatAndincreaseTotal(data.tax?.toDouble() ?? 0, context);

      notifyListeners();
    } else {
      //error fetching data
      hasError = true;
      notifyListeners();
    }
  }

  getShipOptionSubtitle(settingPreset, minOrderPrice) {
    if (settingPreset == 'min_order_or_coupon') {
      return 'Minimum Order Amount: $minOrderPrice Or Coupon Needed';
    } else if (settingPreset == 'min_order_and_coupon') {
      return 'Minimum Order Amount: $minOrderPrice And Coupon Needed';
    } else {
      return '';
    }
  }

  checkIfCouponNeed(shippingCoupon, BuildContext context) {
    var appliedCoupon =
        Provider.of<CouponService>(context, listen: false).appliedCoupon;
    if (appliedCoupon == null && shippingCoupon != null) {
      showToast('Coupon is needed', Colors.black);
      return true;
    } else if (appliedCoupon != null && shippingCoupon != null) {
      //check if applied coupon matches the shipping coupon
      if (appliedCoupon != shippingCoupon) {
        showToast(
            'You applied a coupon which is not eligible for this shipping',
            Colors.black);
        return true;
      }
    } else {
      return false;
    }
  }

  Future<bool> registerUsingDeliveryAddress(BuildContext context) async {
    if (createAccountWithDeliveryDetails == false) return false;

    print(enteredDeliveryAddress);
    print(enteredDeliveryAddress);
    if (enteredDeliveryAddress["pass"] == null) {
      showToast('Enter a password', Colors.black);
      return false;
    }
    if (enteredDeliveryAddress["pass"] != null) {
      if (enteredDeliveryAddress["pass"].length < 6) {
        showToast('Password must be at least 6 characters long', Colors.black);
        return false;
      }
    }

    var res = await Provider.of<SignupService>(context, listen: false).signup(
        context,
        userName: enteredDeliveryAddress['name'],
        password: enteredDeliveryAddress['pass'],
        fullName: enteredDeliveryAddress['name'],
        email: enteredDeliveryAddress['email'],
        mobile: enteredDeliveryAddress['phone'],
        cityName: enteredDeliveryAddress['city'],
        isFromDeliveryAddressPage: true);

    if (res == true) {
      await Provider.of<LoginService>(context, listen: false).login(
          enteredDeliveryAddress['email'],
          enteredDeliveryAddress['pass'],
          context,
          true,
          isFromCheckout: true);

      Provider.of<ProfileService>(context, listen: false).fetchData();
    }
    return res;
  }
}
