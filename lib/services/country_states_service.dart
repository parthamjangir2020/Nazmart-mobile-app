// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/model/state_dropdown_model.dart';
import 'package:no_name_ecommerce/model/country_dropdown_model.dart';
import 'package:no_name_ecommerce/services/cart_services/delivery_address_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:provider/provider.dart';

class CountryStatesService with ChangeNotifier {
  var countryDropdownList = [];
  var countryDropdownIndexList = [];
  var selectedCountry;
  var selectedCountryId;

  var statesDropdownList = [];
  var statesDropdownIndexList = [];
  // var oldStateDropdownList;
  // var oldStatesDropdownIndexList = [];
  var selectedState;
  var selectedStateId;

  bool isLoading = false;

  setCountryValue(value) {
    selectedCountry = value;
    notifyListeners();
  }

  setStatesValue(value) {
    selectedState = value;
    notifyListeners();
  }

  setSelectedCountryId(value) {
    selectedCountryId = value;
    print('selected country id $value');
    notifyListeners();
  }

  setSelectedStatesId(value) {
    selectedStateId = value;
    print('selected state id $value');
    notifyListeners();
  }

  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

//Set country based on user profile
//==============================>

  setCountryBasedOnUserProfile(BuildContext context) {
    selectedCountry = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            ?.userDetails
            .userCountry
            ?.name ??
        'Select Country';
    selectedCountryId = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            ?.userDetails
            .userCountry
            ?.id ??
        '0';

    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
  }

//Set state based on user profile
//==============================>
  setStateBasedOnUserProfile(BuildContext context) {
    selectedState = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            ?.userDetails
            .userState
            ?.name ??
        'Select State';
    selectedStateId = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            ?.userDetails
            .userState
            ?.id ??
        '0';
    print(statesDropdownList);
    print(statesDropdownIndexList);
    print('selected state $selectedState');
    print('selected state id $selectedStateId');
  }

  fetchCountries(BuildContext context) async {
    if (countryDropdownList.isEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setLoadingTrue();
      });
      var response = await http.get(Uri.parse(ApiUrl.countryListUri));

      if (response.statusCode == 200 &&
          jsonDecode(response.body)['countries'].isNotEmpty) {
        print(response.body);
        var data = CountryDropdownModel.fromJson(jsonDecode(response.body));
        for (int i = 0; i < data.countries.length; i++) {
          countryDropdownList.add(data.countries[i].name);
          countryDropdownIndexList.add(data.countries[i].id);
        }

        setCountry(context, data: data);

        notifyListeners();
        fetchState(selectedCountryId, context);
      } else {
        //error fetching data
        countryDropdownList.add('Select Country');
        countryDropdownIndexList.add('0');
        selectedCountry = 'Select State';
        selectedCountryId = '0';
        fetchState(selectedCountryId, context);
        notifyListeners();
      }
    } else {
      //country list already loaded from api
      setCountry(context);
      fetchState(selectedCountryId, context);
      // set_State(context);
      // setArea(context);
    }
  }

  fetchState(countryId, BuildContext context) async {
    //make states list empty first
    statesDropdownList = [];
    statesDropdownIndexList = [];
    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });

    var response =
        await http.get(Uri.parse('${ApiUrl.stateListUri}/$countryId'));
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = StateDropdownModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.state.length; i++) {
        statesDropdownList.add(data.state[i].name);
        statesDropdownIndexList.add(data.state[i].id);
      }

      set_State(context, data: data);

      notifyListeners();
    } else {
      //error fetching data
      statesDropdownList.add('Select State');
      statesDropdownIndexList.add('0');
      selectedState = 'Select State';
      selectedStateId = '0';
      notifyListeners();
    }
  }

  setCountry(BuildContext context, {data}) {
    var profileData =
        Provider.of<ProfileService>(context, listen: false).profileDetails;
    //if profile of user loaded then show selected dropdown data based on the user profile
    if (profileData != null && profileData.userDetails.userCountry != null) {
      setCountryBasedOnUserProfile(context);
    } else {
      if (data != null) {
        selectedCountry = data.countries[0].name;
        selectedCountryId = data.countries[0].id;
      }
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      Provider.of<DeliveryAddressService>(context, listen: false)
          .fetchCountryShippingCost(context, countryId: selectedCountryId);
    });
  }

//==============>
  set_State(BuildContext context, {data}) {
    var profileData =
        Provider.of<ProfileService>(context, listen: false).profileDetails;

    if (profileData != null) {
      var userCountryId = Provider.of<ProfileService>(context, listen: false)
          .profileDetails
          ?.userDetails
          .userCountry
          ?.id;

      if (userCountryId == selectedCountryId) {
        //if user selected the country id which is saved in his profile
        //only then show state/area based on that

        setStateBasedOnUserProfile(context);
      } else {
        if (data != null) {
          selectedState = data.serviceCities[0].serviceCity;
          selectedStateId = data.serviceCities[0].id;
        }
      }
    } else {
      if (data != null) {
        selectedState = data.serviceCities[0].serviceCity;
        selectedStateId = data.serviceCities[0].id;
      }
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      Provider.of<DeliveryAddressService>(context, listen: false)
          .fetchCountryShippingCost(context,
              countryId: selectedCountryId, stateId: selectedStateId);
    });
  }
}
