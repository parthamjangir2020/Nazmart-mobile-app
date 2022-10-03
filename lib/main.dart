import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_name_ecommerce/services/app_string_service.dart';
import 'package:no_name_ecommerce/services/auth_services/change_pass_service.dart';
import 'package:no_name_ecommerce/services/auth_services/email_verify_service.dart';
import 'package:no_name_ecommerce/services/auth_services/facebook_login_service.dart';
import 'package:no_name_ecommerce/services/auth_services/google_sign_service.dart';
import 'package:no_name_ecommerce/services/auth_services/login_service.dart';
import 'package:no_name_ecommerce/services/auth_services/logout_service.dart';
import 'package:no_name_ecommerce/services/auth_services/reset_password_service.dart';
import 'package:no_name_ecommerce/services/auth_services/signup_service.dart';
import 'package:no_name_ecommerce/services/category_service.dart';
import 'package:no_name_ecommerce/services/country_states_service.dart';
import 'package:no_name_ecommerce/services/coupon_service.dart';
import 'package:no_name_ecommerce/services/payment_services/payment_gateway_list_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/services/rtl_service.dart';
import 'package:no_name_ecommerce/services/slider_service.dart';
import 'package:no_name_ecommerce/view/intro/splash.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

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
        ChangeNotifierProvider(create: (_) => RtlService()),
        ChangeNotifierProvider(create: (_) => CategoryService()),
        ChangeNotifierProvider(create: (_) => SliderService()),
        ChangeNotifierProvider(create: (_) => CouponService()),
        ChangeNotifierProvider(create: (_) => PaymentGatewayListService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          }),
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          buttonTheme:
              ButtonThemeData(buttonColor: ConstantColors().primaryColor),
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: ConstantColors().primaryColor),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
