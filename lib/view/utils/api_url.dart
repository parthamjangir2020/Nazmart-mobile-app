class ApiUrl {
  static const String baseUri = 'https://hexfashion.xyz/api/tenant/v1';
  static const String refundProductsListUri = '$baseUri/user/refund';
  static const String loginUri = '$baseUri/login';
  static const String registerUri = '$baseUri/register';
  static const String logoutUri = '$baseUri/user/logout';
  static const String changePassUri = '';
  static const String sendOtpUri = '$baseUri/send-otp-in-mail';
  static const String otpSuccessUri = '$baseUri/otp-success';
  static const String socialLoginUri = '$baseUri/social-login';
  static const String resetPassUri = '$baseUri/reset-password';
  static const String couponUri = '$baseUri/coupon';
  static const String shippingCostUri = '$baseUri/shipping-charge';
  static const String vatAndShipCostUri = '$baseUri/checkout-calculate?country';
  static const String departmentUri = '$baseUri/user/get-department';
  static const String gatewayListUri = '$baseUri/user/payment-gateway-list';
  static const String addShippingUri = '$baseUri/user/add-shipping-address';
  static const String removeShippingUri =
      '$baseUri/user/shipping-address/delete';
  static const String shipAddressListUri = "$baseUri/user/all-shipping-address";
  static const String ticketPriorityChangeUri =
      '$baseUri/user/ticket/priority-change';
  static const String ticketStatusChangeUri =
      '$baseUri/user/ticket/status-change';
  static const String createTicketUri = '$baseUri/user/ticket/create';
  static const String ticketMessageUri = '$baseUri/user/ticket';
  static const String ticketMessageSendUri = '$baseUri/user/ticket/chat/send';
  static const String ticketListUri = '$baseUri/user/ticket?page';
  static const String campaignProductsUri = '$baseUri/campaign/product';
  static const String campaignListUri = '$baseUri/campaign';
  static const String categoryUri = '$baseUri/category';
  static const String childCategoryUri = '$baseUri/child-category';
  static const String stateListUri = '$baseUri/country/service-city';
  static const String countryListUri = '$baseUri/country';
  static const String currencyUri = '$baseUri/get-currency-symbol';
  static const String discoverProductsUri = '$baseUri/product?name=&page';
  static const String introUri = '$baseUri/mobile-intro';
  static const String privacyPolicyUri = '$baseUri/privacy-policy-page';
  static const String termsUri = '$baseUri/terms-and-condition-page';
  static const String productDetailsUri = '$baseUri/product';
  static const String updateProfileUri = '$baseUri/user/update-profile';
  static const String profileDataUri = '$baseUri/user/profile';
  static const String rtlUri = '$baseUri/currency';
  static const String languageUri = '$baseUri/language';
  static const String searchUri = '$baseUri/product?name';
  static const String sliderUri = '$baseUri/mobile-slider';
  static const String subcategoryUri = '$baseUri/subcategory';
  static const String translateUri = '$baseUri/translate-string';
  static const String orderListUri = '$baseUri/user/order';
  static const String refundProductUri = '$baseUri/user/order/refund';
}
