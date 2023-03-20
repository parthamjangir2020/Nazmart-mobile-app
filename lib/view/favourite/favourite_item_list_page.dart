import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:no_name_ecommerce/services/currency_service.dart';
import 'package:no_name_ecommerce/services/cart_services/favourite_service.dart';
import 'package:no_name_ecommerce/services/product_details_service.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/view/product/product_details_page.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
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
      appBar: appbarCommon(ConstString.favourite, context, () {},
          hasBackButton: false),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenPadHorizontal),
          child: Consumer<TranslateStringService>(
            builder: (context, ln, child) => Consumer<ProductDetailsService>(
              builder: (context, pProvider, child) =>
                  Consumer<FavouriteService>(
                builder: (context, fProvider, child) => fProvider
                        .favItemList.isNotEmpty
                    ? Consumer<CurrencyService>(
                        builder: (context, cP, child) => Column(children: [
                          gapH(10),
                          for (int i = 0; i < fProvider.favItemList.length; i++)
                            InkWell(
                              onTap: () {
                                Provider.of<ProductDetailsService>(context,
                                        listen: false)
                                    .fetchProductDetails(context,
                                        productId: fProvider.favItemList[i]
                                            ['productId']);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        ProductDetailsPage(
                                      productId: fProvider.favItemList[i]
                                          ['productId'],
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                          //remove from list
                                          //to remove we only need to pass id and title
                                          fProvider.addOrRemoveFavourite(
                                              context,
                                              productId: fProvider
                                                  .favItemList[i]['productId'],
                                              thumbnail: '',
                                              discountPrice: '',
                                              oldPrice: '',
                                              title: fProvider.favItemList[i]
                                                      ['title'] ??
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: dividerCommon(),
                                  )
                                ],
                              ),
                            ),
                          gapH(30)
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
                            gapH(10),
                            Text(ln.getString(ConstString.noProdAddedToFav)),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
