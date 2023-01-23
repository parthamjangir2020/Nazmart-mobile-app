import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:no_name_ecommerce/services/currency_service.dart';
import 'package:no_name_ecommerce/services/fav_service.dart';
import 'package:no_name_ecommerce/view/product/product_details_page.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
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
    Provider.of<FavService>(context, listen: false).fetchFavProducts();
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
          child: Consumer<FavService>(
              builder: (context, provider, child) =>
                  //  provider
                  //         .favItemList.isNotEmpty
                  //     ?
                  Consumer<CurrencyService>(
                    builder: (context, cP, child) => Column(children: [
                      sizedboxCustom(10),
                      for (int i = 0; i < 3; i++)
                        InkWell(
                          onTap: () {
                            // Provider.of<ProductDetailsService>(context,
                            //         listen: false)
                            //     .fetchDetails(
                            //         provider.favItemList[i]['productId']);
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const ProductDetailsPage(),
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
                                          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1099&q=80',
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
                                              'Black Shirt',
                                              textAlign: TextAlign.left,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: blackCustomColor,
                                                  fontSize: 13,
                                                  height: 1.4,
                                                  fontWeight: FontWeight.w600),
                                            ),

                                            //Price and stock
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              "100",
                                              textAlign: TextAlign.left,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                                  //Delete button
                                  InkWell(
                                    onTap: () {
                                      // provider.remove(
                                      //     provider.favItemList[i]['productId'],
                                      //     provider.favItemList[i]['title'],
                                      //     provider.favItemList[i]['thumbnail'],
                                      //     provider.favItemList[i]
                                      //         ['discountPrice'],
                                      //     provider.favItemList[i]['oldPrice'],
                                      //     context);
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
              // : Container(
              //     alignment: Alignment.center,
              //     height: screenHeight - 140,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.hourglass_empty,
              //           color: greyFour,
              //         ),
              //         sizedboxCustom(10),
              //         const Text("No products added to favourite"),
              //       ],
              //     ),
              //   ),
              ),
        )),
      ),
    );
  }
}
