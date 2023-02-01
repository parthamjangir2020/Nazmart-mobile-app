import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';

class ProductDetailsTop extends StatelessWidget {
  const ProductDetailsTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedboxCustom(5),
            //Title
            Row(
              children: [
                Expanded(
                  child: titleCommon('Red T-Shirt'),
                ),

                //favourite icon
                //=======>

                InkWell(
                  onTap: () {},
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: borderColor)),
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(left: 20),
                      child: const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.grey,
                      )),
                )
              ],
            ),

            Row(
              children: [
                //Price
                titleCommon('\$200', color: primaryColor, fontsize: 16),

                const SizedBox(
                  width: 10,
                ),

                //old price
                Text(
                  '\$220',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 15,
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
                paragraphCommon('(29)')
              ],
            ),
          ],
        ),

        //stock status
        Row(
          children: [
            Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: successColor),
                    borderRadius: BorderRadius.circular(20)),
                child: paragraphCommon('In stock',
                    fontsize: 11,
                    lineHeight: 1.1,
                    fontweight: FontWeight.w600,
                    color: successColor)),
          ],
        )
      ],
    );
  }
}
