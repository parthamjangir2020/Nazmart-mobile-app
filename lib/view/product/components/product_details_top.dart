import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/cart_services/favourite_service.dart';
import 'package:no_name_ecommerce/services/product_details_service.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

class ProductDetailsTop extends StatefulWidget {
  const ProductDetailsTop({super.key, required this.title, required this.id});

  final title;
  final id;

  @override
  State<ProductDetailsTop> createState() => _ProductDetailsTopState();
}

class _ProductDetailsTopState extends State<ProductDetailsTop> {
  bool favourite = false;

  @override
  void initState() {
    super.initState();
    checkFav();
  }

  checkFav() async {
    favourite = await Provider.of<FavouriteService>(context, listen: false)
        .checkFavourite(widget.title, widget.id);
    Future.delayed(const Duration(microseconds: 500), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TranslateStringService>(
      builder: (context, ln, child) => Consumer<ProductDetailsService>(
        builder: (context, provider, child) => Consumer<FavouriteService>(
          builder: (context, fProvider, child) => Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapH(5),
                  //Title
                  Row(
                    children: [
                      Expanded(
                        child: titleCommon(
                            '${provider.productDetails?.product?.name}'),
                      ),

                      //favourite icon
                      //=======>

                      InkWell(
                        onTap: () async {
                          await fProvider.addOrRemoveFavourite(context,
                              productId:
                                  provider.productDetails?.product?.id ?? 0,
                              title:
                                  provider.productDetails?.product?.name ?? '',
                              thumbnail:
                                  provider.productDetails?.product?.image ??
                                      placeHolderUrl,
                              discountPrice:
                                  provider.productDetails?.product?.salePrice,
                              oldPrice:
                                  provider.productDetails?.product?.price);

                          checkFav();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor)),
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(left: 20),
                            child: favourite
                                ? const Icon(
                                    Icons.favorite,
                                    color: primaryColor,
                                  )
                                : const Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.grey,
                                  )),
                      )
                    ],
                  ),

                  Row(
                    children: [
                      //Price
                      titleCommon(
                          '\$${provider.productDetails?.product?.salePrice}',
                          color: primaryColor,
                          fontsize: 16),

                      const SizedBox(
                        width: 10,
                      ),

                      //old price
                      Text(
                        '\$${provider.productDetails?.product?.price}',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),

                  gapH(5),

                  //Rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: orangeColor,
                      ),
                      paragraphCommon('(${provider.ratingCount})')
                    ],
                  ),
                ],
              ),

              //stock status
              Row(
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: successColor),
                          borderRadius: BorderRadius.circular(20)),
                      child: paragraphCommon(
                          provider.inStock
                              ? ln.getString(ConstString.inStock)
                              : ln.getString(ConstString.outOfStock),
                          fontsize: 11,
                          lineHeight: 1.1,
                          fontweight: FontWeight.w600,
                          color: provider.inStock ? successColor : Colors.red)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
