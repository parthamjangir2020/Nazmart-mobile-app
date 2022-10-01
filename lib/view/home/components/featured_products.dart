import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/home/components/product_card.dart';
import 'package:no_name_ecommerce/view/home/components/section_title.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';

import 'package:provider/provider.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          cc: cc,
          title: 'Featured products',
          pressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute<void>(
            //     builder: (BuildContext context) =>
            //         const AllFeaturedProductPage(),
            //   ),
            // );
          },
        ),
        const SizedBox(
          height: 14,
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          height: 295,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            clipBehavior: Clip.none,
            children: [
              for (int i = 0; i < 5; i++)
                ProductCard(
                    imageLink:
                        'https://images.unsplash.com/photo-1617537230936-bb8c9327e84f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8ODN8fHByb2R1Y3R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                    title: 'Black T-Shirt',
                    width: 180,
                    marginRight: 20,
                    pressed: () {},
                    price: 32.99,
                    camapaignId: 1)
            ],
          ),
        ),
      ],
    );
  }
}
