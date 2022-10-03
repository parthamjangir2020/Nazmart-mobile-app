// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/payments/zitopay_payment_page.dart';
import 'package:provider/provider.dart';

class ZitopayService {
  payByZitopay(BuildContext context) {
    //========>
    // Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();

    // var amount;
    // var bcProvider =
    //     Provider.of<BookConfirmationService>(context, listen: false);
    // var pProvider = Provider.of<PersonalizationService>(context, listen: false);
    // var userName =
    //     Provider.of<PaymentGatewayListService>(context, listen: false)
    //         .zitopayUserName;

    // if (pProvider.isOnline == 0) {
    //   amount = bcProvider.totalPriceAfterAllcalculation.toStringAsFixed(2);
    // } else {
    //   amount = bcProvider.totalPriceOnlineServiceAfterAllCalculation
    //       .toStringAsFixed(2);
    // }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ZitopayPaymentPage(
          amount: 'amount',
          userName: 'userName',
        ),
      ),
    );
  }
}
