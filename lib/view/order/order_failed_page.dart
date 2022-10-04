import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';

import '../home/landing_page.dart';

class OrderFailedPage extends StatelessWidget {
  const OrderFailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('', context, () {
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
                'assets/svg/cancelled.svg',
                height: 100,
              ),
              sizedboxCustom(20),
              Text(
                'Oops!',
                style: TextStyle(
                    color: cc.greyPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              sizedboxCustom(10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      'We’re getting problems with your payment methods and we couldn’t proceed your order',
                  style: TextStyle(
                      color: cc.greyParagraph, fontSize: 15, height: 1.4),
                  // children: <TextSpan>[
                  //   // TextSpan(
                  //   //     text: '#2385489',
                  //   //     style: TextStyle(
                  //   //         color: cc.primaryColor,
                  //   //         fontWeight: FontWeight.bold)),
                  // ],
                ),
              ),
              sizedboxCustom(90)
            ]),
      ),
      bottomNavigationBar: Container(
        height: 55,
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: CommonHelper().buttonPrimary('Back to home', () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LandingPage()),
              (Route<dynamic> route) => false);
        }),
      ),
    );
  }
}
