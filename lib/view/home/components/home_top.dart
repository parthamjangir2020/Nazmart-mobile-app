import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/services/bottom_nav_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/view/checkout/components/cart_icon.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:provider/provider.dart';

class HomeTop extends StatelessWidget {
  const HomeTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TranslateStringService>(
      builder: (context, ln, child) => Consumer<ProfileService>(
        builder: (context, profileProvider, child) =>
            profileProvider.profileDetails != null
                ? profileProvider.profileDetails != 'error'
                    ? InkWell(
                        onTap: () {
                          Provider.of<BottomNavService>(context, listen: false)
                              .setCurrentIndex(3);
                        },
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
                                    '${ln.getString('Hi,')}',
                                    style: const TextStyle(
                                      color: greyParagraph,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    profileProvider
                                            .profileDetails?.userDetails.name ??
                                        '',
                                    style: const TextStyle(
                                      color: blackCustomColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )),

                              //Cart icon
                              const CartIcon()
                            ],
                          ),
                        ),
                      )
                    : Text(ln.getString('Could not load user profile info'))
                : Container(),
      ),
    );
  }
}
