import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name_ecommerce/view/checkout/cart_page.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const Cartpage(),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 70, top: 5, bottom: 5),
            child: SvgPicture.asset(
              'assets/svg/cart.svg',
              height: 27,
            ),
          ),
          Positioned(
              top: -5,
              right: -10,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: cc.primaryColor),
                child: const Text(
                  '1',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ))
        ],
      ),
    );
  }
}
