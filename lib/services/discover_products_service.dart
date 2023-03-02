import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/model/search_model.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/view/utils/api_url.dart';

class DiscoverProductsService with ChangeNotifier {
  List<ProductsOfSearch> productList = [];

  bool isLoading = false;
  late int totalPages;

  int currentPage = 1;

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

  fetchProducts(context, {bool isrefresh = false}) async {
    setLoadingStatus(true);

    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      print('isrefresh ran');
      productList = [];
      notifyListeners();

      setCurrentPage(currentPage);
    } else {}
    var connection = await checkConnection();
    if (!connection) return;

    var response = await http.get(Uri.parse(
        "${ApiUrl.discoverProductsUri}=$currentPage&category=&sub_category=&child_category=&min_price=&max_price=&rating="));

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
      print('no more data');

      return false;
    }
  }
}
