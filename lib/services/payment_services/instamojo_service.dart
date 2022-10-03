import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/payments/instamojo_payment_page.dart';
import 'package:provider/provider.dart';

class InstamojoService {
  payByInstamojo(BuildContext context) {
    String amount;
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
        builder: (BuildContext context) => InstamojoPaymentPage(
          amount: 'amount',
          name: 'name',
          email: 'email',
        ),
      ),
    );
  }
}
