// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/model/add_to_cart_model.dart';
import 'package:no_name_ecommerce/model/favourite_product_model.dart';
import 'package:no_name_ecommerce/services/cart_service.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class ProductDbService {
  static Database? _database;

  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'product_db');
    var database = await openDatabase(path, version: 1, onCreate: _dbOnCreate);
    return database;
  }

  _dbOnCreate(Database database, int version) async {
    await database.execute(
        "CREATE TABLE cart_table(id INTEGER PRIMARY KEY AUTOINCREMENT, productId INTEGER, title TEXT, thumbnail TEXT, discountPrice REAL,oldPrice REAL,totalWithQty REAL, qty INTEGER, color TEXT,size TEXT,colorPrice REAL,sizePrice REAL)");

    await database.execute(
        "CREATE TABLE fav_table(id INTEGER PRIMARY KEY AUTOINCREMENT, productId INTEGER, title TEXT, thumbnail TEXT, discountPrice REAL,oldPrice REAL)");
  }

  Future<Database> get getdatabase async {
    if (_database != null) {
      //if the database already exists
      return _database!;
    } else {
      //else create the database and return it
      _database = await setDatabase();
      return _database!;
    }
  }

  checkIfAddedtoCart(String title, int productId) async {
    var connection = await getdatabase;
    var data = await connection.rawQuery(
        "SELECT * FROM cart_table WHERE title=? and productId=?",
        [title, productId]);
    if (data.isNotEmpty) {
      //if not empty then it is added to cart
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addorRemoveFromCart(
      int productId,
      String title,
      String thumbnail,
      double discountPrice,
      double oldPrice,
      int qty,
      String color,
      double colorPrice,
      String size,
      double sizePrice,
      BuildContext context) async {
    var connection = await getdatabase;
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

      //product already added to cart so remove from cart

      // await connection.rawDelete(
      //     "DELETE FROM cart_table WHERE productId=? and title=?",
      //     [productId, title]);

      // print('removed from cart');

      // showSnackBar(context, 'Removed from cart', primaryColor);

      return false;
    }
  }

  removeFromCart(productId, title, BuildContext context) async {
    var connection = await getdatabase;

    await connection.rawDelete(
        "DELETE FROM cart_table WHERE productId=? and title=?",
        [productId, title]);

    print('removed from cart');

    showSnackBar(context, 'Removed from cart', primaryColor);
  }

  allCartProducts() async {
    var connection = await getdatabase;
    return await connection.query('cart_table');
  }

  //single product
  getSingleProduct(int productId, String title) async {
    var connection = await getdatabase;
    var prod = connection.rawQuery(
        "SELECT * FROM cart_table WHERE productId=? and title =?",
        [productId, title]);
    return prod;
  }

  Future<bool> updateQtandPrice(int productId, String title, int qty,
      double totalWithQty, BuildContext context) async {
    var connection = await getdatabase;
    connection.rawUpdate(
        "UPDATE cart_table SET qty=?, totalWithQty=? WHERE productId=? and title =?",
        [qty, totalWithQty, productId, title]);
    return true;
  }

  emptyCartTable() async {
    var connection = await getdatabase;
    connection.rawQuery("DELETE FROM cart_table");
    return true;
  }

  //Single product cart functions =============>

  // addSingleProductTocart() {}

  // increaseSingleProductQty() {}

  // decreaseSingleProductQty() {}

  //End of Single product cart functions =============>

//Favourite table functionalities ======================>

  //check if added to favourite then change fav button color accordingly
  checkFavourite(String title, int id) async {
    var connection = await getdatabase;
    var favaudio = await connection.rawQuery(
        "SELECT * FROM fav_table WHERE title=? and productId=?", [title, id]);
    if (favaudio.isNotEmpty) {
      //if not empty then it is added to favourite
      return true;
    } else {
      return false;
    }
  }

  // ===========================>

  Future<bool> addOrRemoveFavourite(
      int productId,
      String title,
      String thumbnail,
      double discountPrice,
      double oldPrice,
      BuildContext context) async {
    var connection = await getdatabase;
    var favaudio = await connection.rawQuery(
        "SELECT * FROM fav_table WHERE title=? and productId=?",
        [title, productId]);
    if (favaudio.isEmpty) {
      //if already not added to favourite

      var favObj = FavouriteProductModel();
      favObj.productId = productId;
      favObj.title = title;
      favObj.thumbnail = thumbnail;
      favObj.discountPrice = discountPrice;
      favObj.oldPrice = oldPrice;

      await connection.insert('fav_table', favObj.favouriteMap());
      print('added to favourite');

      showSnackBar(context, 'Added to favourite', successColor);

      return true;
    } else {
      // else already added to favourite. so remove it

      await connection.rawDelete(
          "DELETE FROM fav_table WHERE productId=? and title=?",
          [productId, title]);

      print('removed from favourite');

      showSnackBar(context, 'Removed from favourite', primaryColor);

      return false;
    }
  }

  //=================>

  allfavProducts() async {
    var connection = await getdatabase;
    return await connection.query('fav_table');
  }

  //==================>

  // deleteDatafromFav(int productId, String title, BuildContext context) async {
  //   var connection = await getdatabase;
  //   await connection.rawDelete(
  //       "DELETE FROM fav_table WHERE productId=? and title =?",
  //       [productId, title]);
  // }

//====================>

  // addFavProductToCart(int productId, String title, context) async {
  //   var connection = await getdatabase;
  //   //make added to cart true
  //   await connection.rawUpdate(
  //       "UPDATE fav_table SET addedToCart=? WHERE productId=? and title =?",
  //       [1, productId, title]);
  //   //then refresh the product in wishlist page
  //   // Provider.of<FavouritePageService>(context, listen: false).getProducts();
  // }
}
