// To parse this JSON data, do
//
//     final countryShippingCostModel = countryShippingCostModelFromJson(jsonString);

// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

CountryShippingCostModel countryShippingCostModelFromJson(String str) =>
    CountryShippingCostModel.fromJson(json.decode(str));

String countryShippingCostModelToJson(CountryShippingCostModel data) =>
    json.encode(data.toJson());

class CountryShippingCostModel {
  CountryShippingCostModel({
    this.tax,
    this.taxPercentage,
    required this.states,
    required this.shippingOptions,
    required this.defaultShipping,
    this.defaultShippingCost,
  });

  var tax;
  var taxPercentage;
  List<State> states;
  List<DefaultShipping> shippingOptions;
  DefaultShipping defaultShipping;
  int? defaultShippingCost;

  factory CountryShippingCostModel.fromJson(Map<String, dynamic> json) =>
      CountryShippingCostModel(
        tax: json["tax"],
        taxPercentage: json["tax_percentage"],
        states: List<State>.from(json["states"].map((x) => State.fromJson(x))),
        shippingOptions: List<DefaultShipping>.from(
            json["shipping_options"].map((x) => DefaultShipping.fromJson(x))),
        defaultShipping: DefaultShipping.fromJson(json["default_shipping"]),
        defaultShippingCost: json["default_shipping_cost"],
      );

  Map<String, dynamic> toJson() => {
        "tax": tax,
        "tax_percentage": taxPercentage,
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
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
  String? coupon;

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

class State {
  State({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory State.fromJson(Map<String, dynamic> json) => State(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
