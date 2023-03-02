// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/model/country_shipping_cost_model.dart';
import 'package:no_name_ecommerce/model/states_shipping_cost_model.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/services/cart_services/coupon_service.dart';
import 'package:no_name_ecommerce/services/country_states_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

class DeliveryAddressService with ChangeNotifier {
  var enteredDeliveryAddress;

  var shippingCostDetails;

  late int selectedShipId;
  var selectedShipName = '';
  var selectedShipCost = 0;
  int defaultShipId = 0;
  var defaultShipName = '';

  double? vatAmount = 0;
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
    notifyListeners();
  }

  setVatAndincreaseTotal(value, BuildContext context) {
    var oldVat = vatAmount;
    vatAmount = value;
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
    notifyListeners();
  }

//fetch country shipping cost ======>
  fetchCountryShippingCost(countryId, BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 500), () {
      setLoadingTrue();
      setShipCostDeafault();
    });
    var response =
        await http.get(Uri.parse('${ApiUrl.countryShipCostUri}=$countryId'));

    setLoadingFalse();

    if (response.statusCode == 201) {
      var data = CountryShippingCostModel.fromJson(jsonDecode(response.body));

      shippingCostDetails = data;

      setShipIdAndCosts(
          data.defaultShipping.options.shippingMethodId ?? 0,
          data.defaultShipping.options.cost,
          data.defaultShipping.name,
          context);

      defaultShipId = data.defaultShipping.options.shippingMethodId ?? 0;
      defaultShipName = data.defaultShipping.name ?? '';

      // setVatAndincreaseTotal(data.tax?.toDouble() ?? 0, context);
      vatPercentage = data.taxPercentage?.toDouble() ?? 0;

      notifyListeners();
    } else {
      //error fetching data
      shippingCostDetails = 'error';
      notifyListeners();
    }
  }

  fetchStatesShippingCost(stateId, BuildContext context) async {
    if (stateId == '0') {
      //don't load anything
      return;
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      setLoadingTrue();
      setShipCostDeafault();
    });
    var response =
        await http.get(Uri.parse('${ApiUrl.stateShipCostUri}=$stateId'));

    setLoadingFalse();

    if (response.statusCode == 200) {
      var data = StatesShippingCostModel.fromJson(jsonDecode(response.body));

      shippingCostDetails = data;

      setShipIdAndCosts(
          data.defaultShipping.options.shippingMethodId ?? 0,
          data.defaultShipping.options.cost,
          data.defaultShipping.name,
          context);

      defaultShipId = data.defaultShipping.options.shippingMethodId ?? 0;
      defaultShipName = data.defaultShipping.name ?? '';

      // setVatAndincreaseTotal(data.tax?.toDouble() ?? 0, context);
      vatPercentage = data.taxPercentage?.toDouble() ?? 0;

      notifyListeners();
    } else {
      //error fetching data
      shippingCostDetails = 'error';
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
  fetchShippingCostAndVat(BuildContext context) async {
    vatLoading = true;
    notifyListeners();

    var countryId = Provider.of<CountryStatesService>(context, listen: false)
        .selectedCountryId;

    var stateId = Provider.of<CountryStatesService>(context, listen: false)
        .selectedStateId;

    var appliedCoupon =
        Provider.of<CouponService>(context, listen: false).appliedCoupon;

    var couponAmount =
        Provider.of<CouponService>(context, listen: false).couponDiscount ?? 0;

    List cartItemList =
        Provider.of<CartService>(context, listen: false).cartItemList;

    List productIds = [];

    for (int i = 0; i < cartItemList.length; i++) {
      productIds.add(cartItemList[i]['productId']);
    }

    var subtotal = Provider.of<CartService>(context, listen: false).subTotal;

    var response = await http.get(Uri.parse(
        '${ApiUrl.vatAndShipCostUri}=$countryId&state=$stateId&coupon=$appliedCoupon&selected_shipping_option=$selectedShipId&products_ids=$productIds&sub_total=$subtotal&coupon_amount=$couponAmount'));

    vatLoading = false;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      print('vat' + data['tax_amount']);
      setVatAndincreaseTotal(
          double.parse(data['tax_amount'].toString()), context);
      Navigator.pop(context);
    } else {
      showToast(
          'Error fetching vat amount. Please try again later', Colors.black);
      print('error fetching vat ${response.body}');
    }

    notifyListeners();
  }
}
