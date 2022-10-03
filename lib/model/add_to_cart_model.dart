class AddtocartModel {
  late int productId;
  late String title;
  late String thumbnail;
  late String color;
  late String size;
  late double colorPrice;
  late double sizePrice;
  late double discountPrice;
  late double oldPrice;
  late double totalWithQty;
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
    mapping['colorPrice'] = colorPrice;
    mapping['sizePrice'] = sizePrice;
    mapping['size'] = size;
    return mapping;
  }
}
