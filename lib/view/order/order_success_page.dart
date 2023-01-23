import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name_ecommerce/services/bottom_nav_service.dart';
import 'package:no_name_ecommerce/services/place_order_service.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

import '../home/landing_page.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderId =
        Provider.of<PlaceOrderService>(context, listen: false).orderId;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarCommon('', context, () {
        Provider.of<BottomNavService>(context, listen: false)
            .setCurrentIndex(0);
        Navigator.pop(context);
      }),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenPadHorizontal),
        // height: screenHeight - 200,
        // alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg/basket.svg',
                height: 140,
              ),
              sizedboxCustom(20),
              Text(
                'Order successful!',
                style: TextStyle(
                    color: greyPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              sizedboxCustom(10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      'Your order has been successfully Placed!  Your order ID is  ',
                  style: TextStyle(
                      color: greyParagraph, fontSize: 15, height: 1.4),
                  children: <TextSpan>[
                    TextSpan(
                        text: '#$orderId',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              sizedboxCustom(90)
            ]),
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: Row(children: [
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(left: 20, bottom: 20),
            child: borderButtonPrimary('Back to home', () {
              Provider.of<BottomNavService>(context, listen: false)
                  .setCurrentIndex(0);

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LandingPage()),
                  (Route<dynamic> route) => false);
            }),
          )),
          const SizedBox(
            width: 18,
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(right: 20, bottom: 20),
            child: buttonPrimary('See order details', () {
              // Provider.of<OrderDetailsService>(context, listen: false)
              //     .fetchOrderDetails(orderId);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute<void>(
              //     builder: (BuildContext context) =>
              //         OrderDetailsPage(orderId: orderId),
              //   ),
              // );
            }),
          ))
        ]),
      ),
    );
  }
}
