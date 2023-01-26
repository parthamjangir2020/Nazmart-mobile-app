// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:no_name_ecommerce/model/add_to_cart_model.dart';
import 'package:no_name_ecommerce/services/cart_services/coupon_service.dart';
import 'package:no_name_ecommerce/services/cart_services/delivery_address_service.dart';
import 'package:no_name_ecommerce/services/cart_services/product_db_service.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

class CartService with ChangeNotifier {
  //This class is only responsible for
//cart product page
  var cartItemList = [];

  double subTotal = 0;
  int cartProductsNumber = 0;
  double totalPrice = 0;
  double couponDiscount = 0.0;

  resetCoupon(BuildContext context) {
    couponDiscount = 0.0;

    Provider.of<CouponService>(context, listen: false).setCouponDefault();
  }

  fetchCartProducts() async {
    cartItemList = await ProductDbService().allCartProducts();
    notifyListeners();
  }

  remove(
      int productId,
      String title,
      String thumbnail,
      double discountPrice,
      double oldPrice,
      int quantity,
      String color,
      double colorPrice,
      String size,
      double sizePrice,
      BuildContext context) async {
    await ProductDbService().removeFromCart(productId, title, context);

    //==============>
    fetchCartProducts();
    calculateSubtotal();

    //user needs to enter coupon again
    resetCoupon(context);
    //set default delivery options
    Provider.of<DeliveryAddressService>(context, listen: false).setDefault();
  }

  //increase quantity and price
  increaseQtandPrice(productId, title, BuildContext context) async {
    var data = await ProductDbService().getSingleProduct(productId, title);
    var newQty = data[0]['qty'] +
        1; //increase quantity by 1, every time this function is called;
    var totalWithQty = data[0]['discountPrice'] *
        newQty; //will give us total price of this product based on quantity

    await ProductDbService()
        .updateQtandPrice(productId, title, newQty, totalWithQty, context);
    //===========>

    //user needs to enter coupon again
    resetCoupon(context);
    //set default delivery options
    Provider.of<DeliveryAddressService>(context, listen: false).setDefault();

    fetchCartProducts();
    calculateSubtotal();
  }

  //decrease quantity and price
  decreaseQtyAndPrice(productId, title, BuildContext context) async {
    var data = await ProductDbService().getSingleProduct(productId, title);
    if (data[0]['qty'] > 1) {
      var newQty = data[0]['qty'] - 1;

      var newprice = data[0]['totalWithQty'] - data[0]['discountPrice'];

      await ProductDbService()
          .updateQtandPrice(productId, title, newQty, newprice, context);
      //========>

      //user needs to enter coupon again
      resetCoupon(context);
      //set default delivery options
      Provider.of<DeliveryAddressService>(context, listen: false).setDefault();

      fetchCartProducts();
      calculateSubtotal();
    }
  }

// subtotal ====================>
  calculateSubtotal() async {
    List products = await ProductDbService().allCartProducts();
    subTotal = 0;
    if (products.isNotEmpty) {
      for (int i = 0; i < products.length; i++) {
        subTotal = subTotal + products[i]["totalWithQty"];
      }
      cartProductsNumber = products.length;
    } else {
      subTotal = 0;
      cartProductsNumber = 0;
    }
    totalPrice = subTotal - couponDiscount;
    notifyListeners();
  }

// total after coupon applied ======================>
  calculateTotalAfterCouponApplied(discount) {
    totalPrice = subTotal - double.parse(discount.toString());
    couponDiscount = double.parse(discount.toString());
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

  Future<bool> addToCartOrUpdateQty(
    BuildContext context, {
    required String productId,
    required String title,
    required String thumbnail,
    required String discountPrice,
    required String oldPrice,
    required int qty,
    required String color,
    required String colorPrice,
    required String size,
    required String sizePrice,
  }) async {
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
      cartObj.totalWithQty = discountPrice * qty;
      cartObj.color = color;
      cartObj.colorPrice = colorPrice;
      cartObj.size = size;
      cartObj.sizePrice = sizePrice;
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
