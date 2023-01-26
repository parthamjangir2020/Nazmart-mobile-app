import 'package:flutter/cupertino.dart';
import 'package:no_name_ecommerce/services/cart_services/product_db_service.dart';

class FavService with ChangeNotifier {
//This class is only responsible for
//favourite product page

  int favProductsLength = 0;

  var favItemList = [];

  fetchFavProducts() async {
    favItemList = await ProductDbService().allfavProducts();
    favProductsLength = favItemList.length;
    notifyListeners();
  }

  remove(productId, title, thumbnail, discountPrice, oldPrice,
      BuildContext context) async {
    await ProductDbService().addOrRemoveFavourite(
        productId, title, thumbnail, discountPrice, oldPrice, context);
    fetchFavProducts();

    // favUnfavFromOtherPage(productId, title, whichProductList[0],
    //     context); // whichProductlist 0 means best sold product
    // favUnfavFromOtherPage(productId, title, whichProductList[1],
    //     context); // whichProductlist 1 means recent product

    //calculate length
    fetchFavProductLength();
  }

  //cart product number
  fetchFavProductLength() async {
    List products = await ProductDbService().allfavProducts();
    favProductsLength = products.length;
    notifyListeners();
  }
}
