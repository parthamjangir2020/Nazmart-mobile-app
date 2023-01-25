import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';

class OrderDetailsSection extends StatelessWidget {
  const OrderDetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 25),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(9)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            titleCommon('Order Details'),
            const SizedBox(
              height: 25,
            ),
            //Service row

            bRow('Date', 'Jan 12, 2023'),

            bRow('Subtotal', '\$750'),

            bRow('Coupon Discount', '\$0'),

            bRow('Tax', '5%'),

            bRow('Shipping Cost', '\$11'),

            bRow('Payment method', 'Stripe'),

            bRow('Total', '\$50'),
          ]),
        ),
      ],
    );
  }
}
