class FavouriteProductModel {
  late int productId;
  late String title;
  late String thumbnail;
  late double discountPrice;
  late double oldPrice;

  favouriteMap() {
    var mapping = <String, dynamic>{};
    mapping['productId'] = productId;
    mapping['title'] = title;
    mapping['thumbnail'] = thumbnail;
    mapping['discountPrice'] = discountPrice;
    mapping['oldPrice'] = oldPrice;
    return mapping;
  }
}
