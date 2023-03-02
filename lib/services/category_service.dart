// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/model/category_model.dart';
import 'package:no_name_ecommerce/services/subcategory_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:provider/provider.dart';

class CategoryService with ChangeNotifier {
  var categoryDropdownList = [];
  var categoryDropdownIndexList = [];
  var selectedCategory;
  var selectedCategoryId;

  setCategoryValue(value) {
    selectedCategory = value;
    print('selected category $selectedCategory');
    notifyListeners();
  }

  setSelectedCategoryId(value) {
    selectedCategoryId = value;
    print('selected Category id $value');
    notifyListeners();
  }

  setFirstValue() {
    if (categoryDropdownList.isEmpty) return;
    selectedCategory = categoryDropdownList[0];
    selectedCategoryId = categoryDropdownIndexList[0];
    notifyListeners();
  }

  setDummyValue() {
    categoryDropdownList.add('Select Category');
    categoryDropdownIndexList.add(null);
    selectedCategory = 'Select Category';
    selectedCategoryId = null;
    notifyListeners();
  }

  fetchCategory(BuildContext context) async {
    if (categoryDropdownList.isNotEmpty) return;

    if (categoryDropdownList.isEmpty) {
      var response = await http.get(Uri.parse(ApiUrl.categoryUri));
      print(response.body);

      setDummyValue();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = CategoryModel.fromJson(jsonDecode(response.body));

        for (int i = 0; i < data.categories.length; i++) {
          categoryDropdownList.add(data.categories[i].name);
          categoryDropdownIndexList.add(data.categories[i].id);
        }
        setFirstValue();
        Provider.of<SubCategoryService>(context, listen: false)
            .fetchSubCategory(context);
      } else {
        //error fetching data
      }
    }
  }
}
