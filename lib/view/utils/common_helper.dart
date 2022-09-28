import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/bottom_nav_service.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:no_name_ecommerce/view/utils/responsive.dart';
import 'package:provider/provider.dart';

class CommonHelper {
  ConstantColors cc = ConstantColors();
  //common appbar
  appbarCommon(String title, BuildContext context, VoidCallback pressed,
      {bool hasBackButton = true}) {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: cc.greyPrimary),
      title: Text(
        title,
        style: TextStyle(
            color: cc.greyPrimary, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: hasBackButton
          ? InkWell(
              onTap: pressed,
              child: const Icon(
                Icons.arrow_back_ios,
                size: 18,
              ),
            )
          : Container(),
    );
  }

  //common orange button =======>
  buttonPrimary(String title, VoidCallback pressed, {isloading = false}) {
    return InkWell(
      onTap: pressed,
      child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              color: cc.primaryColor,
              borderRadius: BorderRadius.circular(globalBorderRadius)),
          child: isloading == false
              ? Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                )
              : OthersHelper().showLoading(Colors.white)),
    );
  }

  labelCommon(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: TextStyle(
          color: cc.greyThree,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  borderButtonPrimary(String title, VoidCallback pressed) {
    return InkWell(
      onTap: pressed,
      child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 17),
          decoration: BoxDecoration(
              border: Border.all(color: cc.primaryColor),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            title,
            style: TextStyle(
              color: cc.primaryColor,
              fontSize: 14,
            ),
          )),
    );
  }

  paragraphCommon(String title,
      {TextAlign textAlign = TextAlign.center,
      double fontsize = 14,
      fontweight = FontWeight.w400}) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
        color: cc.greyParagraph,
        height: 1.4,
        fontSize: fontsize,
        fontWeight: fontweight,
      ),
    );
  }

  titleCommon(String title,
      {double fontsize = 18, fontweight = FontWeight.bold}) {
    return Text(
      title,
      style: TextStyle(
          color: cc.greyPrimary, fontSize: fontsize, fontWeight: fontweight),
    );
  }

  dividerCommon() {
    return Divider(
      thickness: 1,
      height: 2,
      color: cc.borderColor,
    );
  }

  checkCircle() {
    return Container(
      padding: const EdgeInsets.all(3),
      child: const Icon(
        Icons.check,
        size: 13,
        color: Colors.white,
      ),
      decoration: BoxDecoration(shape: BoxShape.circle, color: cc.primaryColor),
    );
  }

  profileImage(String imageLink, double height, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: CachedNetworkImage(
        imageUrl: imageLink,
        placeholder: (context, url) {
          return Image.asset('assets/images/placeholder.png');
        },
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }

  //no order found
  nothingfound(BuildContext context, String title) {
    return Container(
      alignment: Alignment.center,
      height: screenHeight - 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hourglass_empty,
            color: cc.greyFour,
          ),
          sizedboxCustom(10),
          Text(title),
        ],
      ),
    );
  }
}

// snackbar
showSnackBar(BuildContext context, String msg, color) {
  var snackBar = SnackBar(
    content: Text(msg),
    backgroundColor: color,
    duration: const Duration(milliseconds: 900),
  );

  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
