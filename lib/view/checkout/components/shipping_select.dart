import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/delivery_address_service.dart';
import 'package:no_name_ecommerce/view/order/delivery_address_page.dart';
import 'package:provider/provider.dart';

import '../../utils/constant_styles.dart';

class ShippingSelect extends StatelessWidget {
  const ShippingSelect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliveryAddressService>(
      builder: (context, dProvider, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping option',
                  style: TextStyle(
                    color: cc.greyParagraph,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const DeliveryAddressPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 12, 20, 9),
                    child: Text(
                      'Add delivery address',
                      style: TextStyle(
                        color: cc.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: AutoSizeText(
              dProvider.selectedShipName,
              maxLines: 1,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: cc.greyFour,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
