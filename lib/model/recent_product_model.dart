// To parse this JSON data, do
//
//     final recentProductModel = recentProductModelFromJson(jsondynamic);

import 'dart:convert';

RecentProductModel recentProductModelFromJson(dynamic str) =>
    RecentProductModel.fromJson(json.decode(str));

dynamic recentProductModelToJson(RecentProductModel data) =>
    json.encode(data.toJson());

class RecentProductModel {
  RecentProductModel({
    required this.recentProducts,
  });

  RecentProductsDatas recentProducts;

  factory RecentProductModel.fromJson(Map<dynamic, dynamic> json) =>
      RecentProductModel(
        recentProducts: RecentProductsDatas.fromJson(json["recentProducts"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "recentProducts": recentProducts.toJson(),
      };
}

class RecentProductsDatas {
  RecentProductsDatas({
    this.currentPage,
    required this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  dynamic currentPage;
  List<RecentProductsList> data;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  factory RecentProductsDatas.fromJson(Map<dynamic, dynamic> json) =>
      RecentProductsDatas(
        currentPage: json["current_page"],
        data: List<RecentProductsList>.from(
            json["data"].map((x) => RecentProductsList.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<dynamic, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class RecentProductsList {
  RecentProductsList({
    this.id,
    this.name,
    this.slug,
    this.summary,
    this.description,
    this.imageId,
    this.price,
    this.salePrice,
    this.cost,
    this.badgeId,
    this.brandId,
    this.statusId,
    this.productType,
    this.soldCount,
    this.minPurchase,
    this.maxPurchase,
    this.isRefundable,
    this.isInHouse,
    this.isInventoryWarnAble,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.inventoryDetailCount,
    this.image,
    required this.category,
    required this.inventoryDetail,
  });

  dynamic id;
  dynamic name;
  dynamic slug;
  dynamic summary;
  dynamic description;
  dynamic imageId;
  dynamic price;
  dynamic salePrice;
  dynamic cost;
  dynamic badgeId;
  dynamic brandId;
  dynamic statusId;
  dynamic productType;
  dynamic soldCount;
  dynamic minPurchase;
  dynamic maxPurchase;
  dynamic isRefundable;
  dynamic isInHouse;
  dynamic isInventoryWarnAble;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic inventoryDetailCount;
  dynamic image;
  Category category;
  List<InventoryDetail> inventoryDetail;

  factory RecentProductsList.fromJson(Map<dynamic, dynamic> json) =>
      RecentProductsList(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        summary: json["summary"],
        description: json["description"],
        imageId: json["image_id"],
        price: json["price"],
        salePrice: json["sale_price"],
        cost: json["cost"],
        badgeId: json["badge_id"],
        brandId: json["brand_id"],
        statusId: json["status_id"],
        productType: json["product_type"],
        soldCount: json["sold_count"],
        minPurchase: json["min_purchase"],
        maxPurchase: json["max_purchase"],
        isRefundable: json["is_refundable"],
        isInHouse: json["is_in_house"],
        isInventoryWarnAble: json["is_inventory_warn_able"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        inventoryDetailCount: json["inventory_detail_count"],
        image: json["image"],
        category: Category.fromJson(json["category"]),
        inventoryDetail: List<InventoryDetail>.from(
            json["inventory_detail"].map((x) => InventoryDetail.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "summary": summary,
        "description": description,
        "image_id": imageId,
        "price": price,
        "sale_price": salePrice,
        "cost": cost,
        "badge_id": badgeId,
        "brand_id": brandId,
        "status_id": statusId,
        "product_type": productType,
        "sold_count": soldCount,
        "min_purchase": minPurchase,
        "max_purchase": maxPurchase,
        "is_refundable": isRefundable,
        "is_in_house": isInHouse,
        "is_inventory_warn_able": isInventoryWarnAble,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "inventory_detail_count": inventoryDetailCount,
        "image": image,
        "category": category.toJson(),
        "inventory_detail":
            List<dynamic>.from(inventoryDetail.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.imageId,
    this.statusId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.laravelThroughKey,
  });

  dynamic id;
  dynamic name;
  dynamic slug;
  dynamic description;
  dynamic imageId;
  dynamic statusId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic laravelThroughKey;

  factory Category.fromJson(Map<dynamic, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        imageId: json["image_id"],
        statusId: json["status_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        laravelThroughKey: json["laravel_through_key"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "image_id": imageId,
        "status_id": statusId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "laravel_through_key": laravelThroughKey,
      };
}

class InventoryDetail {
  InventoryDetail({
    this.id,
    this.productInventoryId,
    this.productId,
    this.color,
    this.size,
    this.hash,
    this.additionalPrice,
    this.addCost,
    this.image,
    this.stockCount,
    this.soldCount,
    this.attribute,
    this.attrImage,
  });

  dynamic id;
  dynamic productInventoryId;
  dynamic productId;
  dynamic color;
  dynamic size;
  dynamic hash;
  dynamic additionalPrice;
  dynamic addCost;
  dynamic image;
  dynamic stockCount;
  dynamic soldCount;
  List<Attribute>? attribute;
  AttrImage? attrImage;

  factory InventoryDetail.fromJson(Map<dynamic, dynamic> json) =>
      InventoryDetail(
        id: json["id"],
        productInventoryId: json["product_inventory_id"],
        productId: json["product_id"],
        color: json["color"],
        size: json["size"],
        hash: json["hash"],
        additionalPrice: json["additional_price"],
        addCost: json["add_cost"],
        image: json["image"],
        stockCount: json["stock_count"],
        soldCount: json["sold_count"],
        attribute: json["attribute"] != null
            ? List<Attribute>.from(
                json["attribute"].map((x) => Attribute.fromJson(x)))
            : null,
        attrImage: json["attr_image"] != null
            ? AttrImage.fromJson(json["attr_image"])
            : null,
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "product_inventory_id": productInventoryId,
        "product_id": productId,
        "color": color,
        "size": size,
        "hash": hash,
        "additional_price": additionalPrice,
        "add_cost": addCost,
        "image": image,
        "stock_count": stockCount,
        "sold_count": soldCount,
        "attribute": attribute != null
            ? List<dynamic>.from(attribute!.map((x) => x.toJson()))
            : null,
        "attr_image": attrImage?.toJson(),
      };
}

class AttrImage {
  AttrImage({
    this.id,
    this.title,
    this.path,
    this.alt,
    this.size,
    this.userType,
    this.userId,
    this.dimensions,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic title;
  dynamic path;
  dynamic alt;
  dynamic size;
  dynamic userType;
  dynamic userId;
  dynamic dimensions;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AttrImage.fromJson(Map<dynamic, dynamic> json) => AttrImage(
        id: json["id"],
        title: json["title"],
        path: json["path"],
        alt: json["alt"],
        size: json["size"],
        userType: json["user_type"],
        userId: json["user_id"],
        dimensions: json["dimensions"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "title": title,
        "path": path,
        "alt": alt,
        "size": size,
        "user_type": userType,
        "user_id": userId,
        "dimensions": dimensions,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Attribute {
  Attribute({
    this.id,
    this.productId,
    this.inventoryDetailsId,
    this.attributeName,
    this.attributeValue,
  });

  dynamic id;
  dynamic productId;
  dynamic inventoryDetailsId;
  dynamic attributeName;
  dynamic attributeValue;

  factory Attribute.fromJson(Map<dynamic, dynamic> json) => Attribute(
        id: json["id"],
        productId: json["product_id"],
        inventoryDetailsId: json["inventory_details_id"],
        attributeName: json["attribute_name"],
        attributeValue: json["attribute_value"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "inventory_details_id": inventoryDetailsId,
        "attribute_name": attributeName,
        "attribute_value": attributeValue,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  dynamic url;
  dynamic label;
  bool? active;

  factory Link.fromJson(Map<dynamic, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<dynamic, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
