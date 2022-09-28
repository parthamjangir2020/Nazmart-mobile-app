import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/app_string_service.dart';
import 'package:no_name_ecommerce/services/auth_services/change_pass_service.dart';
import 'package:no_name_ecommerce/services/auth_services/email_verify_service.dart';
import 'package:no_name_ecommerce/services/auth_services/facebook_login_service.dart';
import 'package:no_name_ecommerce/services/auth_services/google_sign_service.dart';
import 'package:no_name_ecommerce/services/auth_services/login_service.dart';
import 'package:no_name_ecommerce/services/auth_services/logout_service.dart';
import 'package:no_name_ecommerce/services/auth_services/reset_password_service.dart';
import 'package:no_name_ecommerce/services/auth_services/signup_service.dart';
import 'package:no_name_ecommerce/services/country_states_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/view/home/home.dart';
import 'package:no_name_ecommerce/view/intro/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginService()),
        ChangeNotifierProvider(create: (_) => SignupService()),
        ChangeNotifierProvider(create: (_) => CountryStatesService()),
        ChangeNotifierProvider(create: (_) => ProfileService()),
        ChangeNotifierProvider(create: (_) => ChangePassService()),
        ChangeNotifierProvider(create: (_) => EmailVerifyService()),
        ChangeNotifierProvider(create: (_) => LogoutService()),
        ChangeNotifierProvider(create: (_) => ResetPasswordService()),
        ChangeNotifierProvider(create: (_) => AppStringService()),
        ChangeNotifierProvider(create: (_) => GoogleSignInService()),
        ChangeNotifierProvider(create: (_) => FacebookLoginService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
