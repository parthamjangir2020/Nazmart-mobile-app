import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:no_name_ecommerce/view/utils/responsive.dart';

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

  //==========>
  greyButton(String title, {double verticalPadding = 20}) {
    return Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        decoration: BoxDecoration(
            color: const Color(0xffEAECF0),
            borderRadius: BorderRadius.circular(100)),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xff667085),
            fontSize: 14,
          ),
        ));
  }

  //common orange button =======>
  buttonPrimary(String title, VoidCallback pressed,
      {isloading = false,
      bgColor,
      double paddingVertical = 18,
      double borderRadius = 8,
      double fontsize = 14,
      Color fontColor = Colors.white}) {
    return InkWell(
      onTap: pressed,
      child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: paddingVertical),
          decoration: BoxDecoration(
              color: bgColor ?? cc.primaryColor,
              borderRadius: BorderRadius.circular(borderRadius)),
          child: isloading == false
              ? Text(
                  title,
                  style: TextStyle(
                    color: fontColor,
                    fontSize: fontsize,
                  ),
                )
              : OthersHelper().showLoading(Colors.white)),
    );
  }

  borderButtonPrimary(
    String title,
    VoidCallback pressed, {
    double paddingVertical = 17,
    double fontsize = 14,
    double borderRadius = 8,
    Color color = Colors.grey,
    Color borderColor = Colors.grey,
  }) {
    return InkWell(
      onTap: pressed,
      child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: paddingVertical),
          decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(borderRadius)),
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: fontsize,
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
