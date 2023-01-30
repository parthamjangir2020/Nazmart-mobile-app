// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/model/subcategory_model.dart';
import 'package:no_name_ecommerce/services/category_service.dart';
import 'package:no_name_ecommerce/services/child_category_service.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:provider/provider.dart';

class SubCategoryService with ChangeNotifier {
  var subCategoryDropdownList = [];
  var subCategoryDropdownIndexList = [];
  var selectedSubCategory;
  var selectedSubCategoryId;

  setSubCategoryValue(value) {
    selectedSubCategory = value;
    print('selected subcategory $selectedSubCategory');
    notifyListeners();
  }

  setSelectedSubCategoryId(value) {
    selectedSubCategoryId = value;
    print('selected subCategory id $value');
    notifyListeners();
  }

  setDefault() {
    subCategoryDropdownList = [];
    subCategoryDropdownIndexList = [];
    selectedSubCategory = null;
    selectedSubCategoryId = null;
    notifyListeners();
  }

  fetchSubCategory(BuildContext context) async {
    setDefault();
    //
    var selectedCategoryId =
        Provider.of<CategoryService>(context, listen: false).selectedCategoryId;

    var response =
        await http.get(Uri.parse('$baseApi/subcategory/$selectedCategoryId'));
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = SubCategoryModel.fromJson(jsonDecode(response.body));

      for (int i = 0; i < data.subcategories.length; i++) {
        subCategoryDropdownList.add(data.subcategories[i].name);
        subCategoryDropdownIndexList.add(data.subcategories[i].id);
      }

      selectedSubCategory = subCategoryDropdownList[0];
      selectedSubCategoryId = subCategoryDropdownIndexList[0];

      notifyListeners();

      Provider.of<ChildCategoryService>(context, listen: false)
          .fetchChildCategory(context);
    } else {
      //error fetching data
      subCategoryDropdownList.add('Select Subcategory');
      subCategoryDropdownIndexList.add(null);
      selectedSubCategory = 'Select Subcategory';
      selectedSubCategoryId = null;
      notifyListeners();
    }
  }
}
