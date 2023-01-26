import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/auth_services/reset_password_service.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';

import 'package:provider/provider.dart';

import '../../view/auth/reset_password/reset_password_page.dart';

class ResetPasswordOtpService {
  checkOtp(enteredOtp, email, BuildContext context) {
    var otp =
        Provider.of<ResetPasswordService>(context, listen: false).otpNumber;
    if (otp != null) {
      if (enteredOtp == otp) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ResetPasswordPage(
              email: email,
            ),
          ),
        );
      } else {
        showToast('Otp didn\'t match', Colors.black);
      }
    } else {
      showToast('Something went wrong', Colors.black);
    }
  }
}
