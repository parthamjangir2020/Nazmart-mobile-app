// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/model/slider_model.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';

class SliderService with ChangeNotifier {
  List sliderImageList = [];
  fetchSlider() async {
    if (sliderImageList.isEmpty) {
      var response = await http.get(Uri.parse('$baseApi/slider'));

      if (response.statusCode == 200) {
        var data = SliderModel.fromJson(jsonDecode(response.body));

        for (int i = 0; i < data.data.length; i++) {
          sliderImageList.add({
            'title': data.data[i].title,
            'subtitle': data.data[i].subtitle,
            'imgUrl': data.data[i].image,
            'campaignId': data.data[i].campaignId
          });
        }
        notifyListeners();
      } else {
        print('slider fetch error ${response.body}');
      }
    } else {
      //already loaded from server. no need to load again
    }
  }
}
