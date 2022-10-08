import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:no_name_ecommerce/services/app_string_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/view/checkout/cart_page.dart';
import 'package:no_name_ecommerce/view/home/all_categories_page.dart';
import 'package:no_name_ecommerce/view/home/components/categories.dart';
import 'package:no_name_ecommerce/view/product/components/featured_products.dart';
import 'package:no_name_ecommerce/view/home/components/section_title.dart';
import 'package:no_name_ecommerce/view/home/components/slider_home.dart';
import 'package:no_name_ecommerce/view/home/homepage_helper.dart';
import 'package:no_name_ecommerce/view/search/search_page.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: globalPhysics,
            child: Consumer<AppStringService>(
              builder: (context, asProvider, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedboxCustom(10),
                    // co
                    //name and profile image
                    // Consumer<ProfileService>(
                    //     builder: (context, profileProvider, child) =>
                    //         // profileProvider.profileDetails != null
                    //         //     ? profileProvider.profileDetails != 'error'
                    //         //         ?
                    InkWell(
                      // onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute<void>(
                      //     builder: (BuildContext context) =>
                      //         const ProfileEditPage(),
                      //   ),
                      // );
                      // },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            //name
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${asProvider.getString('Hi,')}',
                                  style: TextStyle(
                                    color: cc.greyParagraph,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Saleheen',
                                  style: TextStyle(
                                    color: cc.blackCustomColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),

                            //profile image
                            // profileProvider.profileImage != null
                            //     ? CommonHelper().profileImage(
                            //         profileProvider
                            //             .profileImage,
                            //         52,
                            //         52)
                            //     :

                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(8),
                            //   child: Image.asset(
                            //     'assets/images/avatar.png',
                            //     height: 52,
                            //     width: 52,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),

                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const Cartpage(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 70, top: 5, bottom: 5),
                                child: SvgPicture.asset(
                                  'assets/svg/cart.svg',
                                  height: 27,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //     //     : Text(asProvider.getString(
                    //     //         'Could not load user profile info'))
                    //     // : Container(),
                    //     ),

                    //Search bar ========>
                    sizedboxCustom(23),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const SearchPage(),
                              ),
                            );
                          },
                          child:
                              HomepageHelper().searchbar(asProvider, context)),
                    ),

                    sizedboxCustom(10),

                    ///============>
                    ///Categories

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          SectionTitle(
                            cc: cc,
                            title: 'Categories',
                            pressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const AllCategoriesPage()),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Categories(marginRight: 20),
                        ],
                      ),
                    ),

                    sizedboxCustom(24),

                    //Slider ========>
                    const SliderHome(),

                    sizedboxCustom(24),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      margin: const EdgeInsets.only(bottom: 25),
                      child: Column(children: const [
                        //Featured product
                        FeaturedProducts()
                      ]),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
