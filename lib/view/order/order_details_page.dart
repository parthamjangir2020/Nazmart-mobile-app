import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/order_service.dart';
import 'package:no_name_ecommerce/view/order/components/order_details_section.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:no_name_ecommerce/view/utils/responsive.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.orderId});

  final orderId;

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderService>(context, listen: false)
        .fetchOrderDetails(context, orderId: orderId);

    return Scaffold(
      appBar: appbarCommon('Order details', context, (() {
        Navigator.pop(context);
      })),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Consumer<OrderService>(
          builder: (context, op, child) => op.orderDetails != null
              ? Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding:
                      EdgeInsets.symmetric(horizontal: screenPadHorizontal),
                  child: Column(children: [
                    //details top
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.15),
                            borderRadius: BorderRadius.circular(7)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    titleCommon(
                                        'Order #${op.orderDetails?.data.id}'),
                                    gapH(10),
                                    paragraphCommon(
                                        '\$${op.orderDetails?.data.totalAmount}',
                                        fontsize: 30,
                                        color: primaryColor),
                                  ]),
                            ),

                            //
                            Expanded(
                                child: Column(
                              children: [
                                buttonPrimary(
                                    'Payment: ${op.orderDetails?.data.paymentStatus}',
                                    (() {}),
                                    paddingVertical: 10,
                                    bgColor: Colors.yellow[800]),
                                gapH(10),
                                buttonPrimary(
                                    'Order: ${op.orderDetails?.data.status}',
                                    (() {}),
                                    paddingVertical: 10,
                                    bgColor: Colors.green[800]),
                              ],
                            ))
                          ],
                        )),

                    //==========>
                    // order details

                    gapH(25),
                    const OrderDetailsSection(),

                    // const OrderedProducts(),

                    buttonPrimary('Request refund', (() {}),
                        bgColor: Colors.red),

                    gapH(25),
                  ]),
                )
              : Container(
                  alignment: Alignment.center,
                  height: screenHeight - 150,
                  child: showLoading(primaryColor),
                ),
        ),
      ),
    );
  }
}
