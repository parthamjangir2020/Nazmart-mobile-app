import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';

ConstantColors cc = ConstantColors();

double screenPadHorizontal = 25;

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

paragraphCommon(String title, {textAlign = TextAlign.left, color}) {
  return Text(
    title,
    textAlign: textAlign,
    style: TextStyle(
      color: color ?? cc.greyParagraph,
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

bRow(String icon, String title, String text, {bool lastItem = false}) {
  return Column(
    children: [
      Row(
        children: [
          //icon
          SizedBox(
            width: 125,
            child: Row(children: [
              icon != 'null'
                  ? Row(
                      children: [
                        SvgPicture.asset(
                          icon,
                          height: 19,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                      ],
                    )
                  : Container(),
              Text(
                title,
                style: TextStyle(
                  color: cc.greyFour,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              )
            ]),
          ),

          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: cc.greyFour,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      lastItem == false
          ? Container(
              margin: const EdgeInsets.symmetric(vertical: 14),
              child: CommonHelper().dividerCommon(),
            )
          : Container()
    ],
  );
}

capsule(String capsuleText) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 11),
    decoration: BoxDecoration(
        color: getCapsuleColor(capsuleText).withOpacity(.1),
        borderRadius: BorderRadius.circular(4)),
    child: Text(
      capsuleText,
      style: TextStyle(
          color: getCapsuleColor(capsuleText),
          fontWeight: FontWeight.w600,
          fontSize: 12),
    ),
  );
}

getCapsuleColor(String status) {
  ConstantColors cc = ConstantColors();

  if (status.toLowerCase() == 'pending') {
    return const Color(0xff5463FF);
  } else if (status.toLowerCase() == 'cancel') {
    return Colors.red;
  } else {
    return cc.primaryColor;
  }
}
