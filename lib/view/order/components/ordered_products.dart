import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';

class OrderedProducts extends StatelessWidget {
  const OrderedProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(9)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleCommon('Products'),
          const SizedBox(
            height: 20,
          ),
          for (int i = 0; i < 3; i++)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              titleCommon('Towel set', fontsize: 15),
              sizedboxCustom(5),
              paragraphCommon('Size: M , Color: red, Quantity: 1'),
              sizedboxCustom(12),
            ])
        ],
      ),
    );
  }
}
