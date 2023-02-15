import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/services/product_details_service.dart';
import 'package:no_name_ecommerce/view/product/components/write_review_page.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

class ProductDetailsBottom extends StatefulWidget {
  const ProductDetailsBottom({
    Key? key,
    required this.tabIndex,
  }) : super(key: key);

  final tabIndex;

  @override
  State<ProductDetailsBottom> createState() => _ProductDetailsBottomState();
}

class _ProductDetailsBottomState extends State<ProductDetailsBottom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 17),
      decoration: const BoxDecoration(
        // color: blackColor,
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Consumer<ProductDetailsService>(
        builder: (context, provider, child) => Column(
          children: [
            widget.tabIndex == 1
                ? Column(
                    children: [
                      buttonPrimary('Write a review', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const WriteReviewPage(
                              productId: '1',
                            ),
                          ),
                        );
                      }, bgColor: successColor, borderRadius: 100),
                      const SizedBox(
                        height: 9,
                      ),
                    ],
                  )
                : Container(),
            Consumer<CartService>(
              builder: (context, cProvider, child) => Row(
                children: [
                  Expanded(
                      child: buttonPrimary('Buy now', (() {}),
                          borderRadius: 100,
                          bgColor: Colors.grey[200],
                          fontColor: Colors.grey[800])),
                  const SizedBox(
                    width: 15,
                  ),
                  //======>
                  Expanded(
                    child: buttonPrimary('Add to cart', () {
                      print(provider.selectedInventorySet);
                      print(provider.productSalePrice);
                      // print(provider.productSalePrice);
                      // return;
                      if (provider.selectedInventorySet.isEmpty) {
                        showToast(
                            'You must select all attributes', Colors.black);
                        return;
                      }

                      cProvider.addToCartOrUpdateQty(context,
                          title: provider.productDetails?.product?.name ?? '',
                          thumbnail: provider.productDetails?.product?.image ??
                              placeHolderUrl,
                          discountPrice: provider
                                  .productDetails?.product?.salePrice
                                  .toString() ??
                              '0',
                          oldPrice: provider.productDetails?.product?.price
                                  .toString() ??
                              '0',
                          priceWithAttr: provider.productSalePrice,
                          qty: 1,
                          color: provider.selectedInventorySet['color_code'],
                          size: provider.selectedInventorySet['Size'],
                          productId:
                              provider.productDetails?.product?.id.toString() ??
                                  '1');
                    }, borderRadius: 100),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
