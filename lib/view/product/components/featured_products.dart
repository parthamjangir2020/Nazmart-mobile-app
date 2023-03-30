import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/services/featured_product_service.dart';
import 'package:no_name_ecommerce/view/home/components/product_card.dart';
import 'package:no_name_ecommerce/view/home/components/section_title.dart';
import 'package:no_name_ecommerce/view/product/all_featured_products_page.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:provider/provider.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: ConstString.featuredProducts,
          pressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    const AllFeaturedProductsPage(),
              ),
            );
          },
        ),
        const SizedBox(
          height: 18,
        ),
        Consumer<FeaturedProductService>(
          builder: (context, p, child) => p.featuredProducts != null
              ? Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 235,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    clipBehavior: Clip.none,
                    children: [
                      for (int i = 0; i < p.featuredProducts!.data.length; i++)
                        ProductCard(
                          imageLink: p.featuredProducts?.data[i].imgUrl ??
                              placeHolderUrl,
                          title: p.featuredProducts?.data[i].title,
                          width: 180,
                          oldPrice: p.featuredProducts?.data[i].price,
                          discountPrice:
                              p.featuredProducts?.data[i].discountPrice,
                          marginRight: 20,
                          productId: p.featuredProducts?.data[i].prdId,
                          ratingAverage: p.featuredProducts?.data[i].avgRatting,
                          discountPercent:
                              p.featuredProducts?.data[i].campaignPercentage,
                          pressed: () {
                            gotoProductDetails(
                                context, p.featuredProducts?.data[i].prdId);
                          },
                        )
                    ],
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}
