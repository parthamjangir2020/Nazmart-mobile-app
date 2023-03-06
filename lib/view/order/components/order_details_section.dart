import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/order_service.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

class OrderDetailsSection extends StatelessWidget {
  const OrderDetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderService>(
      builder: (context, op, child) {
        var meta;
        if (op.orderDetails != null) {
          meta = jsonDecode(op.orderDetails?.data.paymentMeta);
        }

        return meta != null
            ? Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleCommon('Order Details'),
                          const SizedBox(
                            height: 25,
                          ),
                          //Service row

                          // bRow('Date', op.orderDetails.data.),

                          bRow('Subtotal', '\$${meta['subtotal']}'),

                          bRow('Coupon Discount',
                              '\$${meta['coupon_discounted'] ?? '0'}'),

                          bRow('Tax', '${meta['product_tax']}'),

                          bRow('Shipping Cost', '\$${meta['shipping_cost']}'),

                          bRow('Payment method',
                              '${op.orderDetails?.data.paymentGateway}'),

                          bRow('Total',
                              '\$${op.orderDetails?.data.totalAmount}'),
                        ]),
                  ),
                ],
              )
            : Container();
      },
    );
  }
}
