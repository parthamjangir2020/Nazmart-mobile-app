import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/checkout/components/cart_icon.dart';
import 'package:no_name_ecommerce/view/product/components/campaign_timer.dart';
import 'package:no_name_ecommerce/view/product/components/color_size.dart';
import 'package:no_name_ecommerce/view/product/components/description_tab.dart';
import 'package:no_name_ecommerce/view/product/components/product_details_bottom.dart';
import 'package:no_name_ecommerce/view/product/components/product_details_slider.dart';
import 'package:no_name_ecommerce/view/product/components/review_tab.dart';
import 'package:no_name_ecommerce/view/product/components/ship_return_tab.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  int currentTab = 0;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);

    // Provider.of<ServiceDetailsService>(context, listen: false)
    //     .fetchServiceDetails(widget.serviceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: greyFour),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 25, top: 10),
            child: const CartIcon(),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Slider =============>
                    const ProductDetailsSlider(),

// category, subcategory
//====================>

                    // sizedboxCustom(18),

                    // paragraphCommon(
                    //   'Furniture | Tables | Chair',
                    // ),

                    //
                    sizedboxCustom(16),

                    //
                    paragraphCommon('Unit: 1 Pcs  |  SKU: bbs15'),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedboxCustom(5),
                            //Title
                            Row(
                              children: [
                                Expanded(
                                  child: titleCommon('Red T-Shirt'),
                                ),

                                //favourite icon
                                //=======>

                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: borderColor)),
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.only(left: 20),
                                      child: const Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.grey,
                                      )),
                                )
                              ],
                            ),

                            Row(
                              children: [
                                //Price
                                titleCommon('\$200',
                                    color: primaryColor, fontsize: 16),

                                const SizedBox(
                                  width: 10,
                                ),

                                //old price
                                Text(
                                  '\$220',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15,
                                      decoration: TextDecoration.lineThrough),
                                )
                              ],
                            ),

                            sizedboxCustom(5),

                            //Rating
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: orangeColor,
                                ),
                                paragraphCommon('(29)')
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
                                child: paragraphCommon('In stock',
                                    fontsize: 11,
                                    lineHeight: 1.1,
                                    fontweight: FontWeight.w600,
                                    color: successColor)),
                          ],
                        ),

                        //=========>
                        const ColorAndSize(),

                        //increase decrease button
                        sizedboxCustom(17),
                        paragraphCommon('Quantity:'),
                        sizedboxCustom(10),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              height: 46,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: borderColor, width: 1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //decrease quanity
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 38,
                                      width: 38,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.withOpacity(.2),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.black.withOpacity(.5),
                                        size: 19,
                                      ),
                                    ),
                                  ),

                                  //Quantity text
                                  Container(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '2',
                                        style: TextStyle(
                                            color: greyPrimary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )),

                                  //increase quantity
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 38,
                                      width: 38,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.withOpacity(.2),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black.withOpacity(.5),
                                        size: 19,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        sizedboxCustom(25),

                        const CampaignTimer(),

                        //========>
                        // tab
                        sizedboxCustom(15),

                        TabBar(
                          onTap: (value) {
                            setState(() {
                              currentTab = value;
                            });
                          },
                          labelColor: primaryColor,
                          unselectedLabelColor: greyFour,
                          indicatorColor: primaryColor,
                          unselectedLabelStyle: const TextStyle(
                              color: greyParagraph,
                              fontWeight: FontWeight.normal),
                          controller: _tabController,
                          tabs: const [
                            Tab(text: 'Description'),
                            Tab(text: 'Review'),
                            Tab(text: 'Ship & return'),
                          ],
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 30),
                          child: [
                            const DescriptionTab(),
                            const ReviewTab(),
                            const ShipReturnTab(),
                          ][_tabIndex],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          //=======>
          ProductDetailsBottom(
            tabIndex: currentTab,
          )
        ],
      ),
    );
  }
}
