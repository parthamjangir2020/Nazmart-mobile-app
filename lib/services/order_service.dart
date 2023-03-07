// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/model/order_details_model.dart';
import 'package:no_name_ecommerce/model/order_list_model.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderService with ChangeNotifier {
  List<OrderList> orderList = [];
  List productList = [];

  late int totalPages;
  int currentPage = 1;

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  Future<bool> fetchOrderList(context, {bool isrefresh = false}) async {
    if (isrefresh) {
      orderList = [];
      notifyListeners();

      setCurrentPage(currentPage);
    } else {}

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (!connection) return false;

    var response = await http.get(
        Uri.parse('${ApiUrl.orderListUri}?page=$currentPage'),
        headers: header);

    if (response.statusCode == 200 &&
        jsonDecode(response.body)['data'].isNotEmpty) {
      var data = OrderListModel.fromJson(jsonDecode(response.body));

      setTotalPage(data.lastPage);

      if (isrefresh) {
        orderList = [];
        productList = [];
        orderList = data.data;
        addProduct(data.data);
      } else {
        print('add new data');

        for (int i = 0; i < data.data.length; i++) {
          orderList.add(data.data[i]);
        }
        addProduct(data.data);
      }

      currentPage++;
      setCurrentPage(currentPage);
      notifyListeners();
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  // add product
  addProduct(List<OrderList> orderList) {
    for (int i = 0; i < orderList.length; i++) {
      List temp = [];
      var prDetails = jsonDecode(orderList[i].orderDetails);
      prDetails.forEach((k, v) => temp.add(v));
      productList.add(temp);
    }
    notifyListeners();
  }

  //order details
  //=============>

  OrderDetailsModel? orderDetails;
  List detailsProductList = [];

  fetchOrderDetails(BuildContext context, {required orderId}) async {
    var connection = await checkConnection();
    if (!connection) return;

    orderDetails = null;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    var response = await http.get(Uri.parse('${ApiUrl.orderListUri}/$orderId'),
        headers: header);

    if (response.statusCode == 200) {
      var data = OrderDetailsModel.fromJson(jsonDecode(response.body));
      orderDetails = data;

      detailsProductList = [];
      addProductInProductDetails(jsonDecode(response.body));

      notifyListeners();
    } else {
      showToast('Something went wrong', Colors.black);
    }
  }

  // add product
  addProductInProductDetails(orderJson) {
    var prDetails = orderJson['data']['order_details'];
    prDetails.forEach((k, v) => detailsProductList.add(v));
    notifyListeners();
  }

// Refund product
// ===========>

  bool refundLoading = false;

  setRefundLoading(bool status) {
    refundLoading = status;
    notifyListeners();
  }

  refundProduct(BuildContext context,
      {required orderId, required productId}) async {
    var connection = await checkConnection();
    if (!connection) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    print('order id $orderId');
    print('product id $productId');

    setRefundLoading(true);

    var response = await http.post(
        Uri.parse(
            '${ApiUrl.refundProductUri}?order_id=$orderId&refund_products=$productId'),
        headers: header);

    setRefundLoading(false);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      showToast('Refund request successfull', Colors.black);
      Navigator.pop(context);
    } else {
      showToast('Something went wrong', Colors.black);
    }
  }
}
