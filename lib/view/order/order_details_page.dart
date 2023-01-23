import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon('Order details', context, (() {
        Navigator.pop(context);
      })),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: screenPadHorizontal),
        child: Column(children: [
          //details top
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.15),
                  borderRadius: BorderRadius.circular(7)),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleCommon('Order #43'),
                          sizedboxCustom(10),
                          paragraphCommon('\$809',
                              fontsize: 30, color: primaryColor),
                        ]),
                  ),

                  //
                  Expanded(
                      child: Column(
                    children: [
                      buttonPrimary('Status: Pending', (() {}),
                          paddingVertical: 10, bgColor: Colors.yellow[800]),
                      sizedboxCustom(10),
                      buttonPrimary('Status: Pending', (() {}),
                          paddingVertical: 10, bgColor: Colors.green[800]),
                    ],
                  ))
                ],
              )),

//==========>
// order details
        ]),
      ),
    );
  }
}
