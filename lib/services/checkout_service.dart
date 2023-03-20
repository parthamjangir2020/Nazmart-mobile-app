import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:provider/provider.dart';
import 'package:crypto/crypto.dart';

class CheckoutService {
  formatCart(BuildContext context) {
    final cProvider = Provider.of<CartService>(context, listen: false);
    final cartData = cProvider.cartItemList;

    Map formatData = {};
    for (var element in cartData) {
      print(element);
      final String rowId = md5
          .convert(utf8.encode(
              element["id"].toString() + element['attributes'].toString()))
          .toString();
      formatData.putIfAbsent(
          rowId,
          () => {
                "rowId": rowId,
                "id": element["id"],
                "name": element["title"],
                "qty": element["qty"],
                "price": element["price"],
                // "weight":element["weight"], Comment kora agula asha kori lagbe na.
                "options": {
                  "variant_id": element['variant_id'],
                  // "color_name": "Blue",
                  // "size_name": "Large",
                  "attributes": element['attributes'],
                  // "image": "438",
                  "used_categories": element['usedCategories']
                },
                // "discount": 0,
                // "tax": 0,
                "subtotal": element['price'] ?? 12 * element['qty'] ?? 12
              });
    }
    print(formatData);
  }

  final targetMap = {
    "0d8ab1a9b4e28059dee9ac88da20b667": {
      "rowId": "0d8ab1a9b4e28059dee9ac88da20b667",
      "id": "239",
      "name": "towal set",
      "qty": "1",
      "price": 660,
      "weight": 0,
      "options": {
        "variant_id": "448",
        "color_name": "Blue",
        "size_name": "Large",
        "attributes": {"Fabric": "Cotton"},
        "image": "438",
        "used_categories": {"category": 12, "subcategory": 42}
      },
      "discount": 0,
      "tax": 0,
      "subtotal": 660
    }
  };
}
