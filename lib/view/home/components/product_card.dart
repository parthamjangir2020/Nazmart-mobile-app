// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/rtl_service.dart';
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
    ConstantColors cc = ConstantColors();
    return InkWell(
      onTap: pressed,
      child: Consumer<RtlService>(
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                    style: TextStyle(
                        color: cc.blackCustomColor,
                        fontSize: 14,
                        height: 1.3,
                        fontWeight: FontWeight.w600),
                  ),

                  sizedboxCustom(5),
                  //Price
                  Text(
                    '\$$price',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: cc.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),

                  sizedboxCustom(5),

                  //Rating
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: cc.orangeColor,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        '4.5',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: cc.greyParagraph,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '(29)',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: cc.greyParagraph,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  sizedboxCustom(14),

                  //Donate button
                  CommonHelper().borderButtonPrimary('Add to cart', () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute<void>(
                    //     builder: (BuildContext context) =>
                    //         DonationPaymentChoosePage(
                    //             campaignId: camapaignId),
                    //   ),
                    // );
                  },
                      paddingVertical: 11,
                      borderRadius: 7,
                      color: cc.greyFour,
                      fontsize: 13)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
