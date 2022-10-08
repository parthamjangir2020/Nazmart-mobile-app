import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name_ecommerce/services/app_string_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/view/order/my_orders_page.dart';
import 'package:no_name_ecommerce/view/settingsOrProfile/components/settings_helper.dart';
import 'package:no_name_ecommerce/view/settingsOrProfile/profile_edit_page.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
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
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Consumer<AppStringService>(
                  builder: (context, asProvider, child) => Consumer<
                          ProfileService>(
                      builder: (context, profileProvider, child) =>
                          // profileProvider.profileDetails != null
                          //     ? profileProvider.profileDetails != 'error'
                          //         ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenPadHorizontal),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //profile image, name ,desc
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          //Profile image section =======>
                                          InkWell(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (BuildContext
                                                          context) =>
                                                      const ProfileEditPage(),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //profile image

                                                // profileProvider
                                                //             .profileImage !=
                                                //         null
                                                //     ? CommonHelper()
                                                //         .profileImage(
                                                //             profileProvider
                                                //                 .profileImage,
                                                //             62,
                                                //             62)
                                                //     :
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.asset(
                                                    'assets/images/avatar.png',
                                                    height: 62,
                                                    width: 62,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  width: 15,
                                                ),

                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 12,
                                                          ),

                                                          //user name
                                                          CommonHelper()
                                                              .titleCommon(
                                                                  'Saleheen'),

                                                          //phone
                                                          CommonHelper()
                                                              .paragraphCommon(
                                                                  'Member since 2022',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center),
                                                        ],
                                                      ),

                                                      const SizedBox(
                                                        width: 15,
                                                      ),

                                                      //profile edit button
                                                      SvgPicture.asset(
                                                          'assets/svg/edit-orange.svg')
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      //
                                    ]),
                              ),

                              // Personal information ==========>
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenPadHorizontal),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      sizedboxCustom(30),
                                      bRow(
                                          'assets/svg/phone.svg',
                                          asProvider.getString("Phone"),
                                          '01246852511'),
                                      bRow(
                                          'assets/svg/email.svg',
                                          asProvider.getString("Email"),
                                          'es@email.com'),
                                      bRow(
                                          'assets/svg/location.svg',
                                          asProvider.getString("Country"),
                                          'Bangladesh'),
                                      bRow(
                                          'assets/svg/location.svg',
                                          asProvider.getString("Post code"),
                                          '1020',
                                          lastItem: true),
                                    ]),
                              ),

                              SettingsHelper().borderBold(35, 8),

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
                                  CommonHelper().dividerCommon(),
                                  SettingsHelper().settingOption(
                                      'assets/svg/message-circle.svg',
                                      asProvider.getString("Support Ticket"),
                                      () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute<void>(
                                    //     builder:
                                    //         (BuildContext context) =>
                                    //             const MyTicketsPage(),
                                    //   ),
                                    // );
                                  }),
                                  CommonHelper().dividerCommon(),
                                  SettingsHelper().settingOption(
                                      'assets/svg/profile-edit.svg',
                                      asProvider.getString("Edit Profile"), () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute<void>(
                                    //     builder:
                                    //         (BuildContext context) =>
                                    //             const ProfileEditPage(),
                                    //   ),
                                    // );
                                  }),
                                  CommonHelper().dividerCommon(),
                                  SettingsHelper().settingOption(
                                      'assets/svg/lock-circle.svg',
                                      asProvider.getString("Change Password"),
                                      () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute<void>(
                                    //     builder: (BuildContext
                                    //             context) =>
                                    //         const ChangePasswordPage(),
                                    //   ),
                                    // );
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
                                  sizedboxCustom(20)
                                ]),
                              )
                            ],
                          )
                      //     : OthersHelper().showError(context)
                      // : Container(
                      //     alignment: Alignment.center,
                      //     height:
                      //         MediaQuery.of(context).size.height - 150,
                      //     child:
                      //         OthersHelper().showLoading(cc.primaryColor),
                      //   ),
                      ),
                ),
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
