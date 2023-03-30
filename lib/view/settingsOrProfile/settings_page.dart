import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
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
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
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
                child: Consumer<ProfileService>(
                  builder: (context, profileProvider, child) => Consumer<
                          TranslateStringService>(
                      builder: (context, ln, child) => Column(
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
                                      ln.getString(ConstString.myOrders), () {
                                    if (profileProvider.profileDetails ==
                                        null) {
                                      showToast(
                                          'You must log in to access this feature',
                                          Colors.black);
                                      return;
                                    }
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
                                      ln.getString(ConstString.refundProducts),
                                      () {
                                    if (profileProvider.profileDetails ==
                                        null) {
                                      showToast(
                                          'You must log in to access this feature',
                                          Colors.black);
                                      return;
                                    }
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
                                      ln.getString(ConstString.supportTickets),
                                      () {
                                    if (profileProvider.profileDetails ==
                                        null) {
                                      showToast(
                                          'You must log in to access this feature',
                                          Colors.black);
                                      return;
                                    }
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
                                      ln.getString(ConstString.editProfile),
                                      () {
                                    if (profileProvider.profileDetails ==
                                        null) {
                                      showToast(
                                          'You must log in to access this feature',
                                          Colors.black);
                                      return;
                                    }
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
                                      ln.getString(ConstString.changePass), () {
                                    if (profileProvider.profileDetails ==
                                        null) {
                                      showToast(
                                          'You must log in to access this feature',
                                          Colors.black);
                                      return;
                                    }
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
                                      ln.getString(ConstString.shippingAddress),
                                      () {
                                    if (profileProvider.profileDetails ==
                                        null) {
                                      showToast(
                                          'You must log in to access this feature',
                                          Colors.black);
                                      return;
                                    }
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
                                      ln.getString(ConstString.termsCondition),
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
                                      ln.getString(ConstString.privacyPolicy),
                                      () {
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
                              if (profileProvider.profileDetails != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: SettingsHelper().settingOption(
                                      'assets/svg/logout-circle.svg',
                                      ln.getString(ConstString.logout), () {
                                    SettingsHelper().logoutPopup(context);
                                  }),
                                ),

                              gapH(20),
                            ],
                          )),
                ),
              ),
            ],
          ),
        ));
  }
}
