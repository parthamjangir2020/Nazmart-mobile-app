// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/place_order_service.dart';
import 'package:no_name_ecommerce/view/payments/squareup_payment.dart';
import 'package:provider/provider.dart';

class SquareService {
  payBySquare(BuildContext context) {
    Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();

    // var amount;
    // var bcProvider =
    //     Provider.of<BookConfirmationService>(context, listen: false);
    // var pProvider = Provider.of<PersonalizationService>(context, listen: false);
    // var bookProvider = Provider.of<BookService>(context, listen: false);

    // var name = bookProvider.name ?? '';
    // var phone = bookProvider.phone ?? '';
    // var email = bookProvider.email ?? '';

    // if (pProvider.isOnline == 0) {
    //   amount = bcProvider.totalPriceAfterAllcalculation.toStringAsFixed(2);
    // } else {
    //   amount = bcProvider.totalPriceOnlineServiceAfterAllCalculation
    //       .toStringAsFixed(2);
    // }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => SquareUpPayment(
          amount: 'amount',
          name: 'name',
          phone: 'phone',
          email: 'email',
        ),
      ),
    );
  }
}
