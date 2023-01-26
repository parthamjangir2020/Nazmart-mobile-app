import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';

class LoginHelper {
  commonButton(String icon, String title, {isloading = false}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: greyFive),
          borderRadius: BorderRadius.circular(globalBorderRadius)),
      alignment: Alignment.center,
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 20.0,
            width: 30.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(icon), fit: BoxFit.fitHeight),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          isloading == false
              ? Text(
                  title,
                  style: TextStyle(color: greyFour),
                )
              : showLoading(primaryColor),
        ],
      ),
    );
  }
}
