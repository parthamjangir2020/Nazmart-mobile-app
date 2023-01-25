import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';

class ShipReturnTab extends StatelessWidget {
  const ShipReturnTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraphCommon('Return in 7 Days is acceptable',
            textAlign: TextAlign.start),
      ],
    );
  }
}
