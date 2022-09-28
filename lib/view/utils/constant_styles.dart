import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';

ConstantColors cc = ConstantColors();

double screenPadHorizontal = 25;

var physicsCommon = const BouncingScrollPhysics();

sizedboxCustom(double value) {
  return SizedBox(
    height: value,
  );
}

dividerCommon() {
  return Divider(
    thickness: 1,
    height: 2,
    color: cc.borderColor,
  );
}

paragraphCommon(String title, TextAlign textAlign) {
  return Text(
    title,
    textAlign: textAlign,
    style: TextStyle(
      color: cc.greyParagraph,
      height: 1.5,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );
}

commonImage(String imageLink, double height, double width) {
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

detailsRow(String title, int quantity, String price) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 3,
        child: Text(
          title,
          style: TextStyle(
            color: cc.greyParagraph,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      quantity != 0
          ? Expanded(
              flex: 1,
              child: Text(
                'x$quantity',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: cc.greyFour,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ))
          : Container(),
      Expanded(
        flex: 2,
        child: AutoSizeText(
          price,
          maxLines: 1,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: cc.greyFour,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      )
    ],
  );
}

paragraphStyleTitle(String title) {
  return Text(
    title,
    style: TextStyle(
      color: cc.greyFour,
      fontSize: 13,
    ),
  );
}
