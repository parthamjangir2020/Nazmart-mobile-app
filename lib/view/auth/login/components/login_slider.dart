import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/responsive.dart';

class LoginSlider extends StatelessWidget {
  const LoginSlider({
    Key? key,
    required this.title,
  }) : super(key: key);

  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF9FAFB),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      width: double.infinity,
      height: screenHeight / 4 - 10,
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/hi.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleCommon('Welcome,',
                  fontsize: 18, fontweight: FontWeight.w600),
              titleCommon(title, fontsize: 20, fontweight: FontWeight.w600),
            ],
          )
        ],
      ),
    );
  }
}
