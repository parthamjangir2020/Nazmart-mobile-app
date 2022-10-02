import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name_ecommerce/view/checkout/cart_page.dart';
import 'package:no_name_ecommerce/view/product/components/color_size.dart';
import 'package:no_name_ecommerce/view/product/components/product_details_bottom.dart';
import 'package:no_name_ecommerce/view/product/components/product_details_slider.dart';
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

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: cc.greyFour),
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
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const Cartpage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(left: 30, right: 20),
              child: SvgPicture.asset(
                'assets/svg/cart.svg',
                height: 27,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    //Slider =============>
                    const ProductDetailsSlider(),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedboxCustom(20),
                            //Title
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Red T-Shirt',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: cc.blackCustomColor,
                                        fontSize: 16,
                                        height: 1.3,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),

                                //favourite icon
                                //=======>

                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: cc.borderColor)),
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.only(left: 20),
                                      child: const Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.grey,
                                      )),
                                )
                              ],
                            ),

                            //Price
                            Text(
                              '\$200',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: cc.primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),

                            sizedboxCustom(5),

                            //Rating
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: cc.orangeColor,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '4.5',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: cc.greyParagraph,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '(29)',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: cc.greyParagraph,
                                    fontSize: 14,
                                  ),
                                ),
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
                                    border: Border.all(color: cc.successColor),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'In stock',
                                  style: TextStyle(
                                      color: cc.successColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600),
                                )),
                          ],
                        ),

                        //=========>
                        const ColorAndSize(),

                        //increase decrease button
                        sizedboxCustom(17),
                        paragraphStyleTitle('Quantity:'),
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
                                    Border.all(color: cc.borderColor, width: 1),
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
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                            color: cc.greyPrimary,
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

                        //Description
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          child: dividerCommon(),
                        ),
                        paragraphCommon(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting',
                            TextAlign.left),
                        sizedboxCustom(30)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          //=======>
          ProductDetailsBottom()
        ],
      ),
    );
  }
}
