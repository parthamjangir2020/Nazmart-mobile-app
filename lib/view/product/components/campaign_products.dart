import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/rtl_service.dart';
import 'package:no_name_ecommerce/view/home/components/section_title.dart';
import 'package:no_name_ecommerce/view/product/all_featured_products_page.dart';
import 'package:no_name_ecommerce/view/product/components/campaign_timer.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

class CampaignProducts extends StatefulWidget {
  const CampaignProducts({
    Key? key,
  }) : super(key: key);

  @override
  State<CampaignProducts> createState() => _CampaignProductsState();
}

class _CampaignProductsState extends State<CampaignProducts> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Campaign products',
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
        Container(
          margin: const EdgeInsets.only(top: 5),
          height: 280,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            clipBehavior: Clip.none,
            children: [
              for (int i = 0; i < 5; i++)
                InkWell(
                  onTap: (() {}),
                  child: Consumer<RtlService>(
                    builder: (context, rtlP, child) => Container(
                      alignment: Alignment.center,
                      width: 300,
                      margin: EdgeInsets.only(
                        right: rtlP.direction == 'ltr' ? 20 : 0,
                        left: rtlP.direction == 'ltr' ? 0 : 20,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  height: 140,
                                  width: double.infinity,
                                  imageUrl:
                                      'https://cdn.pixabay.com/photo/2020/12/14/15/59/man-5831295_1280.jpg',
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),

                              // off percent / discount
                              Positioned(
                                  right: 6,
                                  top: 6,
                                  child: Container(
                                    color: primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    child: paragraphCommon('74% off',
                                        color: Colors.white),
                                  ))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizedboxCustom(10),
                              //Title
                              const Text(
                                'This is title',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: blackCustomColor,
                                    fontSize: 14,
                                    height: 1.3,
                                    fontWeight: FontWeight.w600),
                              ),

                              sizedboxCustom(5),
                              //Price
                              const Text(
                                '\$200',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),

                              sizedboxCustom(15),

                              const CampaignTimer()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
