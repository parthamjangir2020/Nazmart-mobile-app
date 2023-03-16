// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:no_name_ecommerce/model/add_to_cart_model.dart';
import 'package:no_name_ecommerce/services/cart_services/coupon_service.dart';
import 'package:no_name_ecommerce/services/cart_services/delivery_address_service.dart';
import 'package:no_name_ecommerce/services/product_db_service.dart';
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
  increaseQtandPrice(productId, title, BuildContext context) async {
    var data = await ProductDbService().getSingleProduct(productId, title);
    var newQty = data[0]['qty'] + 1;

    await ProductDbService()
        .updateQtandPrice(productId, title, newQty, context);

    fetchCartProducts(context);
    calculateSubtotal(context);
  }

  //decrease quantity and price
  decreaseQtyAndPrice(productId, title, BuildContext context) async {
    var data = await ProductDbService().getSingleProduct(productId, title);
    if (data[0]['qty'] > 1) {
      var newQty = data[0]['qty'] - 1;

      await ProductDbService()
          .updateQtandPrice(productId, title, newQty, context);

      fetchCartProducts(context);
      calculateSubtotal(context);
    }
  }

// subtotal ====================>
  calculateSubtotal(BuildContext context) async {
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
  }

// total after coupon applied ======================>
  calculateTotalAfterCouponApplied(discount) {
    couponDiscount = double.parse(discount.toString());
    totalPrice = subTotal - couponDiscount;

    notifyListeners();
  }

//increase total amount (ex: vat, shipping)
  increaseTotal(oldValueToSubtract, newValueToAdd) {
    totalPrice = (totalPrice - oldValueToSubtract) + newValueToAdd;
    notifyListeners();
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
      required priceWithAttr}) async {
    var connection = await ProductDbService().getdatabase;
    var prod = await connection.rawQuery(
        "SELECT * FROM cart_table WHERE productId=? and title =?",
        [productId, title]);

    if (prod.isEmpty) {
      //if product is not already added to cart
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
      await connection.insert('cart_table', cartObj.cartMap());

      print('Added to cart');

      showSnackBar(context, 'Added to cart', successColor);
      return true;
    } else {
      //product already added to cart, so increase quantity

      Provider.of<CartService>(context, listen: false)
          .increaseQtandPrice(productId, title, context);

      showSnackBar(context, 'Quantity increased', successColor);

      return false;
    }
  }
}
