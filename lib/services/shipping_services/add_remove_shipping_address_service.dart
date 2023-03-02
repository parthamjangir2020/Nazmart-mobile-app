import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/country_states_service.dart';
import 'package:no_name_ecommerce/services/shipping_services/shipping_list_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddRemoveShippingAddressService with ChangeNotifier {
  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  addAddress(context, {name, email, phone, address, city, zip}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var countryId = Provider.of<CountryStatesService>(context, listen: false)
        .selectedCountryId;

    var stateId = Provider.of<CountryStatesService>(context, listen: false)
        .selectedStateId;

    if (stateId == '0') {
      showToast('You must select a state', Colors.black);
      return;
    }

    var data = jsonEncode({
      'full_name': name,
      'email': email,
      'phone': phone,
      'state_id': stateId,
      'city': city,
      'zip_code': zip,
      'country_id': countryId,
      'address': address,
    });
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    setLoadingTrue();

    var response = await http.post(Uri.parse(ApiUrl.addShippingUri),
        body: data, headers: header);

    setLoadingFalse();

    if (response.statusCode == 200) {
      showToast('Address saved', Colors.black);

      Provider.of<ShippingListService>(context, listen: false)
          .fetchAddressList(isFromAddAddressPage: true);

      Navigator.pop(context);
    } else {
      showToast('Something went wrong', Colors.black);
      print('delivery address save failed${response.body}');
    }
  }

  removeAddress(addressId, context) async {
    setLoadingTrue();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var response = await http.get(
        Uri.parse('${ApiUrl.removeShippingUri}/$addressId'),
        headers: header);

    setLoadingFalse();

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      Provider.of<ShippingListService>(context, listen: false)
          .fetchAddressList(isFromAddAddressPage: true);

      // pop alert dialogue
      Navigator.pop(context);
    } else {
      showToast('Something went wrong', Colors.black);
      print('shipping address delete failed${response.body}');
    }
  }
}
