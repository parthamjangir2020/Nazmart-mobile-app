import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/view/checkout/cart_page.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const Cartpage(),
          ),
        );
      },
      child: Consumer<CartService>(
        builder: (context, p, child) => Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerRight,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
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
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: primaryColor),
                  child: Text(
                    '${p.cartProductsNumber}',
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
