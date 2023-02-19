// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/model/slider_model.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';

class SliderService with ChangeNotifier {
  List<SliderItem> sliderImageList = [];
  fetchSlider() async {
    if (sliderImageList.isNotEmpty) return;

    var response = await http.get(Uri.parse('$baseApi/mobile-slider'));

    if (response.statusCode == 200) {
      var data = SliderModel.fromJson(jsonDecode(response.body));

      sliderImageList = data.data;
      notifyListeners();
    } else {
      print('slider fetch error ${response.body}');
    }
  }
}
