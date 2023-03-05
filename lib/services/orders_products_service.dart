import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:no_name_ecommerce/model/order_list_model.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderService with ChangeNotifier {
  List<OrderList> orderList = [];

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

    var response =
        await http.get(Uri.parse(ApiUrl.orderListUri), headers: header);

    if (response.statusCode == 200 &&
        jsonDecode(response.body)['data'].isNotEmpty) {
      var data = OrderListModel.fromJson(jsonDecode(response.body));

      setTotalPage(data.lastPage);

      if (isrefresh) {
        orderList = [];
        orderList = data.data;
      } else {
        print('add new data');
        orderList = data.data;
      }

      currentPage++;
      setCurrentPage(currentPage);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }
}
