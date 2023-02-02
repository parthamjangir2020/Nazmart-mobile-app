// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
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
        "CREATE TABLE cart_table(id INTEGER PRIMARY KEY AUTOINCREMENT, productId TEXT, title TEXT, thumbnail TEXT, discountPrice REAL,oldPrice REAL,totalWithQty REAL, qty INTEGER, color TEXT,size TEXT,colorPrice REAL,sizePrice REAL)");

    await database.execute(
        "CREATE TABLE fav_table(id INTEGER PRIMARY KEY AUTOINCREMENT, productId TEXT, title TEXT, thumbnail TEXT, discountPrice REAL,oldPrice REAL)");
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
  getSingleProduct(String productId, String title) async {
    var connection = await getdatabase;
    var prod = connection.rawQuery(
        "SELECT * FROM cart_table WHERE productId=? and title =?",
        [productId, title]);
    return prod;
  }

  Future<bool> updateQtandPrice(String productId, String title, int qty,
      totalWithQty, BuildContext context) async {
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

//Favourite table functionalities ======================>

  // ===========================>

  //=================>

  allfavProducts() async {
    var connection = await getdatabase;
    return await connection.query('fav_table');
  }
}
