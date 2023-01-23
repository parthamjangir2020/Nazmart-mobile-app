// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:no_name_ecommerce/services/auth_services/signup_service.dart';
import 'package:no_name_ecommerce/services/rtl_service.dart';
import 'package:no_name_ecommerce/view/auth/signup/signup_helper.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:provider/provider.dart';

class SignupPhonePass extends StatefulWidget {
  const SignupPhonePass(
      {Key? key,
      required this.passController,
      required this.phoneController,
      required this.confirmPassController})
      : super(key: key);

  final passController;
  final confirmPassController;
  final phoneController;

  @override
  _SignupPhonePassState createState() => _SignupPhonePassState();
}

class _SignupPhonePassState extends State<SignupPhonePass> {
  late bool _newpasswordVisible;
  late bool _confirmNewPassswordVisible;

  @override
  void initState() {
    super.initState();
    _newpasswordVisible = false;
    _confirmNewPassswordVisible = false;
  }

  final _formKey = GlobalKey<FormState>();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupService>(
      builder: (context, provider, child) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phone number field
            labelCommon("Phone"),
            Consumer<RtlService>(
              builder: (context, rtlP, child) => IntlPhoneField(
                controller: widget.phoneController,
                decoration: SignupHelper().phoneFieldDecoration(),
                initialCountryCode: provider.countryCode,
                textAlign:
                    rtlP.direction == 'ltr' ? TextAlign.left : TextAlign.right,
                onChanged: (phone) {
                  provider.setCountryCode(phone.countryISOCode);

                  provider.setPhone(phone.number);
                },
              ),
            ),

            //New password =========================>
            labelCommon("Password"),

            Container(
                margin: const EdgeInsets.only(bottom: 19),
                child: TextFormField(
                  controller: widget.passController,
                  textInputAction: TextInputAction.next,
                  obscureText: !_newpasswordVisible,
                  style: const TextStyle(fontSize: 14),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 20.0,
                            width: 40.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/icons/lock.png'),
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                        ],
                      ),
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _newpasswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                          size: 22,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _newpasswordVisible = !_newpasswordVisible;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: inputFieldBorderColor),
                          borderRadius:
                              BorderRadius.circular(globalBorderRadius)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: warningColor)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      hintText: 'Enter password',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 18)),
                )),

            const SizedBox(
              height: 5,
            ),
            //Confirm New password =========================>
            labelCommon("Confirm Password"),

            Container(
                margin: const EdgeInsets.only(bottom: 19),
                child: TextFormField(
                  controller: widget.confirmPassController,
                  textInputAction: TextInputAction.next,
                  obscureText: !_confirmNewPassswordVisible,
                  style: const TextStyle(fontSize: 14),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please retype your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 20.0,
                            width: 40.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/icons/lock.png'),
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                        ],
                      ),
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _confirmNewPassswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                          size: 22,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _confirmNewPassswordVisible =
                                !_confirmNewPassswordVisible;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: inputFieldBorderColor),
                          borderRadius:
                              BorderRadius.circular(globalBorderRadius)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: warningColor)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      hintText: 'Retype password',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 18)),
                )),
          ],
        ),
      ),
    );
  }
}
