// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/model/profile_model.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileService with ChangeNotifier {
  bool isloading = false;

  var profileDetails;

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

  getProfileDetails({bool isFromProfileupdatePage = false}) async {
    if (isFromProfileupdatePage == true) {
      //if from update profile page then load it anyway
      print('is from profile update page true');
      setEverythingToDefault();
      fetchData();
    } else {
      //not from profile page. check if data already loaded
      if (profileDetails == null) {
        fetchData();
      } else {
        print('profile data already loaded');
      }
    }
  }

  fetchData() async {
    print('fetching profile data');
    var connection = await checkConnection();
    if (connection) {
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
          await http.get(Uri.parse('$baseApi/user/profile'), headers: header);

      if (response.statusCode == 201) {
        var data = ProfileModel.fromJson(jsonDecode(response.body));
        profileDetails = data;

        print('profile details is $profileDetails');

        setLoadingFalse();
        notifyListeners();
      } else {
        profileDetails == 'error';
        setLoadingFalse();
        showToast('Something went wrong', Colors.black);
        notifyListeners();
      }
    }
  }
}
