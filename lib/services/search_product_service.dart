// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:zaika/search/model/searched_product_model.dart';
import 'package:zaika/search/service/category_dropdown_service.dart';
import 'package:zaika/search/service/price_and_rating_range_service.dart';
import 'package:zaika/search/service/sortby_dropdown_service.dart';
import '../../product/service/common_fav_cart_service.dart';
import '../../utils/common_service.dart';

class SearchProductService with ChangeNotifier {
  var productsMap = [];

  bool noProductFound = false;
  bool isLoading = false;

  late int totalPages;

  int currentPage = 1;

  String searchText = '';

  setSearchText(value) {
    searchText = value;
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

  setNewProductListMap(newList) {
    productsMap = newList;

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
    productsMap = [];
    currentPage = 1;

    noProductFound = false;
    notifyListeners();
  }

  searchProducts(context, {bool isrefresh = false, isSearching = false}) async {
    if (isSearching == true) {
      setEverythingToDefault();
    }

    // setLoadingTrue();
    var minPrice =
        Provider.of<PriceAndRatingRangeService>(context, listen: false)
            .minPrice;
    var maxPrice =
        Provider.of<PriceAndRatingRangeService>(context, listen: false)
            .maxPrice;
    var sortBy = Provider.of<SortByDropdownService>(context, listen: false)
        .selectedSortbyId;
    var categoryId =
        Provider.of<CategoryDropdownService>(context, listen: false)
            .selectedCategoryId;
    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      print('isrefresh ran');
      productsMap = [];
      notifyListeners();

      Provider.of<SearchProductService>(context, listen: false)
          .setCurrentPage(currentPage);
    } else {
      // if (currentPage > 2) {
      //   refreshController.loadNoData();
      //   return false;
      // }
    }

    var connection = await checkConnection();
    if (connection) {
      //if connection is ok
      var response = await http.get(Uri.parse(
          "$baseApi/products/search?pr_min=$minPrice&pr_max=$maxPrice&q=$searchText&sort=$sortBy&cat=$categoryId&page=$currentPage"));

      if (response.statusCode == 201 &&
          jsonDecode(response.body)['data'].isNotEmpty) {
        var data = SearchedProductModel.fromJson(jsonDecode(response.body));

        setTotalPage(data.meta.lastPage);

        if (isrefresh) {
          print('refresh true');
          //if refreshed, then remove all service from list and insert new data
          setServiceList(
            data,
            false,
            context,
          ); //4 means searched product
        } else {
          print('add new data');
          //else add new data
          setServiceList(data, true, context); //4 means searched product
        }

        currentPage++;
        setCurrentPage(currentPage);
        // setLoadingFalse();
        notifyListeners();
        return true;
      } else {
        if (productsMap.isEmpty) {
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

  setServiceList(
    data,
    bool addnewData,
    BuildContext context,
  ) {
    if (addnewData == false) {
      //make the list empty first so that existing data doesn't stay
      print('add new data false');
      productsMap = [];
      notifyListeners();
    } else {
      for (int i = 0; i < data.data.length; i++) {
        productsMap.add({
          'productId': data.data[i].prdId,
          'title': data.data[i].title,
          'discountPrice': data.data[i].discountPrice,
          'oldPrice': data.data[i].price,
          'discountPercent': data.data[i].campaignPercentage,
          'attribute':
              data.data[i].attributes.isNotEmpty ? data.data[i].attributes : [],
          'stockCount': data.data[i].stockCount,
          'imgUrl': data.data[i].imgUrl,
          'isFavourite': false,
          'isAddedToCart': false
        });

        // checkIfAlreadyAddedToCart(data.data[i].title, i, data.data[i].prdId,
        //     productsMap, context, whichProductList[4]);
        checkIfAlreadyAddedToFavourite(data.data[i].title, i,
            data.data[i].prdId, productsMap, context, whichProductList[4]);
      }
    }
  }
}
