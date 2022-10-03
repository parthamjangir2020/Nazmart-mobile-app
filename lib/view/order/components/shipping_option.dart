// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/currency_service.dart';
import 'package:provider/provider.dart';

import '../../utils/constant_styles.dart';

class ShippingOption extends StatelessWidget {
  const ShippingOption({
    Key? key,
    required this.selectedShipping,
    required this.i,
    required this.dProvider,
  }) : super(key: key);

  final int selectedShipping;
  final int i;
  final dProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyService>(
      builder: (context, cP, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          selectedShipping == i
              ? Icon(
                  Icons.check_box,
                  color: cc.primaryColor,
                )
              : const Icon(Icons.check_box_outline_blank_outlined),
          const SizedBox(
            width: 13,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dProvider.shippingCostDetails.shippingOptions[i].name +
                      " (${cP.currency}${dProvider.shippingCostDetails.shippingOptions[i].options.cost})",
                  style: TextStyle(
                    color: cc.greyFour,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                sizedboxCustom(6),
                Text(
                  dProvider.getShipOptionSubtitle(
                      dProvider.shippingCostDetails.shippingOptions[i].options
                          .settingPreset,
                      dProvider.shippingCostDetails.shippingOptions[i].options
                          .minimumOrderAmount),
                  style: TextStyle(
                      color: cc.greyParagraph, fontSize: 14, height: 1.4),
                ),
                sizedboxCustom(20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
