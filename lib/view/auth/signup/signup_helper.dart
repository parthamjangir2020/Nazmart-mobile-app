import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/auth/login/login.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';

class SignupHelper {
  haveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: 'Have an account?  ',
            style: const TextStyle(color: Color(0xff646464), fontSize: 14),
            children: <TextSpan>[
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                  text: 'Sign in',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: primaryColor,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  //
  phoneFieldDecoration() {
    return InputDecoration(
        labelText: 'Phone Number',
        filled: true,
        fillColor: Colors.transparent,

        // hintTextDirection: TextDirection.rtl,
        labelStyle: TextStyle(color: greyFour, fontSize: 14),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: inputFieldBorderColor),
            borderRadius: BorderRadius.circular(globalBorderRadius)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: warningColor)),
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
        hintText: 'Enter phone number',
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 18));
  }
}
