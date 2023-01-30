// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/model/child_category_model.dart';
import 'package:no_name_ecommerce/services/subcategory_service.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:provider/provider.dart';

class ChildCategoryService with ChangeNotifier {
  var childCategoryDropdownList = [];
  var childCategoryDropdownIndexList = [];
  var selectedChildCategory;
  var selectedChildCategoryId;

  setChildCategoryValue(value) {
    selectedChildCategory = value;
    print('selected childcategory $selectedChildCategory');
    notifyListeners();
  }

  setSelectedChildCategoryId(value) {
    selectedChildCategoryId = value;
    print('selected childCategory id $value');
    notifyListeners();
  }

  setDefault() {
    childCategoryDropdownList = [];
    childCategoryDropdownIndexList = [];
    selectedChildCategory = null;
    selectedChildCategoryId = null;
    notifyListeners();
  }

  fetchChildCategory(BuildContext context) async {
    setDefault();

    var selectedChildcategoryId =
        Provider.of<SubCategoryService>(context, listen: false)
            .selectedSubCategoryId;

    var response = await http
        .get(Uri.parse('$baseApi/child-category/$selectedChildcategoryId'));
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = ChildCategoryModel.fromJson(jsonDecode(response.body));

      for (int i = 0; i < data.childCategories.length; i++) {
        childCategoryDropdownList.add(data.childCategories[i].name);
        childCategoryDropdownIndexList.add(data.childCategories[i].id);
      }

      selectedChildCategory = childCategoryDropdownList[0];
      selectedChildCategoryId = childCategoryDropdownIndexList[0];

      notifyListeners();
    } else {
      //error fetching data
      childCategoryDropdownList.add('Select child category');
      childCategoryDropdownIndexList.add(null);
      selectedChildCategory = 'Select child category';
      selectedChildCategoryId = null;
      notifyListeners();
    }
  }
}
