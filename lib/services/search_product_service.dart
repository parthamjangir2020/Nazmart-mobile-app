// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/model/search_model.dart';
import 'package:no_name_ecommerce/services/category_service.dart';
import 'package:no_name_ecommerce/services/child_category_service.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/services/subcategory_service.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:provider/provider.dart';

class SearchProductService with ChangeNotifier {
  List<ProductsOfSearch> productList = [];
  bool noProductFound = false;
  bool isLoading = false;

  String minPrice = '1';
  String maxPrice = '1000';
  double rating = 5;

  late int totalPages;

  int currentPage = 1;

  String? searchText;

  setSearchText(value) {
    searchText = value;
    notifyListeners();
  }

  setMinPrice(v) {
    minPrice = v;
    notifyListeners();
  }

  setMaxPrice(v) {
    maxPrice = v;
    notifyListeners();
  }

  setRating(v) {
    rating = v;
    notifyListeners();
  }

  setLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  setEverythingToDefault() {
    currentPage = 1;
    productList = [];
    noProductFound = false;
    notifyListeners();
  }

  searchProducts(context,
      {bool isrefresh = false, bool isSearching = false}) async {
    if (isSearching == true) {
      setEverythingToDefault();
    }

    setLoadingStatus(true);

    var categoryName =
        Provider.of<CategoryService>(context, listen: false).selectedCategory ??
            '';
    var subCategoryName =
        Provider.of<SubCategoryService>(context, listen: false)
                .selectedSubCategory ??
            '';
    var childCategoryName =
        Provider.of<ChildCategoryService>(context, listen: false)
                .selectedChildCategory ??
            '';

    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      print('isrefresh ran');
      productList = [];
      notifyListeners();

      setCurrentPage(currentPage);
    } else {
      // if (currentPage > 2) {
      //   refreshController.loadNoData();
      //   return false;
      // }
    }

    var connection = await checkConnection();
    if (!connection) return;

    // print(
    //     "$baseApi/product?name=$searchText&page=$currentPage&category=$categoryName&sub_category=$subCategoryName&child_category=$childCategoryName&min_price=$minPrice&max_price=$maxPrice&rating=5");

    var response = await http.get(Uri.parse(
        "$baseApi/product?name=$searchText&page=$currentPage&category=$categoryName&sub_category=$subCategoryName&child_category=$childCategoryName&min_price=$minPrice&max_price=$maxPrice&rating=5"));
    setLoadingStatus(false);

    if (response.statusCode == 200 &&
        jsonDecode(response.body)['data'].isNotEmpty) {
      var data = SearchModel.fromJson(jsonDecode(response.body));

      setTotalPage(data.lastPage);

      if (isrefresh) {
        print('refresh true');
        //if refreshed, then remove all service from list and insert new data
        productList = [];
        productList = data.data;
        notifyListeners();
      } else {
        print('add new data');
        //else add new data

        for (int i = 0; i < data.data.length; i++) {
          productList.add(data.data[i]);
        }

        notifyListeners();
      }

      currentPage++;
      setCurrentPage(currentPage);

      notifyListeners();
      return true;
    } else {
      if (productList.isEmpty) {
        //if user searched for a product and not even a single product found
        //then show no product found
        //but we dont want to show it when some products were found and user
        //goes to the next page and there are no more products
        noProductFound = true;
      }
      notifyListeners();
      print('no more data');

      return false;
    }
  }
}
