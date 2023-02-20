import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/app_string_service.dart';
import 'package:no_name_ecommerce/view/auth/reset_password/change_password_page.dart';
import 'package:no_name_ecommerce/view/order/my_orders_page.dart';
import 'package:no_name_ecommerce/view/others/privacy_policy_page.dart';
import 'package:no_name_ecommerce/view/others/terms_condition_page.dart';
import 'package:no_name_ecommerce/view/refund_products/refund_products_list_page.dart';
import 'package:no_name_ecommerce/view/settingsOrProfile/components/profile_details.dart';
import 'package:no_name_ecommerce/view/settingsOrProfile/components/settings_helper.dart';
import 'package:no_name_ecommerce/view/settingsOrProfile/profile_edit_page.dart';
import 'package:no_name_ecommerce/view/shipping_address/shipping_address_list_page.dart';
import 'package:no_name_ecommerce/view/support_ticket/my_tickets_page.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Consumer<AppStringService>(
                    builder: (context, asProvider, child) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ProfileDetails(),
                            //Other settings options ========>
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: [
                                SettingsHelper().settingOption(
                                    'assets/svg/message-circle.svg',
                                    asProvider.getString("My orders"), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const MyOrdersPage(),
                                    ),
                                  );
                                }),
                                dividerCommon(),

                                //

                                SettingsHelper().settingOption(
                                    'assets/svg/message-circle.svg',
                                    asProvider.getString("Refund products"),
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const RefundProductsListPage(),
                                    ),
                                  );
                                }),
                                dividerCommon(),

                                //
                                SettingsHelper().settingOption(
                                    'assets/svg/message-circle.svg',
                                    asProvider.getString("Support Ticket"), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const MyTicketsPage(),
                                    ),
                                  );
                                }),
                                dividerCommon(),
                                SettingsHelper().settingOption(
                                    'assets/svg/profile-edit.svg',
                                    asProvider.getString("Edit Profile"), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const ProfileEditPage(),
                                    ),
                                  );
                                }),
                                dividerCommon(),
                                SettingsHelper().settingOption(
                                    'assets/svg/lock-circle.svg',
                                    asProvider.getString("Change Password"),
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const ChangePasswordPage(),
                                    ),
                                  );
                                }),

                                dividerCommon(),
                                SettingsHelper().settingOption(
                                    'assets/svg/profile-edit.svg',
                                    asProvider.getString("Shipping Address"),
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const ShippingAddressListPage(),
                                    ),
                                  );
                                }),

                                dividerCommon(),
                                SettingsHelper().settingOption(
                                    'assets/svg/profile-edit.svg',
                                    asProvider.getString("Terms & Condition"),
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const TermsConditionPage(),
                                    ),
                                  );
                                }),

                                dividerCommon(),
                                SettingsHelper().settingOption(
                                    'assets/svg/profile-edit.svg',
                                    asProvider.getString("Privacy policy"), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const PrivacyPolicyPage(),
                                    ),
                                  );
                                }),
                              ]),
                            ),

                            // logout
                            SettingsHelper().borderBold(12, 5),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: [
                                SettingsHelper().settingOption(
                                    'assets/svg/logout-circle.svg',
                                    asProvider.getString("Logout"), () {
                                  SettingsHelper().logoutPopup(context);
                                }),
                                gapH(20)
                              ]),
                            )
                          ],
                        )),
              ),

              //chat icon ========>
              // Positioned(
              //   right: 20,
              //   bottom: 20,
              //   child: InkWell(
              //     splashColor: Colors.transparent,
              //     highlightColor: Colors.transparent,
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute<void>(
              //           builder: (BuildContext context) => const LiveChatPage(),
              //         ),
              //       );
              //     },
              //     child: Container(
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.grey.withOpacity(0.2),
              //             spreadRadius: 3,
              //             blurRadius: 12,
              //             offset:
              //                 const Offset(0, 5), // changes position of shadow
              //           ),
              //         ],
              //       ),
              //       child: SvgPicture.asset(
              //         'assets/svg/message-green.svg',
              //         height: 48,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
