import 'package:flutter/material.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/services/discover_products_service.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/view/home/components/product_card.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:no_name_ecommerce/view/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    // Provider.of<CategoryDropdownService>(context, listen: false)
    //     .fetchCategory(context);
    super.initState();
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: greyPrimary),
          title: Consumer<TranslateStringService>(
            builder: (context, ln, child) => Text(
              ln.getString(ConstString.discover),
              style: const TextStyle(
                  color: greyPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: context.watch<DiscoverProductsService>().currentPage > 1
            ? false
            : true,
        onRefresh: () async {
          final result =
              await Provider.of<DiscoverProductsService>(context, listen: false)
                  .fetchProducts(context);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result =
              await Provider.of<DiscoverProductsService>(context, listen: false)
                  .fetchProducts(context);
          if (result) {
            debugPrint('loadcomplete ran');
            //loadcomplete function loads the data again
            refreshController.loadComplete();
          } else {
            debugPrint('no more data');
            refreshController.loadNoData();

            Future.delayed(const Duration(seconds: 1), () {
              //it will reset footer no data state to idle and will let us load again
              refreshController.resetNoData();
            });
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadHorizontal),
            child: Consumer<DiscoverProductsService>(
              builder: (context, provider, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    gapH(10),
                    provider.productList.isNotEmpty
                        ? GridView.builder(
                            gridDelegate: const FlutterzillaFixedGridView(
                                crossAxisCount: 2,
                                mainAxisSpacing: 25,
                                crossAxisSpacing: 25,
                                height: 280),
                            shrinkWrap: true,
                            itemCount: provider.productList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return ProductCard(
                                imageLink: provider.productList[i].imgUrl ??
                                    placeHolderUrl,
                                title: provider.productList[i].title,
                                width: 180,
                                marginRight: 0,
                                discountPrice:
                                    provider.productList[i].discountPrice,
                                oldPrice: provider.productList[i].price,
                                productId: provider.productList[i].prdId,
                                ratingAverage:
                                    provider.productList[i].avgRatting,
                                pressed: () {
                                  gotoProductDetails(
                                      context, provider.productList[i].prdId);
                                },
                              );
                            })
                        : Container(
                            alignment: Alignment.center,
                            height: screenHeight - 180,
                            child: showLoading(primaryColor),
                          ),
                    gapH(30),
                  ]),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: goToCartButton(context)
    );
  }
}
