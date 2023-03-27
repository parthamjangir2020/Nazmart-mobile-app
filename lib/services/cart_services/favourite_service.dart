// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/model/favourite_product_model.dart';
import 'package:no_name_ecommerce/services/product_db_service.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';

class FavouriteService with ChangeNotifier {
  int favProductsLength = 0;

  var favItemList = [];

  fetchFavProducts() async {
    favItemList = await ProductDbService().allfavProducts();
    favProductsLength = favItemList.length;
    notifyListeners();
  }

  Future<bool> addOrRemoveFavourite(
    BuildContext context, {
    required productId,
    required String title,
    required String thumbnail,
    required discountPrice,
    required oldPrice,
  }) async {
    var connection = await ProductDbService().getdatabase;
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

      showToast('Added to favourite', Colors.black);

      return true;
    } else {
      // else already added to favourite. so remove it

      removeFromFavourite(productId, title, context);

      return false;
    }
  }

  // ======>
  // remove from favourite
  removeFromFavourite(productId, title, BuildContext context) async {
    var connection = await ProductDbService().getdatabase;
    await connection.rawDelete(
        "DELETE FROM fav_table WHERE productId=? and title=?",
        [productId, title]);
    fetchFavProducts();
    print('removed from favourite');

    showToast('Removed to favourite', Colors.black);
  }

  //check if added to favourite then change fav button color accordingly
  Future<bool> checkFavourite(String title, int id) async {
    var connection = await ProductDbService().getdatabase;
    var favaudio = await connection.rawQuery(
        "SELECT * FROM fav_table WHERE title=? and productId=?", [title, id]);
    if (favaudio.isNotEmpty) {
      //if not empty then it is added to favourite
      return true;
    } else {
      return false;
    }
  }

  //product number
  fetchFavProductLength() async {
    List products = await ProductDbService().allfavProducts();
    favProductsLength = products.length;
    notifyListeners();
  }
}
