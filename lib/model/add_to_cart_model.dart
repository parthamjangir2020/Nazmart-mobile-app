// ignore_for_file: prefer_typing_uninitialized_variables

class AddtocartModel {
  late String productId;
  late String title;
  late String thumbnail;
  late String? color;
  late String? size;
  var discountPrice;
  var oldPrice;
  var priceWithAttr;
  late int qty;

  cartMap() {
    // ignore: unused_local_variable, prefer_collection_literals
    var mapping = Map<String, dynamic>();
    mapping['productId'] = productId;
    mapping['title'] = title;
    mapping['thumbnail'] = thumbnail;
    mapping['discountPrice'] = discountPrice;
    mapping['oldPrice'] = oldPrice;
    mapping['priceWithAttr'] = priceWithAttr;
    mapping['qty'] = qty;
    mapping['color'] = color;
    mapping['size'] = size;
    return mapping;
  }
}
