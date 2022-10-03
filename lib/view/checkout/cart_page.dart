// ignore_for_file: unused_import

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:no_name_ecommerce/view/checkout/components/coupon_field.dart';
import 'package:no_name_ecommerce/view/order/payment_choose_page.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({Key? key}) : super(key: key);

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('Cart', context, () {
        Navigator.pop(context);
      }, hasBackButton: true),
      body: SafeArea(
        child: Listener(
          onPointerDown: (_) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadHorizontal),
            child:

                //  Consumer<CartService>(
                //     builder: (context, provider, child) => provider
                //             .cartItemList.isNotEmpty
                //         ? Consumer<DeliveryAddressService>(
                //             builder: (context, dProvider, child) =>
                //                 Consumer<CurrencyService>(
                //               builder: (context, cP, child) =>

                Column(children: [
              sizedboxCustom(13),
              for (int i = 0; i < 3; i++)
                Column(
                  children: [
                    Row(
                      children: [
                        //title image price
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonImage(
                                'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                                55,
                                55),

                            const SizedBox(
                              width: 10,
                            ),
                            //title and price
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rice bowl',
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: cc.blackCustomColor,
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
                                        color: cc.primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),

                        //increase decrease button
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 110,
                                height: 39,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: cc.borderColor, width: 1),
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
                                        height: 32,
                                        width: 32,
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
                                        height: 32,
                                        width: 32,
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

                              //Delete button
                              InkWell(
                                onTap: () {},
                                child: Container(
                                    margin: const EdgeInsets.only(left: 7),
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/trash.svg',
                                          height: 33,
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    i != 4
                        ?
                        //don't show border to the last item
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(
                              thickness: 1,
                              height: 2,
                              color: cc.borderColor.withOpacity(.8),
                            ),
                          )
                        : Container()
                  ],
                ),

              // Calculations ========>
              Container(
                margin: const EdgeInsets.only(top: 70, bottom: 18),
                child: dividerCommon(),
              ),
              detailsRow('Subtotal', 0, '100'),
              sizedboxCustom(15),
              detailsRow('Discount', 0, '10'),
              sizedboxCustom(15),
              detailsRow('Vat', 0, '(+${5}%) ${20}'),
              sizedboxCustom(15),
              detailsRow('Shipping', 0, '70'),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: dividerCommon(),
              ),

              //Total price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: cc.greyFour,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '\$${200}',
                    style: TextStyle(
                      color: cc.blackCustomColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              //Apply promo ===========>
              CouponField(
                cartItemList: [],
                couponController: couponController,
              ),

              sizedboxCustom(25),
              CommonHelper().buttonPrimary('Checkout', () {
                // if (dProvider.enteredDeliveryAddress == null) {
                //   OthersHelper().showToast(
                //       'Please enter the delivery address and save it',
                //       Colors.black);
                //   return;
                // }
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const PaymentChoosePage(),
                  ),
                );
              }, borderRadius: 100),

              sizedboxCustom(30)
            ]),
            //     ),
            //   )
            // : CommonHelper()
            //     .nothingfound(context, 'No product added to cart')),
          )),
        ),
      ),
    );
  }
}
