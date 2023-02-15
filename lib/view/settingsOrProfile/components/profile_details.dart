import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name_ecommerce/services/app_string_service.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/view/settingsOrProfile/components/settings_helper.dart';
import 'package:no_name_ecommerce/view/settingsOrProfile/profile_edit_page.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileService>(
      builder: (context, profileProvider, child) => profileProvider
                  .profileDetails !=
              null
          ? profileProvider.profileDetails != 'error'
              ? Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenPadHorizontal),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                        builder: (BuildContext context) =>
                                            const ProfileEditPage(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //profile image
                                      profileImage(
                                          profileProvider
                                                  .profileDetails
                                                  ?.userDetails
                                                  .profileImageUrl ??
                                              userPlaceHolderUrl,
                                          62,
                                          62),

                                      const SizedBox(
                                        width: 15,
                                      ),

                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 12,
                                                ),

                                                //user name
                                                titleCommon(profileProvider
                                                        .profileDetails
                                                        ?.userDetails
                                                        .name ??
                                                    ''),

                                                //phone
                                                paragraphCommon(
                                                  'Member since ${getDateOnly(profileProvider.profileDetails?.userDetails.createdAt) ?? '-'}',
                                                ),
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
                    Consumer<AppStringService>(
                      builder: (context, asProvider, child) => Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenPadHorizontal),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gapH(30),
                              bRow(
                                asProvider.getString("Phone"),
                                '${profileProvider.profileDetails?.userDetails.mobile}',
                                icon: 'assets/svg/phone.svg',
                              ),
                              bRow(
                                asProvider.getString("Email"),
                                '${profileProvider.profileDetails?.userDetails.email}',
                                icon: 'assets/svg/email.svg',
                              ),
                              bRow(asProvider.getString("Country"),
                                  '${profileProvider.profileDetails?.userDetails.country}',
                                  icon: 'assets/svg/location.svg',
                                  lastItem: true),
                            ]),
                      ),
                    ),

                    SettingsHelper().borderBold(35, 8),
                  ],
                )
              : showError(context)
          : Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height - 150,
              child: showLoading(primaryColor),
            ),
    );
  }
}
