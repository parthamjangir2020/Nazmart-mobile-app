import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/cart_services/coupon_service.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';
import 'package:provider/provider.dart';

import '../../utils/common_helper.dart';

class CouponField extends StatelessWidget {
  const CouponField(
      {Key? key, required this.cartItemList, required this.couponController})
      : super(key: key);

  final cartItemList;
  final couponController;

  @override
  Widget build(BuildContext context) {
    return Consumer<CouponService>(
      builder: (context, couponProvider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH(20),
          labelCommon("Coupon code"),
          Row(
            children: [
              Expanded(
                  child: CustomInput(
                hintText: 'Enter coupon code',
                paddingHorizontal: 20,
                marginBottom: 0,
              )),
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: 100,
                child: buttonPrimary('Apply', () {
                  // if (couponController.text.isNotEmpty) {
                  //   if (couponProvider.isloading == false) {
                  //     couponProvider.getCouponDiscount(
                  //         cartItemList, couponController.text, context);
                  //   }
                  // }
                },
                    isloading: couponProvider.isloading == false ? false : true,
                    borderRadius: 100),
              )
            ],
          ),
        ],
      ),
    );
  }
}
