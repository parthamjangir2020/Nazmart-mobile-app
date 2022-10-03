import 'package:flutter/material.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:no_name_ecommerce/services/search_product_service.dart';
import 'package:no_name_ecommerce/view/search/components/search_bar.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
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
    // Provider.of<CategoryDropdownService>(context, listen: false)
    //     .fetchCategory(context);
    super.initState();
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Search', context, () {
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

                      //Filter========>
                      paragraphStyleTitle('Filter by:'),
                      sizedboxCustom(10),

                      // provider.isLoading == false
                      //     ? provider.productsMap.isNotEmpty
                      //         ? provider.productsMap[0] != 'error'
                      //
                      provider.noProductFound == false
                          ? provider.productsMap.isNotEmpty
                              ? GridView.builder(
                                  gridDelegate: const FlutterzillaFixedGridView(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 25,
                                      crossAxisSpacing: 25,
                                      height: 240),
                                  shrinkWrap: true,
                                  itemCount: provider.productsMap.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    return ProductCard(
                                      thumbnail: provider.productsMap[i]
                                              ['imgUrl'] ??
                                          placeHolderUrl,
                                      title: provider.productsMap[i]['title']
                                          .toString(),
                                      marginRight: 0,
                                      oldPrice: provider.productsMap[i]
                                              ['oldPrice']
                                          .toString(),
                                      discountPrice: provider.productsMap[i]
                                              ['discountPrice']
                                          .toString(),
                                      discountPercent: provider.productsMap[i]
                                          ['discountPercent'],
                                      attribute: provider.productsMap[i]
                                          ['attribute'],
                                      stockCount: provider.productsMap[i]
                                          ['stockCount'],
                                      productId: provider.productsMap[i]
                                          ['productId'],
                                      index: i,
                                      whichProduct: whichProductList[4],
                                      isFav: provider.productsMap[i]
                                          ['isFavourite'],
                                      addedToCart: provider.productsMap[i]
                                          ['isAddedToCart'],
                                    );
                                  })
                              : Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 60),
                                  child: OthersHelper()
                                      .showLoading(cc.primaryColor),
                                )
                          : Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 60),
                              child: const Text('No product found'),
                            )
                    ]),
              ),
            ),
          ),
        ),
        bottomNavigationBar: goToCartButton(context));
  }
}
