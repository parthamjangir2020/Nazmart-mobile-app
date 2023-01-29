import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/auth_services/login_service.dart';
import 'package:no_name_ecommerce/view/auth/login/components/login_slider.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';

import 'package:provider/provider.dart';

import '../reset_password/reset_pass_email_page.dart';
import '../signup/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LoginSlider(
                title: 'Login to continue',
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 33,
                      ),

                      //Name ============>
                      labelCommon("Email or username"),

                      CustomInput(
                        controller: emailController,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        hintText: "Email",
                        icon: 'assets/icons/user.png',
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      //password ===========>
                      labelCommon("Password"),

                      Container(
                          margin: const EdgeInsets.only(bottom: 19),
                          child: TextFormField(
                            controller: passwordController,
                            textInputAction: TextInputAction.next,
                            obscureText: !_passwordVisible,
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
                                      height: 19.0,
                                      width: 40.0,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icons/lock.png'),
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
                                    _passwordVisible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.grey,
                                    size: 22,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: inputFieldBorderColor),
                                    borderRadius: BorderRadius.circular(
                                        globalBorderRadius)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(
                                        globalBorderRadius)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        globalBorderRadius),
                                    borderSide:
                                        const BorderSide(color: warningColor)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(
                                        globalBorderRadius)),
                                hintText: 'Enter password',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 18)),
                          )),

                      // =================>
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //keep logged in checkbox
                          Expanded(
                            child: CheckboxListTile(
                              checkColor: Colors.white,
                              activeColor: primaryColor,
                              contentPadding: const EdgeInsets.all(0),
                              title: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: const Text(
                                  "Remember me",
                                  style: TextStyle(
                                      color: greyFour,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                              value: keepLoggedIn,
                              onChanged: (newValue) {
                                setState(() {
                                  keepLoggedIn = !keepLoggedIn;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const ResetPassEmailPage(),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 122,
                              height: 40,
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),

                      //Login button ==================>
                      const SizedBox(
                        height: 13,
                      ),

                      Consumer<LoginService>(
                        builder: (context, provider, child) =>
                            buttonPrimary("Login", () {
                          if (provider.isloading == false) {
                            if (_formKey.currentState!.validate()) {
                              provider.login(
                                  emailController.text.trim(),
                                  passwordController.text,
                                  context,
                                  keepLoggedIn);
                            }
                            // Navigator.pushReplacement<void, void>(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) =>
                            //         const LandingPage(),
                            //   ),
                            // );
                          }
                        }, isloading: provider.isloading, borderRadius: 100),
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Don\'t have account?  ',
                              style: const TextStyle(
                                  color: Color(0xff646464), fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignupPage()));
                                      },
                                    text: 'Register',
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

                      // Divider (or)
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      // SizedBox(
                      //     height: 50,
                      //     child: Stack(
                      //       children: [
                      //         Container(
                      //           height: 1,
                      //           margin: const EdgeInsets.only(top: 12),
                      //           width: double.infinity,
                      //           color: borderColor,
                      //         ),

                      //         //or
                      //         Positioned.fill(
                      //           child: Align(
                      //             alignment: Alignment.topCenter,
                      //             child: Container(
                      //               width: 47,
                      //               height: 30,
                      //               alignment: Alignment.center,
                      //               margin: const EdgeInsets.only(bottom: 25),
                      //               // padding: const EdgeInsets.symmetric(
                      //               //     horizontal: 7, vertical: 3),
                      //               decoration: BoxDecoration(
                      //                   color: Colors.white,
                      //                   border:
                      //                       Border.all(color: borderColor),
                      //                   borderRadius:
                      //                       BorderRadius.circular(30)),
                      //               child: Text(
                      //                 "OR",
                      //                 style: TextStyle(
                      //                     color: greyParagraph,
                      //                     fontSize: 16,
                      //                     fontWeight: FontWeight.w600),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     )),

                      // // login with google, facebook button ===========>
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Consumer<GoogleSignInService>(
                      //   builder: (context, gProvider, child) => InkWell(
                      //       onTap: () {
                      //         if (gProvider.isloading == false) {
                      //           gProvider.googleLogin(context);
                      //         }
                      //       },
                      //       child: LoginHelper().commonButton(
                      //           'assets/icons/google.png', "Login with Google",
                      //           isloading: gProvider.isloading == false
                      //               ? false
                      //               : true)),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Consumer<FacebookLoginService>(
                      //   builder: (context, fProvider, child) => InkWell(
                      //     onTap: () {
                      //       if (fProvider.isloading == false) {
                      //         fProvider.checkIfLoggedIn(context);
                      //       }
                      //     },
                      //     child: LoginHelper().commonButton(
                      //         'assets/icons/facebook.png',
                      //         "Login with Facebook",
                      //         isloading:
                      //             fProvider.isloading == false ? false : true),
                      //   ),
                      // ),

                      // const SizedBox(
                      //   height: 30,
                      // ),
                    ],
                  ),
                ),
              )
              // }
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
