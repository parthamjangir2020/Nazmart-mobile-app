import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:no_name_ecommerce/services/campaign_service.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/services/featured_product_service.dart';
import 'package:no_name_ecommerce/services/product_details_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/services/slider_service.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/view/product/product_details_page.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

Future<bool> checkConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    showToast("Please turn on your internet connection", Colors.black);
    return false;
  } else {
    return true;
  }
}

removeUnderscore(value) {
  return value.replaceAll(RegExp('_'), ' ');
}

getDateOnly(date) {
  if (date == null) return ' ';
  return DateFormat('dd/MM/yyyy').format(date);
}

hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.focusedChild?.unfocus();
  }
}

runAtHomeScreen(BuildContext context) {
  Provider.of<CartService>(context, listen: false).fetchCartProductNumber();

  Provider.of<SliderService>(context, listen: false).fetchSlider();
  Provider.of<CampaignService>(context, listen: false)
      .fetchCampaignList(context);
  Provider.of<FeaturedProductService>(context, listen: false)
      .fetchFeaturedProducts(context);

  // Provider.of<QuickDonationDropdownService>(context, listen: false)
  //     .fetchCampaign(context);
  // Provider.of<FeaturedCampaignService>(context, listen: false)
  //     .fetchFeaturedCampaign();
  // Provider.of<CategoryService>(context, listen: false).fetchCategory();
  // Provider.of<RecentCampaignService>(context, listen: false)
  //     .fetchRecentCampaign();
  Provider.of<ProfileService>(context, listen: false).getProfileDetails();
}

runAtStart(BuildContext context) {
  Provider.of<TranslateStringService>(context, listen: false)
      .fetchTranslatedStrings();
  // Provider.of<RtlService>(context, listen: false).fetchDirection();

  // //fetch payment gateway list
  // Provider.of<PaymentChooseService>(context, listen: false).fetchGatewayList();
  // Provider.of<DonateService>(context, listen: false).fetchAmounts(context);
}

gotoProductDetails(BuildContext context, productId) {
  Provider.of<ProductDetailsService>(context, listen: false)
      .fetchProductDetails(context, productId: productId);

  Future.delayed(const Duration(milliseconds: 200), () {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ProductDetailsPage(
          productId: productId,
        ),
      ),
    );
  });
}
