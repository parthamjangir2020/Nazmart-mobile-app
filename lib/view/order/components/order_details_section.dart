import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/order_service.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

class OrderDetailsSection extends StatelessWidget {
  const OrderDetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TranslateStringService>(
      builder: (context, ln, child) => Consumer<OrderService>(
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
                            titleCommon(ln.getString(ConstString.orderDetails)),
                            const SizedBox(
                              height: 25,
                            ),
                            //Service row

                            // bRow('Date', op.orderDetails.data.),

                            bRow(ConstString.subtotal, '\$${meta['subtotal']}'),

                            bRow(ConstString.couponDiscount,
                                '\$${meta['coupon_discounted'] ?? '0'}'),

                            bRow(ConstString.tax, '${meta['product_tax']}'),

                            bRow(ConstString.shippingCost,
                                '\$${meta['shipping_cost']}'),

                            bRow(ConstString.paymentMethod,
                                '${op.orderDetails?.data.paymentGateway}'),

                            bRow(ConstString.total,
                                '\$${op.orderDetails?.data.totalAmount}'),
                          ]),
                    ),
                  ],
                )
              : Container();
        },
      ),
    );
  }
}
