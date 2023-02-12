import 'package:flutter/material.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:no_name_ecommerce/services/search_product_service.dart';
import 'package:no_name_ecommerce/view/home/components/product_card.dart';
import 'package:no_name_ecommerce/view/product/product_details_page.dart';
import 'package:no_name_ecommerce/view/search/components/search_bar.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    print('build ran =======');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarCommon('Search', context, () {
        Navigator.pop(context);
      }),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: context.watch<SearchProductService>().currentPage > 1
            ? false
            : true,
        onRefresh: () async {
          final result =
              await Provider.of<SearchProductService>(context, listen: false)
                  .searchProducts(context);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result =
              await Provider.of<SearchProductService>(context, listen: false)
                  .searchProducts(context);
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
            child: Consumer<SearchProductService>(
              builder: (context, provider, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sizedboxCustom(10),
                    const SearchBar(),
                    sizedboxCustom(10),
                    provider.noProductFound == false
                        ? provider.productList.isNotEmpty
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
                                      imageLink:
                                          provider.productList[i].imgUrl ??
                                              placeHolderUrl,
                                      title: provider.productList[i].title,
                                      width: 180,
                                      marginRight: 0,
                                      pressed: () {
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
                                      discountPrice:
                                          provider.productList[i].discountPrice,
                                      oldPrice: provider.productList[i].price,
                                      camapaignId: 1);
                                })
                            : Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 60),
                                child: showLoading(primaryColor),
                              )
                        : Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 60),
                            child: const Text('No product found'),
                          ),
                    sizedboxCustom(30),
                  ]),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: goToCartButton(context)
    );
  }
}
