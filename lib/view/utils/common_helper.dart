import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:no_name_ecommerce/view/utils/responsive.dart';

//common appbar
appbarCommon(String title, BuildContext context, VoidCallback pressed,
    {bool hasBackButton = true, bool centerTitle = true}) {
  return AppBar(
    centerTitle: centerTitle ? true : false,
    iconTheme: const IconThemeData(color: greyPrimary),
    title: Text(
      title,
      style: const TextStyle(
          color: greyPrimary, fontSize: 16, fontWeight: FontWeight.w600),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: hasBackButton
        ? InkWell(
            onTap: pressed,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: SvgPicture.asset(
                'assets/svg/arrow-back-circle.svg',
                height: 40,
              ),
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
      style: const TextStyle(
        color: greyThree,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

//common primary button =======>
buttonPrimary(String title, VoidCallback pressed,
    {isloading = false,
    bgColor,
    double paddingVertical = 18,
    double borderRadius = 8,
    double fontsize = 14,
    fontColor = Colors.white}) {
  return InkWell(
    onTap: pressed,
    child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: paddingVertical),
        decoration: BoxDecoration(
            color: bgColor ?? primaryColor,
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
    fontweight = FontWeight.w400,
    lineHeight = 1.4,
    color}) {
  return Text(
    title,
    textAlign: textAlign,
    style: TextStyle(
      color: color ?? greyParagraph,
      height: lineHeight,
      fontSize: fontsize,
      fontWeight: fontweight,
    ),
  );
}

titleCommon(String title,
    {double fontsize = 18, fontweight = FontWeight.bold, color}) {
  return Text(
    title,
    style: TextStyle(
        color: color ?? greyPrimary,
        fontSize: fontsize,
        fontWeight: fontweight),
  );
}

dividerCommon() {
  return const Divider(
    thickness: 1,
    height: 2,
    color: borderColor,
  );
}

checkCircle() {
  return Container(
    padding: const EdgeInsets.all(3),
    decoration:
        const BoxDecoration(shape: BoxShape.circle, color: primaryColor),
    child: const Icon(
      Icons.check,
      size: 13,
      color: Colors.white,
    ),
  );
}

profileImage(String imageLink, double height, double width) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(500),
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
        const Icon(
          Icons.hourglass_empty,
          color: greyFour,
        ),
        sizedboxCustom(10),
        Text(title),
      ],
    ),
  );
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
