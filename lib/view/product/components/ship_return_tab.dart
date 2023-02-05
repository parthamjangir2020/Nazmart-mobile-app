import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/product_details_service.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:provider/provider.dart';

class ShipReturnTab extends StatelessWidget {
  const ShipReturnTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsService>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          paragraphCommon(
              '${provider.productDetails?.returnPolicy.shippingReturnDescription}',
              textAlign: TextAlign.start),
        ],
      ),
    );
  }
}
