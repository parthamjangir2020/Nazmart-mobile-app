// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/services/rtl_service.dart';
import 'package:no_name_ecommerce/view/product/product_details_page.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

import '../../utils/constant_colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.imageLink,
    required this.title,
    required this.width,
    required this.marginRight,
    required this.pressed,
    required this.camapaignId,
    required this.price,
  }) : super(key: key);

  final camapaignId;
  final imageLink;
  final title;
  final price;

  final double width;
  final double marginRight;
  final VoidCallback pressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pressed,
      child: Consumer<CartService>(
        builder: (context, cProvider, child) => Consumer<RtlService>(
          builder: (context, rtlP, child) => Container(
            alignment: Alignment.center,
            width: width,
            margin: EdgeInsets.only(
              right: rtlP.direction == 'ltr' ? marginRight : 0,
              left: rtlP.direction == 'ltr' ? 0 : marginRight,
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(9)),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    height: 150,
                    width: double.infinity,
                    imageUrl: imageLink,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedboxCustom(10),
                    //Title
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: blackCustomColor,
                          fontSize: 14,
                          height: 1.3,
                          fontWeight: FontWeight.w600),
                    ),

                    sizedboxCustom(5),
                    //Price
                    Row(
                      children: [
                        paragraphCommon('\$$price',
                            lineHeight: 1.2,
                            fontsize: 14,
                            color: primaryColor,
                            fontweight: FontWeight.w600),

                        const SizedBox(
                          width: 7,
                        ),

                        //old price
                        Text(
                          '\$$price',
                          style: TextStyle(
                              color: Colors.grey[600],
                              decoration: TextDecoration.lineThrough),
                        )
                      ],
                    ),

                    sizedboxCustom(5),

                    //Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: orangeColor,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        paragraphCommon('4.5',
                            lineHeight: 1,
                            fontsize: 13,
                            color: greyParagraph,
                            fontweight: FontWeight.bold),
                        const SizedBox(
                          width: 5,
                        ),
                        paragraphCommon('(29)', lineHeight: 1, fontsize: 13)
                      ],
                    ),
                    sizedboxCustom(10),

                    //Donate button
                    borderButtonPrimary('View details', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProductDetailsPage(
                                    productId: '239',
                                  )));
                      // cProvider.addToCartOrUpdateQty(context,
                      //     title: 'product title',
                      //     thumbnail:
                      //         'https://cdn.pixabay.com/photo/2023/01/14/19/50/flower-7718952_1280.jpg',
                      //     discountPrice: '11',
                      //     oldPrice: '14',
                      //     qty: 1,
                      //     color: 'red',
                      //     colorPrice: '4',
                      //     size: 'M',
                      //     sizePrice: '3',
                      //     productId: '1');
                    },
                        paddingVertical: 11,
                        borderRadius: 7,
                        color: greyFour,
                        borderColor: inputFieldBorderColor,
                        fontsize: 13)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
