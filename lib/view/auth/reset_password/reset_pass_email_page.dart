import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/auth_services/reset_password_service.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';

import 'package:provider/provider.dart';

class ResetPassEmailPage extends StatefulWidget {
  const ResetPassEmailPage({Key? key}) : super(key: key);

  @override
  _ResetPassEmailPageState createState() => _ResetPassEmailPageState();
}

class _ResetPassEmailPageState extends State<ResetPassEmailPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon('Reset password', context, () {
        Navigator.pop(context);
      }),
      backgroundColor: Colors.white,
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            height: MediaQuery.of(context).size.height - 120,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 33,
                      ),
                      const Text(
                        "Reset password",
                        style: TextStyle(
                            color: greyPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      paragraphCommon(
                          "Enter the email you used to creat account and we’ll send instruction for restting password",
                          textAlign: TextAlign.start),

                      const SizedBox(
                        height: 33,
                      ),

                      //Name ============>
                      labelCommon("Enter Email"),

                      CustomInput(
                        controller: emailController,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        hintText: "Email",
                        icon: 'assets/icons/email.png',
                        textInputAction: TextInputAction.next,
                      ),

                      //Login button ==================>
                      const SizedBox(
                        height: 13,
                      ),
                      Consumer<ResetPasswordService>(
                        builder: (context, provider, child) =>
                            buttonPrimary("Send Instructions", () {
                          if (provider.isloading == false) {
                            if (_formKey.currentState!.validate()) {
                              provider.sendOtp(
                                  emailController.text.trim(), context);
                            }
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) =>
                            //         ResetPassOtpPage(
                            //       email: emailController.text,
                            //     ),
                            //   ),
                            // );
                          }
                        },
                                isloading:
                                    provider.isloading == false ? false : true,
                                borderRadius: 100),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
