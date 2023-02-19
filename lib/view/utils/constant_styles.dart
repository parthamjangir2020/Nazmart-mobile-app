import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';

double screenPadHorizontal = 25;

gapH(double value) {
  return SizedBox(
    height: value,
  );
}

gapW(double value) {
  return SizedBox(
    width: value,
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
          style: const TextStyle(
            color: greyParagraph,
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
                style: const TextStyle(
                  color: greyFour,
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
          style: const TextStyle(
            color: greyFour,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      )
    ],
  );
}

bRow(String title, String text, {bool lastItem = false, icon}) {
  return Column(
    children: [
      Row(
        children: [
          //icon
          SizedBox(
            width: 125,
            child: Row(children: [
              icon != null
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
                style: const TextStyle(
                  color: greyFour,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              )
            ]),
          ),

          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: greyFour,
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
              child: dividerCommon(),
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
  if (status.toLowerCase() == 'pending' || status.toLowerCase() == 'open') {
    return successColor;
  } else if (status.toLowerCase() == 'cancel') {
    return Colors.red;
  } else if (status.toLowerCase() == 'complete' ||
      status.toLowerCase() == 'close') {
    return Colors.orange[600];
  } else {
    return Colors.grey[600];
  }
}
