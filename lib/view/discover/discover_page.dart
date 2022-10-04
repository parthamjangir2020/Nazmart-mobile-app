import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:no_name_ecommerce/services/search_product_service.dart';
import 'package:no_name_ecommerce/view/home/components/product_card.dart';
import 'package:no_name_ecommerce/view/product/product_details_page.dart';
import 'package:no_name_ecommerce/view/search/components/product_filter.dart';
import 'package:no_name_ecommerce/view/search/components/search_bar.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
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
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: cc.greyPrimary),
        title: Text(
          'Discover',
          style: TextStyle(
              color: cc.greyPrimary, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {},
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) => const ProductFilter(),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: cc.inputFieldBorderColor)),
                    child: SvgPicture.asset(
                      'assets/svg/filter.svg',
                      height: 21,
                    )),
              ],
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: refreshController,
        // enablePullUp: true,
        // enablePullDown: context.watch<SearchProductService>().currentPage > 1
        //     ? false
        //     : true,
        // onRefresh: () async {
        //   final result =
        //       await Provider.of<SearchProductService>(context, listen: false)
        //           .searchProducts(context);
        //   if (result) {
        //     refreshController.refreshCompleted();
        //   } else {
        //     refreshController.refreshFailed();
        //   }
        // },
        // onLoading: () async {
        //   final result =
        //       await Provider.of<SearchProductService>(context, listen: false)
        //           .searchProducts(context);
        //   if (result) {
        //     debugPrint('loadcomplete ran');
        //     //loadcomplete function loads the data again
        //     refreshController.loadComplete();
        //   } else {
        //     debugPrint('no more data');
        //     refreshController.loadNoData();

        //     Future.delayed(const Duration(seconds: 1), () {
        //       //it will reset footer no data state to idle and will let us load again
        //       refreshController.resetNoData();
        //     });
        //   }
        // },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadHorizontal),
            child: Consumer<SearchProductService>(
              builder: (context, provider, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sizedboxCustom(10),

                    // provider.isLoading == false
                    //     ? provider.productsMap.isNotEmpty
                    //         ? provider.productsMap[0] != 'error'
                    //
                    // provider.noProductFound == false
                    //     ? provider.productsMap.isNotEmpty
                    //         ?
                    GridView.builder(
                        gridDelegate: const FlutterzillaFixedGridView(
                            crossAxisCount: 2,
                            mainAxisSpacing: 25,
                            crossAxisSpacing: 25,
                            height: 280),
                        shrinkWrap: true,
                        itemCount: 8,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return ProductCard(
                              imageLink:
                                  'https://images.unsplash.com/photo-1617537230936-bb8c9327e84f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8ODN8fHByb2R1Y3R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                              title: 'Black T-Shirt',
                              width: 180,
                              marginRight: 0,
                              pressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const ProductDetailsPage(),
                                  ),
                                );
                              },
                              price: 32.99,
                              camapaignId: 1);
                        }),
                    //     : Container(
                    //         alignment: Alignment.center,
                    //         margin: const EdgeInsets.only(top: 60),
                    //         child:
                    //             OthersHelper().showLoading(cc.primaryColor),
                    //       )
                    // : Container(
                    //     alignment: Alignment.center,
                    //     margin: const EdgeInsets.only(top: 60),
                    //     child: const Text('No product found'),
                    //   )

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
