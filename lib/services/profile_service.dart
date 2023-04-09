// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/model/profile_model.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileService with ChangeNotifier {
  bool isloading = false;

  ProfileModel? profileDetails;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  setEverythingToDefault() {
    profileDetails = null;
    notifyListeners();
  }

  Future<bool> getProfileDetails({bool isFromProfileupdatePage = false}) async {
    if (isFromProfileupdatePage == true) {
      //if from update profile page then load it anyway
      print('is from profile update page true');

      var res = await fetchData();
      return res;
    } else {
      //not from profile page. check if data already loaded
      if (profileDetails == null) {
        fetchData();
      } else {
        print('profile data already loaded');
      }

      return false;
    }
  }

  Future<bool> fetchData() async {
    print('fetching profile data');
    var connection = await checkConnection();
    if (!connection) return false;
    //internet connection is on
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    setLoadingTrue();

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json"
      "Authorization": "Bearer $token",
    };

    var response =
        await http.get(Uri.parse(ApiUrl.profileDataUri), headers: header);

    if (response.statusCode == 200) {
      var data = ProfileModel.fromJson(jsonDecode(response.body));
      profileDetails = data;

      print('profile details is $profileDetails');

      setLoadingFalse();
      notifyListeners();

      return true;
    } else {
      setLoadingFalse();
      notifyListeners();
      return false;
    }
  }
}
