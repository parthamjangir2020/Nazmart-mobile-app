import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/view/payments/instamojo_payment_page.dart';
import 'package:provider/provider.dart';

class InstamojoService {
  payByInstamojo(BuildContext context) {
    String amount = Provider.of<CartService>(context, listen: false)
        .totalPrice
        .toStringAsFixed(2);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => InstamojoPaymentPage(
          amount: amount,
          name: 'name',
          email: 'email',
        ),
      ),
    );
  }
}
