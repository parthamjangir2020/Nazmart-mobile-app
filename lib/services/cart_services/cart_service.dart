// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:no_name_ecommerce/model/add_to_cart_model.dart';
import 'package:no_name_ecommerce/services/cart_services/coupon_service.dart';
import 'package:no_name_ecommerce/services/cart_services/delivery_address_service.dart';
import 'package:no_name_ecommerce/services/product_db_service.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

class CartService with ChangeNotifier {
  //
  var cartItemList = [];

  double subTotal = 0;
  int cartProductsNumber = 0;
  var totalPrice = 0.0;
  double couponDiscount = 0.0;

  var selectedColor;
  var selectedSize;

  setSelectedColor(v) {
    selectedColor = v;
    notifyListeners();
  }

  setSelectedSize(v) {
    selectedSize = v;
    notifyListeners();
  }

  resetCoupon(BuildContext context) {
    couponDiscount = 0.0;

    Provider.of<CouponService>(context, listen: false).setCouponDefault();
  }

  fetchCartProducts(BuildContext context) async {
    cartItemList = await ProductDbService().allCartProducts();
    calculateSubtotal(context);
    notifyListeners();
  }

  remove(productId, String title, BuildContext context) async {
    await ProductDbService().removeFromCart(productId, title, context);

    //==============>
    fetchCartProducts(context);
    calculateSubtotal(context);
  }

  //increase quantity and price
  increaseQtandPrice(productId, title, attributes, BuildContext context,
      {bool ignoreAttribute = false}) async {
    var data = await ProductDbService().getSingleProduct(
        productId, title, attributes,
        ignoreAttribute: ignoreAttribute);

    var newQty = data[0]['qty'] + 1;
    print('daaaa $data');

    await ProductDbService().updateQtandPrice(
        productId, title, newQty, attributes, context,
        ignoreAttribute: ignoreAttribute);

    fetchCartProducts(context);
    await calculateSubtotal(context);
    Provider.of<DeliveryAddressService>(context, listen: false)
        .calculateVatAmountOnly(context);
    await calculateSubtotal(context);
  }

  //decrease quantity and price
  decreaseQtyAndPrice(
      productId, title, attributes, BuildContext context) async {
    var data =
        await ProductDbService().getSingleProduct(productId, title, attributes);
    if (data[0]['qty'] > 1) {
      var newQty = data[0]['qty'] - 1;

      await ProductDbService()
          .updateQtandPrice(productId, title, newQty, attributes, context);

      fetchCartProducts(context);
      await calculateSubtotal(context);

      Provider.of<DeliveryAddressService>(context, listen: false)
          .calculateVatAmountOnly(context);

      await calculateSubtotal(context);
    }
  }

// subtotal ====================>
  Future<bool> calculateSubtotal(BuildContext context) async {
    List products = await ProductDbService().allCartProducts();
    subTotal = 0;

    var vatAmount =
        Provider.of<DeliveryAddressService>(context, listen: false).vatAmount;
    var shipCost = Provider.of<DeliveryAddressService>(context, listen: false)
        .selectedShipCost;

    if (products.isNotEmpty) {
      for (int i = 0; i < products.length; i++) {
        subTotal =
            subTotal + (products[i]["priceWithAttr"] * products[i]["qty"]);
      }
      cartProductsNumber = products.length;
    } else {
      subTotal = 0;
      cartProductsNumber = 0;
    }

    totalPrice = (subTotal + vatAmount + shipCost) - couponDiscount;
    notifyListeners();

    return true;
  }

// total after coupon applied ======================>
  calculateTotalAfterCouponApplied(
      {required oldDiscount, required newDiscount}) {
    if (oldDiscount != null) {
      subTotal = subTotal + double.parse(oldDiscount.toString());
    }
    couponDiscount = double.parse(newDiscount.toString());
    totalPrice = subTotal - couponDiscount;

    notifyListeners();
  }

//increase total amount (ex: vat, shipping)
  increaseTotal(oldValueToSubtract, newValueToAdd) {
    print('increase total price fun ran');
    totalPrice = (totalPrice - oldValueToSubtract) + newValueToAdd;
    notifyListeners();

    print('total price is $totalPrice');
  }

  //cart product number
  fetchCartProductNumber() async {
    List products = await ProductDbService().allCartProducts();
    cartProductsNumber = products.length;
    notifyListeners();
  }

//Add to cart or update qty
// =================>

  Future<bool> addToCartOrUpdateQty(BuildContext context,
      {required String productId,
      required String title,
      required String thumbnail,
      required String discountPrice,
      required String oldPrice,
      required int qty,
      required String? color,
      required String? size,
      required priceWithAttr,
      required category,
      required subcategory,
      required childCategory,
      required attributes,
      required variantId,
      bool ignoreAttribute = false}) async {
    var connection = await ProductDbService().getdatabase;
    var prod = await connection.rawQuery(
        "SELECT * FROM cart_table WHERE productId=? and title =?",
        [productId, title]);

    if (prod.isEmpty) {
      //if product is not already added to cart
      addToCart(
          context: context,
          productId: productId,
          title: title,
          thumbnail: thumbnail,
          discountPrice: discountPrice,
          oldPrice: oldPrice,
          qty: qty,
          priceWithAttr: priceWithAttr,
          color: color,
          size: size,
          category: category,
          subcategory: subcategory,
          childCategory: childCategory,
          attributes: attributes,
          variantId: variantId);
      return true;
    } else {
      //product already added to cart,
      //but check if the already added product has same
      //attributes than the new one, if so, then increase quantity
      //else add to cart as new product

      if (prod[0]['attributes'] == jsonEncode(attributes) &&
          prod[0]['productId'] == productId) {
        //then, increase quantity
        print('same product and same attributes');

        Provider.of<CartService>(context, listen: false).increaseQtandPrice(
            productId, title, attributes, context,
            ignoreAttribute: ignoreAttribute);

        showSnackBar(context, ConstString.qtyIncreased, successColor);

        return false;
      } else {
        print('different attributes');
        //so, add to cart as new product

        addToCart(
            context: context,
            productId: productId,
            title: title,
            thumbnail: thumbnail,
            discountPrice: discountPrice,
            oldPrice: oldPrice,
            qty: qty,
            priceWithAttr: priceWithAttr,
            color: color,
            size: size,
            category: category,
            subcategory: subcategory,
            childCategory: childCategory,
            attributes: attributes,
            variantId: variantId);

        return false;
      }
    }
  }

  addToCart(
      {required BuildContext context,
      required productId,
      required title,
      required thumbnail,
      required discountPrice,
      required oldPrice,
      required qty,
      required priceWithAttr,
      required color,
      required size,
      required category,
      required subcategory,
      required childCategory,
      required attributes,
      required variantId}) async {
    var cartObj = AddtocartModel();
    cartObj.productId = productId;
    cartObj.title = title;
    cartObj.thumbnail = thumbnail;
    cartObj.discountPrice = discountPrice;
    cartObj.oldPrice = oldPrice;
    cartObj.qty = qty;
    cartObj.priceWithAttr = priceWithAttr;
    cartObj.color = color;
    cartObj.size = size;
    cartObj.category = category;
    cartObj.subcategory = subcategory;
    cartObj.childCategory = childCategory;
    cartObj.attributes = attributes;
    cartObj.variantId = variantId;

    var connection = await ProductDbService().getdatabase;

    await connection.insert('cart_table', cartObj.cartMap());

    print('Added to cart');

    showSnackBar(context, ConstString.addedToCart, successColor);
    fetchCartProductNumber();
  }
}
