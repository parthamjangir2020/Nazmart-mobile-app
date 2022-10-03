import 'package:flutter/material.dart';

import '../../utils/constant_styles.dart';

class FreeShipOption extends StatelessWidget {
  const FreeShipOption({
    Key? key,
    required this.selectedShipping,
    required this.dProvider,
    required this.cc,
  }) : super(key: key);

  final int selectedShipping;
  final dProvider;
  final cc;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        selectedShipping == -1
            ? Icon(
                Icons.check_box,
                color: cc.primaryColor,
              )
            : const Icon(Icons.check_box_outline_blank_outlined),
        const SizedBox(
          width: 13,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dProvider.shippingCostDetails.defaultShipping.name,
              style: TextStyle(
                color: cc.greyFour,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            sizedboxCustom(27)
          ],
        )
      ],
    );
  }
}
