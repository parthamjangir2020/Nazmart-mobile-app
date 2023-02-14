class AddtocartModel {
  late String productId;
  late String title;
  late String thumbnail;
  late String color;
  late String size;
  late var discountPrice;
  late var oldPrice;
  late var totalWithQty;
  late int qty;

  cartMap() {
    // ignore: unused_local_variable, prefer_collection_literals
    var mapping = Map<String, dynamic>();
    mapping['productId'] = productId;
    mapping['title'] = title;
    mapping['thumbnail'] = thumbnail;
    mapping['discountPrice'] = discountPrice;
    mapping['oldPrice'] = oldPrice;
    mapping['totalWithQty'] = totalWithQty;
    mapping['qty'] = qty;
    mapping['color'] = color;
    mapping['size'] = size;
    return mapping;
  }
}
