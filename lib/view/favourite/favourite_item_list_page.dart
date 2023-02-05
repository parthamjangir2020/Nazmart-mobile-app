import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:no_name_ecommerce/services/currency_service.dart';
import 'package:no_name_ecommerce/services/cart_services/favourite_service.dart';
import 'package:no_name_ecommerce/services/product_details_service.dart';
import 'package:no_name_ecommerce/view/product/product_details_page.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/responsive.dart';
import 'package:provider/provider.dart';

class FavouriteItemListPage extends StatefulWidget {
  const FavouriteItemListPage({Key? key}) : super(key: key);

  @override
  State<FavouriteItemListPage> createState() => _FavouriteItemListPageState();
}

class _FavouriteItemListPageState extends State<FavouriteItemListPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<FavouriteService>(context, listen: false).fetchFavProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarCommon('Favourite', context, () {}, hasBackButton: false),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenPadHorizontal),
          child: Consumer<ProductDetailsService>(
            builder: (context, pProvider, child) => Consumer<FavouriteService>(
              builder: (context, fProvider, child) => fProvider
                      .favItemList.isNotEmpty
                  ? Consumer<CurrencyService>(
                      builder: (context, cP, child) => Column(children: [
                        sizedboxCustom(10),
                        for (int i = 0; i < fProvider.favItemList.length; i++)
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const ProductDetailsPage(
                                    productId: '239',
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //title image price
                                    Expanded(
                                        child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        commonImage(
                                            fProvider.favItemList[i]
                                                ['thumbnail'],
                                            55,
                                            55),

                                        const SizedBox(
                                          width: 10,
                                        ),
                                        //title and price
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${fProvider.favItemList[i]['title']}',
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: blackCustomColor,
                                                    fontSize: 13,
                                                    height: 1.4,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),

                                              //Price and stock
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                "\$${fProvider.favItemList[i]['discountPrice']}",
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                    //Delete button
                                    InkWell(
                                      onTap: () {
                                        fProvider.addOrRemoveFavourite(context,
                                            productId: pProvider.productDetails
                                                    ?.product?.id ??
                                                0,
                                            thumbnail: pProvider.productDetails
                                                    ?.product?.image ??
                                                placeHolderUrl,
                                            discountPrice: pProvider
                                                .productDetails
                                                ?.product
                                                ?.salePrice,
                                            oldPrice: pProvider
                                                .productDetails?.product?.price,
                                            title: pProvider.productDetails
                                                    ?.product?.name ??
                                                '');
                                      },
                                      child: SvgPicture.asset(
                                        'assets/svg/trash.svg',
                                        height: 33,
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: dividerCommon(),
                                )
                              ],
                            ),
                          ),
                        sizedboxCustom(30)
                      ]),
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: screenHeight - 140,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.hourglass_empty,
                            color: greyFour,
                          ),
                          sizedboxCustom(10),
                          const Text("No products added to favourite"),
                        ],
                      ),
                    ),
            ),
          ),
        )),
      ),
    );
  }
}
