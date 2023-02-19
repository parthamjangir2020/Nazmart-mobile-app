import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/app_string_service.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/view/home/components/home_top.dart';
import 'package:no_name_ecommerce/view/campaigns/components/campaign_list.dart';
import 'package:no_name_ecommerce/view/product/components/featured_products.dart';
import 'package:no_name_ecommerce/view/home/components/slider_home.dart';
import 'package:no_name_ecommerce/view/home/homepage_helper.dart';
import 'package:no_name_ecommerce/view/search/search_page.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
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
    runAtHomeScreen(context);
  }

  @override
  Widget build(BuildContext context) {
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
                    gapH(10),

                    //name and profile image
                    const HomeTop(),

                    //Search bar ========>
                    gapH(23),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
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

                    gapH(24),

                    //Slider ========>
                    const SliderHome(),

                    gapH(24),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      margin: const EdgeInsets.only(bottom: 25),
                      child: Column(children: [
                        //Featured product
                        const FeaturedProducts(),

                        gapH(20),

                        //campaign product
                        const CampaignList(),
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
