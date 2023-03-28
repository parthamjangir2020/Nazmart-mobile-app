// ignore_for_file: unused_import

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/services/cart_services/delivery_address_service.dart';
import 'package:no_name_ecommerce/services/currency_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/view/checkout/components/cart_products.dart';
import 'package:no_name_ecommerce/view/checkout/components/coupon_field.dart';
import 'package:no_name_ecommerce/view/checkout/components/shipping_select.dart';
import 'package:no_name_ecommerce/view/order/payment_choose_page.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
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
    Provider.of<CartService>(context, listen: false).fetchCartProducts(context);
  }

  TextEditingController couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarCommon(ConstString.cart, context, () {
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
            child: Consumer<CartService>(
                builder: (context, cProvider, child) => cProvider
                        .cartItemList.isNotEmpty
                    ? Consumer<DeliveryAddressService>(
                        builder: (context, dProvider, child) =>
                            Consumer<CurrencyService>(
                                builder: (context, cP, child) =>
                                    Consumer<TranslateStringService>(
                                      builder: (context, ln, child) =>
                                          Column(children: [
                                        //Products
                                        //==========>
                                        gapH(13),
                                        const CartProducts(),

                                        // Calculations
                                        // ========>
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 70, bottom: 18),
                                          child: dividerCommon(),
                                        ),
                                        detailsRow(ConstString.subtotal, 0,
                                            cProvider.subTotal.toString()),
                                        gapH(15),
                                        detailsRow(ConstString.discount, 0,
                                            '${cProvider.couponDiscount}'),
                                        gapH(15),
                                        detailsRow(ConstString.vat, 0,
                                            '(+${dProvider.vatPercentage}%) ${dProvider.vatAmount}'),
                                        gapH(15),
                                        detailsRow(ConstString.shipping, 0,
                                            '${dProvider.selectedShipCost}'),

                                        gapH(15),

                                        //shipping select
                                        const ShippingSelect(),

                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: dividerCommon(),
                                        ),

                                        //Total price
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            titleCommon(
                                                ln.getString(ConstString.total),
                                                fontsize: 14),
                                            titleCommon(
                                                '\$${cProvider.totalPrice.toStringAsFixed(2)}',
                                                fontsize: 18)
                                          ],
                                        ),

                                        //Apply promo ===========>
                                        CouponField(
                                          cartItemList: cProvider.cartItemList,
                                          couponController: couponController,
                                        ),

                                        gapH(25),
                                        buttonPrimary(ConstString.checkout, () {
                                          if (dProvider
                                              .enteredDeliveryAddress.isEmpty) {
                                            showToast(
                                                'Please enter the delivery address and save it',
                                                Colors.black);
                                            return;
                                          }
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  const PaymentChoosePage(),
                                            ),
                                          );
                                        }, borderRadius: 100),

                                        gapH(30)
                                      ]),
                                    )),
                      )
                    : nothingfound(context, ConstString.noProdAddedToCart)),
          )),
        ),
      ),
    );
  }
}
