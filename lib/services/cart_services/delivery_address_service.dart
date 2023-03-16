// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/model/shipping_cost_model.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/services/cart_services/coupon_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryAddressService with ChangeNotifier {
  var enteredDeliveryAddress;

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
  bool vatLoading = false;

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

  //fetch vat amount ===============>
  // fetchShippingCostAndVat(BuildContext context) async {
  //   vatLoading = true;
  //   notifyListeners();

  //   var countryId = Provider.of<CountryStatesService>(context, listen: false)
  //       .selectedCountryId;

  //   var stateId = Provider.of<CountryStatesService>(context, listen: false)
  //       .selectedStateId;

  //   var appliedCoupon =
  //       Provider.of<CouponService>(context, listen: false).appliedCoupon;

  //   var couponAmount =
  //       Provider.of<CouponService>(context, listen: false).couponDiscount ?? 0;

  //   List cartItemList =
  //       Provider.of<CartService>(context, listen: false).cartItemList;

  //   List productIds = [];

  //   for (int i = 0; i < cartItemList.length; i++) {
  //     productIds.add(cartItemList[i]['productId']);
  //   }

  //   var subtotal = Provider.of<CartService>(context, listen: false).subTotal;

  //   var response = await http.get(Uri.parse(
  //       '${ApiUrl.vatAndShipCostUri}=$countryId&state=$stateId&coupon=$appliedCoupon&selected_shipping_option=$selectedShipId&products_ids=$productIds&sub_total=$subtotal&coupon_amount=$couponAmount'));

  //   vatLoading = false;
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);

  //     print('vat' + data['tax_amount']);
  //     setVatAndincreaseTotal(
  //         double.parse(data['tax_amount'].toString()), context);
  //     Navigator.pop(context);
  //   } else {
  //     showToast(
  //         'Error fetching vat amount. Please try again later', Colors.black);
  //     print('error fetching vat ${response.body}');
  //   }

  //   notifyListeners();
  // }
}
