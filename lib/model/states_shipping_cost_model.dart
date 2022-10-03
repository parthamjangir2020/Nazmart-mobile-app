// To parse this JSON data, do
//
//     final statesShippingCostModel = statesShippingCostModelFromJson(jsonString);

import 'dart:convert';

StatesShippingCostModel statesShippingCostModelFromJson(String str) =>
    StatesShippingCostModel.fromJson(json.decode(str));

String statesShippingCostModelToJson(StatesShippingCostModel data) =>
    json.encode(data.toJson());

class StatesShippingCostModel {
  StatesShippingCostModel({
    this.tax,
    this.taxPercentage,
    required this.shippingOptions,
    required this.defaultShipping,
    this.defaultShippingCost,
  });

  int? tax;
  double? taxPercentage;
  List<DefaultShipping> shippingOptions;
  DefaultShipping defaultShipping;
  int? defaultShippingCost;

  factory StatesShippingCostModel.fromJson(Map<String, dynamic> json) =>
      StatesShippingCostModel(
        tax: json["tax"],
        taxPercentage: json["tax_percentage"]?.toDouble(),
        shippingOptions: List<DefaultShipping>.from(
            json["shipping_options"].map((x) => DefaultShipping.fromJson(x))),
        defaultShipping: DefaultShipping.fromJson(json["default_shipping"]),
        defaultShippingCost: json["default_shipping_cost"],
      );

  Map<String, dynamic> toJson() => {
        "tax": tax,
        "tax_percentage": taxPercentage,
        "shipping_options":
            List<dynamic>.from(shippingOptions.map((x) => x.toJson())),
        "default_shipping": defaultShipping.toJson(),
        "default_shipping_cost": defaultShippingCost,
      };
}

class DefaultShipping {
  DefaultShipping({
    this.id,
    this.name,
    this.zoneId,
    this.isDefault,
    required this.options,
    required this.availableOptions,
  });

  int? id;
  String? name;
  int? zoneId;
  int? isDefault;
  Options options;
  Options availableOptions;

  factory DefaultShipping.fromJson(Map<String, dynamic> json) =>
      DefaultShipping(
        id: json["id"],
        name: json["name"],
        zoneId: json["zone_id"],
        isDefault: json["is_default"],
        options: Options.fromJson(json["options"]),
        availableOptions: Options.fromJson(json["available_options"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "zone_id": zoneId,
        "is_default": isDefault,
        "options": options.toJson(),
        "available_options": availableOptions.toJson(),
      };
}

class Options {
  Options({
    this.id,
    this.title,
    this.shippingMethodId,
    this.status,
    this.taxStatus,
    this.settingPreset,
    this.cost,
    this.minimumOrderAmount,
    this.coupon,
  });

  int? id;
  String? title;
  int? shippingMethodId;
  int? status;
  int? taxStatus;
  String? settingPreset;
  int? cost;
  int? minimumOrderAmount;
  dynamic coupon;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        id: json["id"],
        title: json["title"],
        shippingMethodId: json["shipping_method_id"],
        status: json["status"],
        taxStatus: json["tax_status"],
        settingPreset: json["setting_preset"],
        cost: json["cost"],
        minimumOrderAmount: json["minimum_order_amount"],
        coupon: json["coupon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "shipping_method_id": shippingMethodId,
        "status": status,
        "tax_status": taxStatus,
        "setting_preset": settingPreset,
        "cost": cost,
        "minimum_order_amount": minimumOrderAmount,
        "coupon": coupon,
      };
}
