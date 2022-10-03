import 'package:flutter/cupertino.dart';
import 'package:no_name_ecommerce/services/coupon_service.dart';
import 'package:no_name_ecommerce/services/delivery_address_service.dart';
import 'package:no_name_ecommerce/services/product_db_service.dart';
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
    // await ProductDbService().addorRemoveFromCart(
    //     productId,
    //     title,
    //     thumbnail,
    //     discountPrice,
    //     oldPrice,
    //     quantity,
    //     color,
    //     colorPrice,
    //     size,
    //     sizePrice,
    //     context);

    await ProductDbService().removeFromCart(productId, title, context);

    //==============>
    fetchCartProducts();
    calculateSubtotal();

//This class is only responsible for
//favourite product page
    // cartRemoveCartFromOtherPage(productId, title, whichProductList[0],
    //     context); // whichProductlist 0 means best sold product
    // cartRemoveCartFromOtherPage(productId, title, whichProductList[1],
    //     context); // whichProductlist 1 means recent product

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
}
