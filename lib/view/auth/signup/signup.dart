import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/auth_services/signup_service.dart';
import 'package:no_name_ecommerce/view/auth/login/components/login_slider.dart';
import 'package:no_name_ecommerce/view/auth/signup/components/country_states_dropdowns.dart';
import 'package:no_name_ecommerce/view/auth/signup/pages/signup_phone_pass.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';
import 'components/email_name_fields.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({
    Key? key,
  }) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool termsAgree = false;

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: SingleChildScrollView(
          physics: globalPhysics,
          child: Listener(
            onPointerDown: (_) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.focusedChild?.unfocus();
              }
            },
            child: Consumer<SignupService>(
              builder: (context, provider, child) => Column(
                children: [
                  const LoginSlider(
                    title: 'Sign up to continue',
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(
                          //   height: 33,
                          // ),
                          // titleCommon("Register to join us"),
                          const SizedBox(
                            height: 19,
                          ),

                          EmailNameFields(
                            fullNameController: fullNameController,
                            userNameController: userNameController,
                            emailController: emailController,
                          ),

                          const SizedBox(
                            height: 4,
                          ),

                          //Country dropdown =====>
                          const CountryStatesDropdowns(),

                          sizedboxCustom(20),

                          // ==============>

                          //city ============>
                          labelCommon("City"),

                          CustomInput(
                            controller: cityController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your city';
                              }
                              return null;
                            },
                            hintText: "Enter your city",
                            paddingHorizontal: 20,
                            textInputAction: TextInputAction.next,
                          ),

                          SignupPhonePass(
                            passController: passwordController,
                            confirmPassController: confirmPasswordController,
                            phoneController: phoneController,
                          ),

                          //Agreement checkbox ===========>

                          CheckboxListTile(
                            checkColor: Colors.white,
                            activeColor: primaryColor,
                            contentPadding: const EdgeInsets.all(0),
                            title: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: const Text(
                                "I agree with the terms and conditons",
                                style: TextStyle(
                                    color: greyFour,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            ),
                            value: termsAgree,
                            onChanged: (newValue) {
                              setState(() {
                                termsAgree = !termsAgree;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          // sign up button
                          const SizedBox(
                            height: 10,
                          ),
                          buttonPrimary("Sign up", () {
                            if (_formKey.currentState!.validate()) {
                              if (termsAgree == false) {
                                showToast(
                                    'You must agree with the terms and conditions to register',
                                    Colors.black);
                              } else if (passwordController.text !=
                                  confirmPasswordController.text) {
                                showToast(
                                    'Password didn\'t match', Colors.black);
                              } else if (passwordController.text.length < 6) {
                                showToast(
                                    'Password must be at least 6 characters',
                                    Colors.black);
                              } else if (phoneController.text.trim().isEmpty) {
                                showToast(
                                    'You must enter a phone', Colors.black);
                              } else {
                                if (provider.isloading == false) {
                                  provider.signup(context,
                                      fullName: fullNameController.text,
                                      userName: userNameController.text,
                                      cityName: cityController.text,
                                      email: emailController.text,
                                      mobile: phoneController.text,
                                      password: passwordController.text);
                                }
                              }
                            }
                          }, isloading: provider.isloading),

                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Already have an account?  ',
                                  style: const TextStyle(
                                      color: Color(0xff646464), fontSize: 14),
                                  children: <TextSpan>[
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pop(context);
                                          },
                                        text: 'Login',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: primaryColor,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
